# devkit-setup
This repository sets up a Docker container based on the `docker pull autodriveecosystem/autodrive_roboracer_api:2025-icra-practice` and sets up:
1. `ros2_laser_scan_matcher`
2. `ydlidar_ros2_driver`
3. A new node that overwrites the original `/tf` topic to allow communication with the LIDAR.

The sample bag is included. 
### Note: Non-NVIDIA users should replace the docker-compose.yaml with docker-compose-nogpu.yaml (and change the name)

## Setup:
Just clone this, and run 
```

./start.sh

```

## LIDAR USB connection
If you want to use the USB with lidar
On your system, run:
```

sudo ./fix-usb.sh
./start.sh

```
After connecting the LIDAR
Then, inside the container,r do the same (the script is in the `/home/autodrive_devkit` directory)
Then continue running the topics.

The bag file must be run using 
```

ros2 bag play ./sample-bag.db3 --remap /scan:=/autodrive/roboracer_1/lidar -l

```
As the bag publishes to the `/scan` topic, which we need to redirect to the `/autodrive/roboracer_1/lidar` topic.

(Play the bag file only if you don't have the LIDAR connected)

## Sample Run
A sample run includes(in different terminals)
```

	ros2 run ros2_laser_scan_matcher laser_scan_matcher

```
```

	ros2 run new-tf-topic frame_publisher_node

```
```

	ros2 launch ydlidar_ros2_driver ydlidar_launch_view.py

```
## Make sure the node in `Rviz` is set to `roboracer_1` 
