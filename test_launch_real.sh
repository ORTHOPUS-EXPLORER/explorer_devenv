#!/bin/bash

PASS=0
FAIL=0
TRIES=100

# Wait time for OpenGL and integrator messages (in seconds)
TIMEOUT=120
TIMEOUT2=20

for ((i=1; i<=$TRIES; i++))
do
    echo "Test run $i:"

    ./killall.sh >/dev/null 2>&1
    pkill -f gazebo >/dev/null 2>&1
    pkill -f ros2 >/dev/null 2>&1
    sleep 2

    LOGFILE="launch_log_run_${i}.txt"

    (ros2 launch ros2_control_explorer explorer_cartesian.launch.py can_port:='can0' spacenav:=false) > "$LOGFILE" 2>&1 &
    LAUNCH_PID=$!

    # Wait up to TIMEOUT seconds for the OpenGL line
    OPENGL_FOUND=0
    for ((t=0; t<$TIMEOUT; t++)); do
        if grep -q "OpenGl version: 4.6 (GLSL 4.6)" "$LOGFILE"; then
            OPENGL_FOUND=1
            break
        fi
        if ! kill -0 $LAUNCH_PID 2>/dev/null; then
            break
        fi
        sleep 1
    done

    if [[ $OPENGL_FOUND -eq 1 ]]; then
        # Now wait up to TIMEOUT seconds for both integrator messages to appear anywhere in log
        INTEGRATORS_FOUND=0
        for ((t=0; t<$TIMEOUT2; t++)); do
            INPUT_FOUND=$(grep "input_integrator_initialized" "$LOGFILE")
            OUTPUT_FOUND=$(grep "output_integrator_initialized" "$LOGFILE")
            if [[ -n "$INPUT_FOUND" && -n "$OUTPUT_FOUND" ]]; then
                INTEGRATORS_FOUND=1
                break
            fi
            if ! kill -0 $LAUNCH_PID 2>/dev/null; then
                break
            fi
            sleep 1
        done

        if [[ $INTEGRATORS_FOUND -eq 1 ]]; then
            echo "PASS"
            PASS=$((PASS+1))
        else
            echo "FAIL (one or both _integrator_initialized lines did not appear in $TIMEOUT2 seconds after OpenGL)"
            echo "Found in log:"
            grep "integrator_initialized" "$LOGFILE"
            FAIL=$((FAIL+1))
        fi
    else
        echo "FAIL (rviz2 OpenGL not found in $TIMEOUT seconds)"
        FAIL=$((FAIL+1))
    fi

    kill $LAUNCH_PID 2>/dev/null
    pkill -f gazebo >/dev/null 2>&1
    pkill -f ros2 >/dev/null 2>&1
    sleep 2
done

echo "------"
echo "Total runs: $TRIES"
echo "Passes: $PASS"
echo "Fails: $FAIL"
echo "Log files for each run are named launch_log_run_1.txt ... launch_log_run_$TRIES.txt"

