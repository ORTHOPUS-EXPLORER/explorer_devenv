#!/bin/bash

PASS=0
FAIL=0
TRIES=10

for ((i=1; i<=$TRIES; i++))
do
    echo -n "Test run $i: "

    ./killall.sh >/dev/null 2>&1
    pkill -f gazebo >/dev/null 2>&1
    pkill -f ros2 >/dev/null 2>&1
    sleep 2

    TMPFILE=$(mktemp)

    # Start the launch, no terminal output
    (ros2 launch ros2_control_explorer cartesian_control.launch.py spacenav:=false) > "$TMPFILE" 2>&1 &
    LAUNCH_PID=$!

    # Wait up to 120 seconds for the rviz2 OpenGL line
    FOUND=0
    for ((t=0; t<120; t++)); do
        if grep -q "OpenGl version: 4.6 (GLSL 4.6)" "$TMPFILE"; then
            FOUND=1
            break
        fi
        if ! kill -0 $LAUNCH_PID 2>/dev/null; then
            break
        fi
        sleep 1
    done

    if [[ $FOUND -eq 1 ]]; then
        echo
        echo "--------------------------------------"
        echo "Iteration $i: Detected OpenGL initialization."
        echo "Check output (log in $TMPFILE if needed)."
        read -p "Did this test PASS? (y/n): " yn
        if [[ "$yn" =~ ^[Yy] ]]; then
            echo "PASS"
            PASS=$((PASS+1))
        else
            echo "FAIL"
            FAIL=$((FAIL+1))
        fi
    else
        echo "FAIL (rviz2 OpenGL not found in time)"
        FAIL=$((FAIL+1))
    fi

    kill $LAUNCH_PID 2>/dev/null
    pkill -f gazebo >/dev/null 2>&1
    pkill -f ros2 >/dev/null 2>&1
    sleep 2
    rm -f "$TMPFILE"
done

echo "------"
echo "Total runs: $TRIES"
echo "Passes: $PASS"
echo "Fails: $FAIL"

