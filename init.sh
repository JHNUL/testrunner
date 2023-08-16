#!/bin/bash -e

##############################################
#
# Run initial package updates and install
# required system dependencies.
#
# NOTE: Default Python version from apt for
# Debian 11 is 3.9.2.
#
##############################################

apt-get update
apt-get install -y curl unzip python3 python3-pip jq
