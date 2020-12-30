#based on https://github.com/ReconCycle/docker_examples/tree/master/ros1_gazebo
FROM ijs:kinetic-devel

# Download packages that are needed for compiling the qb stuff
RUN apt update && apt install -y \
    ros-kinetic-gazebo-ros-pkgs \
    ros-kinetic-gazebo-ros-control

# Here is the thing, Gazebo, by default, uses the online database for a lot 
# of the provided examples. Here we will download only the basic sun and
# ground plane models so we can show the basic examples. If more are needed, 
# consider how to feed in the container the online model database.
WORKDIR /usr/share/gazebo-7/models
RUN wget -r -nH -np -R "index.html*" http://models.gazebosim.org/sun/
RUN wget -r -nH -np -R "index.html*" http://models.gazebosim.org/ground_plane/

WORKDIR /ros_ws

ENTRYPOINT ["/ros_entrypoint.sh"]
