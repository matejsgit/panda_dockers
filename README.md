# Panda Docker files

> Panda-simulation-in-a-box: a containerized version of Panda simulation with Gazebo & ROS.

This repository provides Docker configuration to run [ROS](https://ros.org)-based [Gazebo](http://gazebosim.org/) simulation of Panda robot inside [Docker](https://www.docker.com/) containers:
    
<!-- 
Inspired by: https://github.com/gramaziokohler/ros_docker

## Base ROS image `ìjs:kinetic-devel`

[![](https://img.shields.io/docker/v/gramaziokohler/ros-base?sort=date)](https://hub.docker.com/r/gramaziokohler/ros-base)
[![](https://img.shields.io/docker/image-size/gramaziokohler/ros-base?sort=date)](https://microbadger.com/images/gramaziokohler/ros-base) 
    $ docker pull gramaziokohler/ros-base

Contains ROS and tools to use it over websockers with `rosbridge-suite`.-->

## Images

- [ijs:kinetic-devel](/kinetic-devel)
  - This image inherits from the image with the tag [`kinetic`](https://hub.docker.com/_/ros) in the official ROS Dockerhub repository. It is  expanded with a few additional tools that we found useful and the core robot messages package [`robot_module_msgs`](https://github.com/ReconCycle/robot_module_msgs).
- [ijs:kinetic-gazebo](/kinetic-gazebo)
  - Extends `ijs:kinetic-devel` with Gazebo simulator and Gazebo ROS bindings.
- [panda-simulator](/panda-simulator)
  - Contains Panda simulation in Gazebo based on [`panda_simulator` stack by justagist](https://github.com/justagist/panda_simulator)
- [ijs:gzweb](/gzweb)
  - Contains base gzweb client
- [ijs:panda-gzweb](/panda-gzweb)
  - Extends `ijs:gzweb`with meshes and other assets for the Panda robot
- [sim_controllers_interface](/sim_controllers_interface)
  - Provides ROS action server for moving the robot in simualtion using [ReconCycle/sim_controllers_interface](https://github.com/ReconCycle/sim_controllers_interface)
  
## Examples

To run any of the images, you first have to build the images. To do navigate terminal to the cloned repository and execute folllowing script: 

    $ ./build.sh

If you work on Windows with powershell use `build.ps1` script instead.
    
### Gazebo in X11 NoVNC display container

Panda simulation is running in standard Gazebo GUI, which is rendered over the web using [noVNC](https://novnc.com). 
Other X11 applications (e.g. `RViz`) from other containers can also be displayed.

    $ cd examples/panda-simulator-novnc
    $ docker-compose up
    
Open [localhost:8080](http://localhost:8080/vnc.html?resize=scale&autoconnect=true) in your favourite browser.

### Gazebo gzweb client

Panda simulation runs headless in a container and is rendered in browser using [gzweb](http://gazebosim.org/gzweb.html), which is a WebGL client for Gazebo. 
 
    $ cd examples/panda-simulator-gzweb
    $ docker-compose up

Open [localhost:80](http://localhost:80) in your favourite browser.

<!-- TODO: nvidia-docker, xhost -->

### Move panda using action server (experimental)

 1. Start Gazebo using either of the above methods and open GUI. 
 2. Determine the name of the ROS network using `docker network ls`. If you run `gzweb` it will probbably be `panda-simulator-gzweb_ros`, which we asume in next steps.
 3. Start action server using:

    `docker run -it --network panda-simulator-gzweb_ros -e ROS_MASTER_URI=http://rosmaster:11311 ijs:sim_controllers_interface rosrun sim_controllers_interface joint_min_jerk_action_server.py`
    
 4. Send test goal using: 
    
    `docker run -it --network panda-simulator-gzweb_ros -e ROS_MASTER_URI=http://rosmaster:11311 ijs:sim_controllers_interface rosrun sim_controllers_interface joint_min_jerk_test_client.py`
