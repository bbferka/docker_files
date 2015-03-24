FROM bbferka/indigo-knowrob-interactive
MAINTAINER Ferenc Balint-Benczedi, balintbe@cs.uni-bremen.de

USER root
#RUN sudo echo 'Acquire::http { Proxy "http://172.17.42.1:3142"; };' >> /etc/apt/apt.conf.d/01proxy
#RUN apt-get -y update && apt-get -y install wget apt-utils


# get the dependencies for ROBOSHERLOCK and build them
RUN apt-get -y update && apt-get -y install python-yaml python-catkin-pkg python-rospkg \ 
        emacs ros-indigo-catkin git ros-indigo-self-test\
        ros-indigo-rosbridge-suite ros-indigo-tf2-web-republisher \
        ros-indigo-mjpeg-server ros-indigo-pr2-description ros-indigo-openni-camera \
        ros-indigo-openni-launch ros-indigo-vision-opencv\
        mongodb-clients automake libxerces-c-dev libicu-dev \
        openjdk-7-jdk libapr1-dev libgphoto2-2-dev mongodb libhdf5-serial-dev \
        protobuf-compiler scons libtool xstow libopencv-dev vim gdb \
        ros-indigo-compressed-depth-image-transport \
        ros-indigo-compressed-image-transport ros-indigo-image-transport \         
        mongodb-clients ros-indigo-rosauth libcppnetlib-dev ros-indigo-pcl-ros \
        ros-indigo-pcl-conversions ros-indigo-tf-conversions 

ENV HOME /home/ros
#ROS env setup
#
WORKDIR /home/ros/custom_pkgs
USER ros
#
#RUN mkdir -p /home/ros/.m2
#ADD mvn-settings.xml /home/ros/.m2/settings.xml

RUN echo "export LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server:\${LD_LIBRARY_PATH}" >> /home/ros/.bashrc && \
    echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> /home/ros/.bashrc && \
    echo "export APR_HOME=\"/usr\"">> /home/ros/.bashrc && \
    echo "export ICU_HOME=\"/usr\"">> /home/ros/.bashrc && \
    echo "export XERCES_HOME=\"/usr\"">> /home/ros/.bashrc && \
    echo "export JAVA_INCLUDE=\"\${JAVA_HOME}/include\"" >> /home/ros/.bashrc && \
    echo "export PYTHON_VERSION=\"\$(readlink $(which python))\"" >> /home/ros/.bashrc && \
    echo "export PATH=\${UIMA_HOME}/bin:\${HOME}/local/bin:\${HOME}/local/sbin:\${HOME}/local/usr/bin:\${PATH}:\${HOME}/bin" >> /home/ros/.bashrc && \
    echo "export LD_LIBRARY_PATH=/home/ros/local/lib:/home/ros/local/usr/lib:\${LD_LIBRARY_PATH}" >> /home/ros/.bashrc && \
    echo "export LIBRARY_PATH=\${LD_LIBRARY_PATH}:\${LIBRARY_PATH}" >> /home/ros/.bashrc && \
    echo "export CPATH=\${HOME}/local/include:\${HOME}/local/usr/include:\${CPATH}" >> /home/ros/.bashrc && \
    echo "export LDFLAGS=\"-L\${HOME}/local/lib \${LDFLAGS}\"" >> /home/ros/.bashrc && \
    echo "export PKG_CONFIG_PATH=\${HOME}/local/lib/pkgconfig:\${PKG_CONFIG_PATH}" >> /home/ros/.bashrc && \
    echo "export CMAKE_INCLUDE_PATH=\${CPATH}:\${CMAKE_INCLUDE_PATH}" >> /home/ros/.bashrc && \
    echo "export CMAKE_LIBRARY_PATH=\${LIBRARY_PATH}:\${CMAKE_LIBRARY_PATH}" >> /home/ros/.bashrc && \
    echo "export PYTHONPATH=\${HOME}/local/lib/python/site-packages:\${HOME}/local/lib/\${PYTHON_VERSION}/site-package:\${PYTHONPATH}" >> /home/ros/.bashrc && \
    echo "export USER=ros" >> /home/ros/.bashrc && \
    echo source /home/ros/custom_pkgs/devel/setup.bash >> /home/ros/.bashrc && \
    echo source /home/ros/.bashrc >> /home/ros/.bash_profile

