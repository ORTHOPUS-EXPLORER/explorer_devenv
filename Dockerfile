FROM ros:iron

RUN apt update
RUN apt install -y ros-iron-plotjuggler ros-iron-plotjuggler-ros 
RUN apt install -y vim
RUN apt install -y tmux
RUN apt install -y python3-pip
RUN apt install -y iproute2
RUN apt install -y ros-iron-ros2-controllers-test-nodes #TODO: add in appropriate package.xml
RUN apt install -y can-utils

RUN pip install aenum

COPY . ./src/
WORKDIR src
