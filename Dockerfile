## Overridable ROS distro argument (generic)
ARG ROS_DISTRO=iron
ARG ENVIRONMENT=dev

## Multi stage build

##  ---------------- Base / cache part ---------------- 
FROM osrf/ros:${ROS_DISTRO}-desktop AS explorer_cacher

## Overwrite apt-get defaults to prevent rosdep from installing optional packages
RUN rosdep update --rosdistro $ROS_DISTRO && \
    cat <<EOF > /etc/apt/apt.conf.d/docker-clean && apt-get update
APT::Install-Recommends "false";
APT::Install-Suggests "false";
EOF

WORKDIR /src
COPY . /src/

## Derive build/exec dependencies into a /tmp/[build|exec]_dependencies.txt
## Taken from an official ROS image
RUN bash -e <<'EOF'
declare -A types=(
  [exec]="--dependency-types=exec"
  [build]="")
for type in "${!types[@]}"; do
  rosdep install -y \
    --from-paths . \
    --ignore-src \
    --reinstall \
    --simulate \
    ${types[$type]} \
    | grep 'apt-get install' \
    | awk '{gsub(/'\''/,"",$4); print $4}' \
    | sort -u > /tmp/${type}_dependencies.txt
done
EOF


##  ---------------- Builder part (CI)---------------- 
# Lighter image for CI/CD
FROM amd64/ros:${ROS_DISTRO}-ros-base AS explorer_builder
LABEL org.opencontainers.image.source=https://github.com/ORTHOPUS-EXPLORER/explorer_devenv
LABEL org.opencontainers.image.description="CI/CD image for Orthopus Explorer project"
# LABEL org.opencontainers.image.licenses=

COPY --from=explorer_cacher /tmp/build_dependencies.txt /tmp/build_dependencies.txt
RUN --mount=type=cache,target=/etc/apt/apt.conf.d,from=explorer_cacher,source=/etc/apt/apt.conf.d \
    --mount=type=cache,target=/var/lib/apt/lists,from=explorer_cacher,source=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    < /tmp/build_dependencies.txt xargs apt-get install -y --no-install-recommends

WORKDIR /src

##  ---------------- Runner part (dev)---------------- 
FROM osrf/ros:${ROS_DISTRO}-desktop AS explorer_dev
LABEL org.opencontainers.image.source=https://github.com/ORTHOPUS-EXPLORER/explorer_devenv
LABEL org.opencontainers.image.description="Development image for Orthopus Explorer project"
# LABEL org.opencontainers.image.licenses=

## Runtime dependencies
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

COPY --from=explorer_cacher /tmp/*_dependencies.txt /tmp/
RUN --mount=type=cache,target=/etc/apt/apt.conf.d,from=explorer_cacher,source=/etc/apt/apt.conf.d \
    --mount=type=cache,target=/var/lib/apt/lists,from=explorer_cacher,source=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    < /tmp/build_dependencies.txt xargs apt-get install -y --no-install-recommends && \
    < /tmp/exec_dependencies.txt xargs apt-get install -y --no-install-recommends

WORKDIR /src
COPY ./entrypoint.sh /src/
RUN echo "source /src/source.sh" >> ~/.bashrc
RUN chmod +x /src/entrypoint.sh

ENTRYPOINT ["/src/entrypoint.sh"]


## ---------------- Runner part (prod) ----------------
FROM explorer_dev AS explorer_prod
LABEL org.opencontainers.image.description="Ready to uses image for Orthopus Explorer project"

COPY . /src/
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build --symlink-install --continue-on-error --mixin release