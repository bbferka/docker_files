FROM bbferka/indigo-rosws-base
MAINTAINER Ferenc Balint-Benczedi, balintbe@cs.uni-bremen.de

#set ENV variables

ENV ROS_ROOT /opt/ros/indigo/share/ros
ENV ROS_PACKAGE_PATH /home/ros/ros_ws/src/:/opt/ros/indigo/share:/opt/ros/indigo/stacks
ENV ROS_MASTER_URI http://localhost:11311
ENV ROS_MAVEN_DEPLOYMENT_REPOSITORY=/opt/ros/indigo/share/maven
ENV ROS_MAVEN_PATH=/opt/ros/indigo/share/maven
ENV ROS_MAVEN_REPOSITORY=https://github.com/rosjava/rosjava_mvn_repo/raw/master
ENV ROS_DISTRO=indigo
ENV ROS_ETC_DIR=/home/ros/ros_ws/etc:/opt/ros/indigo/etc/ros

ENV PYTHON_VERSION python2.7
ENV LD_LIBRARY_PATH=/home/ros/local/lib:/home/ros/ros_ws/devel/lib:/home/ros/devel/lib/x64_64-linux-gnu:/opt/ros/indigo/lib:/opt/ros/indigo/lib/x86_64-linux-gnu
ENV LIBRARY_PATH=/home/ros/local/lib:/home/ros/ros_ws/devel/lib:/home/ros/devel/lib/x64_64-linux-gnu:/opt/ros/indigo/lib:/opt/ros/indigo/lib/x86_64-linux-gnu
ENV CPATH=/home/ros/local/include:/home/ros/ros_ws/devel/include:/opt/ros/indigo/include
ENV PATH=/home/ros/local/bin:/home/ros/ros_ws/devel/bin:/opt/ros/indigo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH=/home/ros/local/lib/python/site-packages:/home/ros/ros_ws/devel/lib/python2.7/dist-packages:/opt/ros/indigo/lib/python2.7/dist-packages
ENV LDFLAGS=-L/home/ros/local/lib
ENV PKG_CONFIG_PATH=/home/ros/local/lib/pkgconfig:/home/ros/ros_ws/devel/lib/pkgconfig:/home/ros/ros_ws/devel/lib/x86_64-linux-gnu/pkgconfig:/opt/ros/indigo/lib/pkgconfig:/opt/ros/indigo/lib/x86_64-linux-gnu/pkgconfig
ENV CMAKE_PREFIX_PATH=/home/ros/ros_ws/devel:/opt/ros/indigo
ENV CMAKE_INCLUDE_PATH=/home/ros/local/include:/home/ros/ros_ws/devel/include:/opt/ros/indigo/include
ENV CMAKE_LIBRARY_PATH=/home/ros/local/lib:/home/ros/ros_ws/devel/lib:/home/ros/devel/lib/x64_64-linux-gnu:/opt/ros/indigo/lib:/opt/ros/indigo/lib/x86_64-linux-gnu
ENV APR_HOME /usr
ENV ICU_HOME /usr
ENV XERCES_HOME /usr
ENV USER ros

USER root
RUN rosdep init && rosdep update
 
USER ros
WORKDIR /home/ros/ros_ws
RUN /opt/ros/indigo/bin/catkin_make

EXPOSE 1111 9090

VOLUME /home/ros/knowrob_data
VOLUME /home/ros/sandbox

ENTRYPOINT /opt/ros/indigo/bin/roslaunch iai_rs_cpp openeas_robosherlock.launch
