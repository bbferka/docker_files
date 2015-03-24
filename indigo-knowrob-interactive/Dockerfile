FROM bbferka/indigo-swi
MAINTAINER Moritz Tenorth, moritz@tenorth.de

# ensure to be in the right working directory:
WORKDIR /home/ros/ros_pkgs/src
USER ros

# dummy 'add' command to always check out the repositories
ADD ./Dockerfile /home/ros/src/
RUN git clone --recursive https://github.com/knowrob/knowrob.git -b indigo-devel && \
    git clone --recursive https://github.com/knowrob/knowrob_addons.git -b indigo-devel && \
    git clone --recursive https://github.com/code-iai/knowrob_dev.git && \
    git clone https://github.com/code-iai/iai_maps.git && \
    git clone https://github.com/code-iai/iai_common_msgs.git && \
    git clone https://github.com/code-iai/iai_cad_tools.git 

# copy PR2 meshes into docroot
# RUN mkdir -p /home/ros/knowrob/knowrob_vis/html/pr2_description/meshes
# RUN cp -r /opt/ros/indigo/share/pr2_description/meshes/* /home/ros/knowrob/knowrob_vis/html/pr2_description/meshes/

# build the catkin workspace
WORKDIR /home/ros/ros_pkgs
RUN /opt/ros/indigo/bin/catkin_make

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# set environment variables for 'ros_pkgs' workspace
ENV CMAKE_PREFIX_PATH /home/ros/ros_pkgs/devel:/home/ros/system_pkgs/devel:/opt/ros/indigo/
ENV CPATH /home/ros/ros_pkgs/devel/include:/home/ros/system_pkgs/devel/include:/opt/ros/indigo/include
ENV LD_LIBRARY_PATH /home/ros/ros_pkgs/devel/lib/x86_64-linux-gnu:/home/ros/system_pkgs/devel/lib/x86_64-linux-gnu:/opt/ros/indigo/lib/x86_64-linux-gnu:/home/ros/ros_pkgs/devel/lib:/home/ros/system_pkgs/devel/lib:/opt/ros/indigo/lib:/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server
ENV PYTHONPATH /home/ros/ros_pkgs/devel/lib/python2.7/dist-packages:/home/ros/system_pkgs/devel/lib/python2.7/dist-packages:/opt/ros/indigo/lib/python2.7/dist-packages
ENV ROS_MAVEN_DEPLOYMENT_REPOSITORY /home/ros/ros_pkgs/devel/share/maven
ENV ROS_MAVEN_PATH /home/ros/ros_pkgs/devel/share/maven:/home/ros/system_pkgs/devel/share/maven:/opt/ros/indigo/share/maven
ENV ROS_PACKAGE_PATH /home/ros/ros_pkgs/src:/home/ros/system_pkgs/src:/opt/ros/indigo/share:/opt/ros/indigo/stacks

