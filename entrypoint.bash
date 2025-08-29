#!/bin/bash
set -e

# Source bashrc and ROS 2 Humble
if [ -f /root/.bashrc ]; then
  source /root/.bashrc
fi
source /opt/ros/humble/setup.bash

cd /home/autodrive_devkit

# Clone ros2_laser_scan_matcher if missing
if [ ! -d "ros2_laser_scan_matcher/.git" ]; then
  echo "Cloning main Repo"
  git clone https://github.com/AnshumaanMishra/ros2_laser_scan_matcher.git
fi

# Clone and build csm if missing
if [ ! -d "ros2_laser_scan_matcher/dependencies/csm/.git" ]; then
  mkdir -p ros2_laser_scan_matcher/dependencies
  cd ros2_laser_scan_matcher/dependencies
  echo "Cloning CSM repo"
  git clone https://github.com/AnshumaanMishra/csm.git
  cd csm
  mkdir -p build && cd build
  cmake ..
  make
fi

cd /home/autodrive_devkit/ros2_laser_scan_matcher/dependencies/csm/build
make install
cd /home/autodrive_devkit

# Build ROS 2 package only if not already installed
if [ ! -f "ros2_laser_scan_matcher/install/setup.bash" ]; then
  cd /home/autodrive_devkit
  echo "Building Scan Matcher Package"
  cd ros2_laser_scan_matcher
  colcon build --symlink-install
fi

if [ ! -f "ros2_laser_scan_matcher/new_topics/new-tf-topic/install/setup.bash" ]; then
  cd /home/autodrive_devkit/ros2_laser_scan_matcher

  mkdir -p new_topics
  cd new_topics
  git clone https://github.com/AnshumaanMishra/new-tf-topic.git
  cd new-tf-topic
  echo "Building new-tf-topic"
  colcon build --symlink-install
fi

cd /home/autodrive_devkit

if [ ! -d "ydlidar_ros2_driver/.git" ]; then
  echo "Cloning ydlidar_ros2_driver Repo"
  git clone https://github.com/AnshumaanMishra/ydlidar_ros2_driver.git
fi

# Clone and build csm if missing
if [ ! -d "ydlidar_ros2_driver/dependencies/YDLidar-SDK/.git" ]; then
  mkdir -p ydlidar_ros2_driver/dependencies
  cd ydlidar_ros2_driver/dependencies
  echo "Cloning SDK repo"
  git clone https://github.com/AnshumaanMishra/YDLidar-SDK.git
  cd YDLidar-SDK
  mkdir -p build && cd build
  cmake ..
  make
fi

cd /home/autodrive_devkit/ydlidar_ros2_driver/dependencies/YDLidar-SDK/build
make install
cd /home/autodrive_devkit

# Build ROS 2 package only if not already installed
if [ ! -f "ydlidar_ros2_driver/install/setup.bash" ]; then
  cd /home/autodrive_devkit
  echo "Building Driver Package"
  cd ydlidar_ros2_driver
  colcon build --symlink-install
fi

# Drop into interactive bash
echo "Building Complete, please attach to running container using:"
echo "docker exec -it roboracer_dev bash"
exec /bin/bash -l