# set pre-build variables: only packages in /opt/ros
ENV PATH /home/ros/custom_pkgs/devel/bin:/opt/ros/indigo/bin:.:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/ros/local/bin/:/home/ros/local/sbin/:/home/ros/local/usr/bin


# set post-build variables:
ENV ROS_PACKAGE_PATH /home/ros/custom_pkgs/src:/home/ros/system_pkgs/src:/opt/ros/indigo/share:/opt/ros/indigo/stacks
ENV ROS_MASTER_URI http://localhost:11311 
ENV ROS_MAVEN_DEPLOYMENT_REPOSITORY /home/ros/custom_pkgs/devel/share/maven
ENV ROS_MAVEN_PATH /home/ros/custom_pkgs/devel/share/maven:/opt/ros/indigo/share/maven
# Use nexus server that mirrors maven central and ROS repository.
# NOTE: Requires that nexus server was started before build.
#ENV ROS_MAVEN_REPOSITORY http://172.17.42.1:8081/nexus/content/groups/public
ENV ROS_WORKSPACE /home/ros
ENV ROS_IP 127.0.0.1
ENV LD_LIBRARY_PATH /home/ros/custom_pkgs/devel/lib:/opt/ros/indigo/lib:/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server:/opt/ros/indigo/lib/python2.7/dist-packages:/home/ros/local/lib:/home/ros/local/usr/lib
ENV LIBRARY_PATH /home/ros/custom_pkgs/devel/lib:/opt/ros/indigo/lib:/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server:/opt/ros/indigo/lib/python2.7/dist-packages:/home/ros/local/lib:/home/ros/local/usr/lib
ENV SWI_HOME_DIR /usr/lib/swi-prolog
ENV PYTHONPATH /home/ros/local/lib/python/site-packages:/home/ros/local/lib/python2.7/site-packages/home/ros/custom_pkgs/devel/lib/python2.7/dist-packages:/opt/ros/indigo/lib/python2.7/dist-packages

#set postbuild variables needed for RoboSherlock
ENV APR_HOME=/usr
ENV ICU_HOME=/usr
ENV XERCES_HOME=/usr
ENV JAVA_INCLUDE=/usr/lib/jvm/default-java/include
ENV CMAKE_LIBRARY_PATH /home/ros/custom_pkgs/devel/lib:/opt/ros/indigo/lib:/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server:/opt/ros/indigo/lib/python2.7/dist-packages:/home/ros/local/lib:/home/ros/local/usr/lib

############## setup library dependencies for RoboSherlock ####################

#uimacpp
WORKDIR /home/ros
RUN git clone https://github.com/bbferka/uima-uimacpp.git uimacpp && \
    git clone https://github.com/mongodb/mongo-cxx-driver.git -b 26compat
WORKDIR /home/ros/uimacpp
USER root
RUN ./autogen.sh && ./configure --without-activemq --with-jdk=/usr/lib/jvm/java-7-openjdk-amd64/include --prefix=/usr/local --with-icu=/usr && make install 
WORKDIR /home/ros/mongo-cxx-driver
RUN scons --full --use-system-boost --prefix=/usr/local --ssl --sharedclient install-mongoclient
############### end setup RoboSherlock ##################


WORKDIR /home/ros/custom_pkgs/src

RUN git clone https://github.com/code-iai/designator_integration.git && \
    git clone https://github.com/code-iai/iai_photo.git && \
    git clone https://github.com/bbferka/knowrob_robosherlock.git

COPY iai_robosherlock /home/ros/custom_pkgs/src

WORKDIR /home/ros/custom_pkgs

# build the catkin workspace
RUN /opt/ros/indigo/bin/catkin_make

EXPOSE 1111 9090
