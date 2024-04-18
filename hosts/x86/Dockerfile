# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update package lists and install any necessary packages
RUN apt-get update && apt-get install -y \
    htop \
    neofetch \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*[1][2]

# Set the working directory
WORKDIR /dell

# dell blocks direct download access... (paywall type stuff)
# go here https://www.dell.com/support/home/en-us/drivers/DriversDetails?driverId=42VJ8
# tar zxvpf <downloadedfile>

# RUN wget https://dl.dell.com/FOLDER10469726M/1/command-configure_4.11.0-6.ubuntu22_amd64.tar.gz \
# && tar zxvpf command-configure_4.11.0-6.ubuntu22_amd64.tar.gz

# Define the command to run the application
CMD ["bash"]
