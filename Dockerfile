FROM osrf/ros:iron-desktop

#fix GPG keys error
RUN rm /etc/apt/sources.list.d/ros2*
RUN apt update
RUN apt install -y curl
RUN apt-key del F42ED6FBAB17C654
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


RUN apt update
RUN apt install -y ros-iron-plotjuggler ros-iron-plotjuggler-ros 
RUN apt install -y vim
RUN apt install -y tmux
RUN apt install -y python3-pip
RUN apt install -y iproute2
#RUN apt install -y ros-iron-ros2-controllers-test-nodes #TODO: add in appropriate package.xml
RUN apt install -y can-utils
RUN apt install -y terminator

#RUN pip install aenum

RUN apt install -y --no-install-recommends ros-iron-rmw-cyclonedds-cpp



COPY . ./src/
WORKDIR src

RUN echo "source /src/source.sh" >> ~/.bashrc
RUN chmod +x /src/entrypoint.sh
ENTRYPOINT ["/src/entrypoint.sh"]
