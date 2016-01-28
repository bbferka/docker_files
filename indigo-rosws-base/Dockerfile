FROM robosherlock/indigo-base
MAINTAINER Ferenc Balint-Benczedi, balintbe@cs.uni-bremen.de

# ensure to be in the right working directory:
WORKDIR /home/ros/ros_ws/src
USER ros

# dummy 'add' command to always check out the repositories
ADD ./Dockerfile /home/ros/src/
RUN git clone --recursive https://github.com/knowrob/knowrob.git && \
    git clone https://github.com/code-iai/iai_maps.git && \
    git clone https://github.com/code-iai/iai_common_msgs.git && \
    git clone https://github.com/code-iai/designator_integration.git && \
    git clone https://github.com/RoboSherlock/robosherlock.git 

#copy private repos to workspace
COPY private_repos /home/ros/ros_ws/src
WORKDIR /home/ros/ros_ws/src/knowrob/knowrob_vis/html/lib
RUN git pull origin master
USER root
RUN chown -R ros:ros /home/ros/ros_ws
USER ros


