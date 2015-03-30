FROM ubuntu:trusty
MAINTAINER Ferenc Balint-Benczedi 
#based on indigo-swi from Moritz Tenorth

#RUN echo 'Acquire::http { Proxy "http://172.17.42.1:3142"; };' >> /etc/apt/apt.conf.d/01proxy

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Install ROS
#
RUN apt-get -y update && apt-get -y install wget apt-utils && \
    sh -c '. /etc/lsb-release && echo "deb http://packages.ros.org.ros.informatik.uni-freiburg.de/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list' && \
    wget http://packages.ros.org/ros.key -O - | apt-key add - && \
    apt-get -y update && apt-get -y install \
                emacs \
                git \
                libbullet-dev \
                libjson-java \
                libjson-glib-dev \
                mongodb-clients \
                openjdk-7-jdk \
                python-catkin-pkg \
                python-rospkg \
                python-wstool \
                python-yaml \
                ros-indigo-catkin \
                ros-indigo-mjpeg-server \
                ros-indigo-orocos-kdl \
                ros-indigo-robot-model \
                ros-indigo-ros \
                ros-indigo-ros-base \
                ros-indigo-rosbridge-suite \
                ros-indigo-tf2-web-republisher \
                ros-indigo-xacro \
                ros-indigo-rosjava \
                ros-indigo-pr2-description \
                ros-indigo-openni-camera \
                ros-indigo-openni-launch \
                ros-indigo-compressed-depth-image-transport \
                ros-indigo-compressed-image-transport \
                ros-indigo-vision-opencv \
                ros-indigo-image-transport \
                ros-indigo-rosauth \
                ros-indigo-pcl-ros \
                ros-indigo-pcl-conversions \
                ros-indigo-tf-conversions \
                ros-indigo-self-test \
                swi-prolog \
                swi-prolog-java \
                automake \
                libxerces-c-dev \
                libicu-dev \
                openjdk-7-jdk \
                libapr1-dev \
                libgphoto2-2-dev \ 
                mongodb \
                libhdf5-serial-dev \
                protobuf-compiler \
                scons \
                libtool \
                xstow \
                libopencv-dev \
                vim gdb \
                libcppnetlib-dev 


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Create user 'ros'
#
RUN useradd -m -d /home/ros -p ros ros && adduser ros sudo && chsh -s /bin/bash ros && echo "ros ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ENV HOME /home/ros


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Set up ROS environment
#
RUN cp /opt/ros/indigo/setup.sh /etc/profile.d/ros_indigo.sh && \
    rosdep init

WORKDIR /home/ros
USER ros
#RUN chown -R ros:ros /home/ros && \
#    rosdep update && \
#    echo "export LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server" >> /home/ros/.bashrc && \
#    echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> /home/ros/.bashrc && \
#    echo "source /home/ros/ros_ws/devel/setup.bash" >> /home/ros/.bashrc && \
#    echo "source /home/ros/.bashrc" >> /home/ros/.bash_profile 

ENV CMAKE_PREFIX_PATH /home/ros/ros_ws/devel:/opt/ros/indigo
ENV PKG_CONFIG_PATH /home/ros/ros_ws/devel/lib/pkgconfig:/opt/ros/indigo/lib/pkgconfig
ENV PYTHONPATH /home/ros/ros_ws/lib/python2.7/dist_packages:/opt/ros/indigo/lib/python2.7/dist-packages

RUN mkdir -p /home/ros/ros_ws/src
WORKDIR /home/ros/ros_ws/src
RUN /usr/bin/python /opt/ros/indigo/bin/catkin_init_workspace

#add uimacpp and mongo client from source using xstow
WORKDIR /home/ros
RUN mkdir -p /home/ros/local/src && mkdir -p /home/ros/local/xstow
WORKDIR /home/ros/local/src
RUN git clone https://github.com/bbferka/uima-uimacpp.git uimacpp && \
    git clone https://github.com/mongodb/mongo-cxx-driver.git -b 26compat
WORKDIR /home/ros/local/src/uimacpp
RUN ./autogen.sh && ./configure --without-activemq --with-jdk=/usr/lib/jvm/java-7-openjdk-amd64/include --prefix=/home/ros/local/xstow/uimacpp --with-icu=/usr && make install 
WORKDIR /home/ros/local/src/mongo-cxx-driver
RUN scons --full --use-system-boost --prefix=/home/ros/local/xstow/mongoclient --ssl --sharedclient install-mongoclient
WORKDIR /home/ros/local/xstow
RUN xstow uimacpp && xstow mongoclient

# forward ports: KnowRob webserver + rosbridge
#EXPOSE 1111 9090

# Volumes for mounting data containers
#VOLUME /home/ros/knowrob_data
#VOLUME /home/ros/sandbox

