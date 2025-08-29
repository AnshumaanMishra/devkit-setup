#!/bin/bash
set -e

# Make persistent dirs if they don't exist
mkdir -p ros2_laser_scan_matcher
mkdir -p ydlidar_ros2_driver

# Build the image
docker compose build --no-cache

# Run the container
docker compose up
