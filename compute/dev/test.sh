#!/bin/bash

# Function to check command execution
check_command() {
    if [ $? -eq 0 ]; then
        echo "$1 executed successfully"
    else
        echo "$1 failed"
    fi
}

# SSH into cim-dev and execute commands
ssh cim@cim-dev << EOF

    echo "Checking Rust compiler version..."
    rustc -v
    check_command "rustc -v"

    echo -e "\nChecking Cargo version..."
    cargo -v
    check_command "cargo -v"

    echo -e "\nPinging NATS once..."
    ping -c 1 nats
    check_command "ping NATS"

    echo -e "\nPinging dell.com once..."
    ping -c 1 dell.com
    check_command "ping dell.com"
EOF

echo "Script execution completed."















#!/bin/bash

# Function to check if the OS is NixOS
isNixOS() {
  uname -a | grep -q "NixOS" && return 0 || return 1
}

# Function to check if the host has the correct IP
hostHasCorrectIP() {
  local ip=$1
  local machine=$2
  ping -c1 $machine | grep -q "$machine.cim.thecowboy.ai ($ip)" && return 0 || return 1
}

# Run all boolean functions and check their results
if isNixOS && hostHasCorrectIP "192.168.1.81" "cim-dev"; then
  echo "Pass"
  exit 0  # true
else
  echo "Fail"
  exit 1  # false
fi

### FlakesAreEnabled

## hasCorrectHostname

## hasDNS

## hasReverseDNS

## hasInternetAccess

## hasZsh

## hasStarship

## canStartANatsServer

## canCreateAWasmCloudComponent

## hasCargo

## hasRustC

main() {
  pass = 0
  pass = IsNixOS
  echo pass
}

main