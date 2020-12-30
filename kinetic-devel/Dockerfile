FROM ros:kinetic

# Set some environment variables for the GUI
ENV HOME=/root \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Install pip & cli tools
RUN set -ex; \
    apt update && apt install -y \
    python-pip \
    screen \
    vim \
    nano \
    net-tools \
    iputils-ping \
    git \
    wget

RUN pip install --upgrade pip

RUN pip install catkin_tools

# Initialize the catkin workspace
WORKDIR /ros_ws/src

RUN git clone https://github.com/ReconCycle/robot_module_msgs.git
WORKDIR /ros_ws

# Source stuff
SHELL ["/bin/bash", "-c"] 
RUN source /opt/ros/$ROS_DISTRO/setup.bash && catkin build
# RUN catkin build
RUN source devel/setup.bash

# Clear apt cache.
RUN apt clean

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws

# We source the ros_ws workspace as well when entering the container
RUN cp /ros_entrypoint.sh /tmp_entrypoint.sh
RUN (head -n -1 /ros_entrypoint.sh && echo 'source "/ros_ws/devel/setup.bash"' && tail -n 1 /ros_entrypoint.sh;) > /tmp_entrypoint.sh
RUN mv /tmp_entrypoint.sh /ros_entrypoint.sh


# Add a file to help out sourcing the workspaces
RUN echo "source \"/opt/ros/$ROS_DISTRO/setup.bash\"" >> /source_ws.sh
RUN echo "source \"/ros_ws/devel/setup.bash\"" >> /source_ws.sh
