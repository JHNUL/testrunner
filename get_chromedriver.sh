#!/bin/bash -e

##############################################
#
# Download latest released version of chrome
# webdriver.
#
##############################################

LATEST_DRIVER=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)

VERSION_READABLE=$(echo "$LATEST_DRIVER" | sed 's/\./_/g')

URL="https://chromedriver.storage.googleapis.com/$LATEST_DRIVER/chromedriver_linux64.zip"

mkdir -p /browser/$VERSION_READABLE
FOLDER=/browser/$VERSION_READABLE

curl $URL -o $FOLDER/$VERSION_READABLE.zip

unzip $FOLDER/$VERSION_READABLE.zip -d $FOLDER

rm -r $FOLDER/$VERSION_READABLE.zip

ln -sf $FOLDER/chromedriver /usr/local/bin/chromedriver
