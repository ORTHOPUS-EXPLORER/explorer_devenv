## Overridable ROS distro argument (generic)
ARG ROS_DISTRO=iron

## Base Image

FROM osrf/ros:${ROS_DISTRO}-desktop

## Dependencies

RUN apt update && apt install -y --no-install-recommends\
    can-utils \
    iproute2 \
    python3-pip \
    ros-${ROS_DISTRO}-plotjuggler \
    ros-${ROS_DISTRO}-plotjuggler-ros \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    terminator \
    tmux \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY . /src/
WORKDIR /src

RUN apt update && \
    rosdep install -i -y --from-paths . \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /src/source.sh" >> ~/.bashrc
RUN chmod +x /src/entrypoint.sh

ENTRYPOINT ["/src/entrypoint.sh"]
