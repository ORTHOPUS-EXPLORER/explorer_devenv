FROM ghcr.io/orthopus-explorer/ros-iron-explorer-ws/dev:latest

ENV EXPLORER_DEVENV_DIR=/opt/explorer-devenv
ENV PATH="${EXPLORER_DEVENV_DIR}:${EXPLORER_DEVENV_DIR}/impedance:${EXPLORER_DEVENV_DIR}/tools:${EXPLORER_DEVENV_DIR}/tests:${PATH}"

WORKDIR ${EXPLORER_DEVENV_DIR}

COPY build.sh build_clean.sh clean.sh rosdep_install.sh killall.sh \
     enable_pos_all.sh \
     actuator_effort.sh actuator_pos.sh actuator_velocity.sh \
     explorer_cartesian_real.sh explorer_cartesian_real_spacenav.sh explorer_cartesian_real_spacenav_2.sh explorer_cartesian_sim.sh \
     explorer_joint_real.sh explorer_joint_sim.sh explorer_mode_0.sh \
     setcan0_1M.sh setvcan_cont.sh \
     ./
COPY impedance/ ./impedance/
COPY tools/ ./tools/
COPY tests/ ./tests/

RUN chmod +x *.sh impedance/*.sh tools/*.sh tests/*.sh

WORKDIR $ROS_WS
