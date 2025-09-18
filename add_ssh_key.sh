#!/bin/bash

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh

# Add the key to authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHRh/HK4iRscYPdkNBF7/N5MO96uXiAsy4hQVbORKpgi contact@summerdust.com" >> ~/.ssh/authorized_keys

# Set correct permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys


