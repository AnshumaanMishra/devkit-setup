FROM autodriveecosystem/autodrive_roboracer_api:2025-icra-practice

# Copy custom bashrc
COPY ./.bashrc /root/.bashrc
COPY ./sample-bag.db3 /home/autodrive_devkit/sample-bag.db3
COPY ./fix-usb.sh /home/autodrive_devkit/fix-usb.sh

# Copy entrypoint script into image
COPY ./entrypoint.bash /entrypoint.bash
RUN chmod +x /entrypoint.bash

# Default entrypoint goes through entrypoint.bash
ENTRYPOINT ["/entrypoint.bash"]
CMD ["bash", "-l"]

