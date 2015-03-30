FROM bbferka/indigo-base
MAINTAINER Ferenc Balint-Benczedi, balintbe@cs.uni-bremen.de

# ensure to be in the right working directory:
WORKDIR /home/ros/ros_ws/src
USER ros

# dummy 'add' command to always check out the repositories
ADD ./Dockerfile /home/ros/src/
RUN git clone --recursive https://github.com/knowrob/knowrob.git -b indigo-devel && \
    git clone --recursive https://github.com/knowrob/knowrob_addons.git -b indigo-devel && \
    git clone --recursive https://github.com/code-iai/knowrob_dev.git && \
    git clone https://github.com/code-iai/iai_maps.git && \
    git clone https://github.com/code-iai/iai_common_msgs.git && \
    git clone https://github.com/code-iai/iai_cad_tools.git && \
    git clone https://github.com/code-iai/designator_integration.git && \
    git clone https://github.com/code-iai/iai_photo.git && \
    git clone https://github.com/bbferka/knowrob_robosherlock.git

#for now we just copy them in, it's faster
COPY private_repos /home/ros/ros_ws/src
USER root
RUN chown -R ros:ros /home/ros/ros_ws
USER ros

#WORKDIR /home/ros/ros_ws
# copy PR2 meshes into docroot
# RUN mkdir -p /home/ros/knowrob/knowrob_vis/html/pr2_description/meshes
# RUN cp -r /opt/ros/indigo/share/pr2_description/meshes/* /home/ros/knowrob/knowrob_vis/html/pr2_description/meshes/

