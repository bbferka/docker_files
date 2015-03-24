FROM ubuntu:trusty
MAINTAINER Moritz Tenorth, moritz@tenorth.de
#modified to reduce layer numbers by Ferenc Balint-Benczedi balintbe@cs.uni-bremen.de

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
                swi-prolog \
                swi-prolog-java


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
RUN chown -R ros:ros /home/ros && \
    rosdep update && \
    echo "export LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server" >> /home/ros/.bashrc && \
    echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> /home/ros/.bashrc && \
    echo "source /home/ros/ros_pkgs/devel/setup.bash" >> /home/ros/.bashrc && \
    echo "source /home/ros/.bashrc" >> /home/ros/.bash_profile 

#ENV ROS_PACKAGE_PATH /home/ros/ros_pkgs/src:/opt/ros/indigo/share:/opt/ros/indigo/stacks
ENV CMAKE_PREFIX_PATH /home/ros/ros_pkgs/devel:/opt/ros/indigo
ENV PKG_CONFIG_PATH /home/ros/ros_pkgs/devel/lib/pkgconfig:/opt/ros/indigo/lib/pkgconfig
ENV PYTHONPATH /home/ros/ros_pkgs/lib/python2.7/dist_packages:/opt/ros/indigo/lib/python2.7/dist-packages

RUN mkdir -p /home/ros/ros_pkgs/src
WORKDIR /home/ros/ros_pkgs/src
RUN /usr/bin/python /opt/ros/indigo/bin/catkin_init_workspace
# set variables: equiv. to `source /home/ros/system_pkgs/devel/setup.bash`

# forward ports: KnowRob webserver + rosbridge
EXPOSE 1111 9090

# Volumes for mounting data containers
VOLUME /home/ros/knowrob_data
VOLUME /home/ros/sandbox

