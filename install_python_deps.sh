#!/bin/bash -e

##############################################
#
# Install required python3 dependencies.
#
##############################################

python3 -m pip install --upgrade pip
pip install --user -r requirements.txt --no-cache-dir
pip cache purge
