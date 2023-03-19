#!/bin/bash -e

##############################################
#
# Download current stable version of chrome
# browser.
#
##############################################

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /browser/google-chrome-stable_current_amd64.deb
apt-get install -y /browser/google-chrome-stable_current_amd64.deb
rm /browser/google-chrome-stable_current_amd64.deb
