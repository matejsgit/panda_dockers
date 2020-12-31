# Two step build process as one of the repositories is private. 
# https://vsupalov.com/build-docker-image-clone-private-repo-ssh-key/
# https://itnext.io/building-docker-images-from-private-git-repositories-using-ssh-login-433edf5a18f2

# Prerequirements: 
#  - Generate RSA key pair using: ssh-keygen -t rsa -f github_key
#  - Add github_key.pub to https://github.com/ReconCycle/sim_controllers_interface/settings/keys

# Step 1: Add private github_key to intermediate build to pull from private repository 

FROM ijs:kinetic-devel as intermediate
RUN sudo apt install -yq openssh-client
WORKDIR /tmp
COPY github_key .
RUN chmod 600 github_key
RUN eval $(ssh-agent) && \
    ssh-add github_key && \
    ssh-keyscan -t rsa -H github.com >> /etc/ssh/ssh_known_hosts && \
    git clone git@github.com:ReconCycle/sim_controllers_interface.git 

# Step 2: Copy cloned repository from intermediate build

FROM ijs:panda-simulator
# Initialize the catkin workspace
WORKDIR /ros_ws/src/robot_module_msgs
RUN git pull && git checkout ijs_controllers_update
WORKDIR /ros_ws/src
# RUN git clone git@github.com:ReconCycle/sim_controllers_interface.git
COPY --from=intermediate /tmp/sim_controllers_interface sim_controllers_interface
WORKDIR /ros_ws
RUN catkin build
