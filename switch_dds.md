set cyclone DDS:
apt-get update && apt-get install -y --no-install-recommends ros-iron-rmw-cyclonedds-cpp
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp


UNSET:
unset RMW_IMPLEMENTATION

