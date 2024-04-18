# Use Ubuntu 22.04 WITH systemd as the base image
FROM jrei/systemd-ubuntu:jammy

#TAG Ubuntu-Dell-Command

# Update package lists and install any necessary packages
RUN apt-get update && apt-get install -y \
    htop \
    neofetch \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*[1][2]


# RUN systemctl set-property docker.service --add-override "ExecStart=/usr/bin/dockerd --containerd=/run/containerd/containerd.sock"
# RUN systemctl enable docker.service

# Set the working directory
WORKDIR /dell

COPY ./*.deb /dell

# dell blocks direct download access... (paywall type stuff)
# go here https://www.dell.com/support/home/en-us/drivers/DriversDetails?driverId=42VJ8
# tar zxvpf <downloadedfile>

#RUN wget https://dl.dell.com/FOLDER10469726M/1/command-configure_4.11.0-6.ubuntu22_amd64.tar.gz \
#&& tar zxvpf command-configure_4.11.0-6.ubuntu22_amd64.tar.gz

#RUN dpkg -i srvadmin-hapi_9.5.0_amd64.deb
#RUN dpkg -i command-configure_4.11.0-6.ubuntu22_amd64.deb

# Define the command to run the application
CMD ["bash"]
