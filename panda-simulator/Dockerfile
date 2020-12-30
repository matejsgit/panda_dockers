# Based on https://github.com/ReconCycle/docker_examples/blob/master/ros1_panda_sim/Dockerfile
FROM ijs:kinetic-gazebo

# Download packages that are needed for compiling the qb stuff
RUN apt update && apt install -y \
    ros-${ROS_DISTRO}-libfranka \
    ros-${ROS_DISTRO}-franka-ros \
    ros-${ROS_DISTRO}-rospy-message-converter \
    ros-${ROS_DISTRO}-effort-controllers \
    ros-${ROS_DISTRO}-joint-state-controller \
    ros-${ROS_DISTRO}-moveit \
    ros-${ROS_DISTRO}-moveit-commander \    
    ros-${ROS_DISTRO}-moveit-visual-tools

RUN pip install --upgrade numpy numpy-quaternion

WORKDIR /ros_ws/src
# RUN git clone https://github.com/justagist/franka_ros_interface
RUN git clone -b kinetic-devel https://github.com/justagist/panda_simulator.git
RUN git clone https://github.com/justagist/panda_robot.git
RUN sed -i "s|uri: https://github.com/JustaGist/franka_panda_description|uri: https://github.com/ReconCycle/franka_panda_description|g" panda_simulator/dependencies.rosinstall
RUN wstool init
RUN wstool merge panda_simulator/dependencies.rosinstall
RUN wstool up
WORKDIR /ros_ws
RUN source /opt/ros/$ROS_DISTRO/setup.bash && catkin build

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws

ENTRYPOINT ["/ros_entrypoint.sh"]


