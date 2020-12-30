# derived from http://github.com/osrf/docker_images/blob/master/gazebo/gazebo7/gzweb7/Dockerfile
# and https://github.com/AAAI-DISIM-UnivAQ/docker-gzweb/blob/master/Dockerfile
# upgraded according to http://gazebosim.org/tutorials?tut=gzweb_install&cat=gzweb#Dependencies

FROM gazebo:libgazebo7

# install packages
RUN apt-get update && apt-get upgrade -q -y && apt-get install -q -y \
    build-essential \
    cmake \
    imagemagick \
    libboost-dev \
    libjansson-dev \
    libtinyxml-dev \
    git \
    mercurial \
    curl \
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get install -q -y \
    libgazebo7-dev \
    && rm -rf /var/lib/apt/lists/*

# clone gzweb
RUN git clone -b gzweb_1.4.1 --single-branch  https://github.com/osrf/gzweb ~/gzweb

# npm from source
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
SHELL ["/bin/bash", "-c"]
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.17.1
RUN mkdir -p /usr/local/nvm
# same version as in http://gazebosim.org/gzweb.html
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# build gzweb 
RUN cd ~/gzweb \
    && source /usr/share/gazebo/setup.sh \
    && npm run deploy --- -m local

# setup environment
EXPOSE 8080
EXPOSE 7681

# run only gzweb
ENTRYPOINT []
CMD npm start --prefix ~/gzweb
