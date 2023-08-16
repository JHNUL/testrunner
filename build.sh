#!/bin/bash -e

##############################################
#
# Check that Chrome browser and driver major
# versions will be the same and then build
# the image with latest version number.
#
##############################################

CHROME_VERSION=$(wget -qO- https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb | dpkg --info - | grep Version)
CHROME_VERSION_NO=$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' <<< "$CHROME_VERSION")
CHROME_MAJOR_VERSION=$(echo "$CHROME_VERSION_NO" | cut -d '.' -f 1)

DIVER_INFO_URL="https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
DRIVER_URL=$(curl -s "$DIVER_INFO_URL" | jq -r '.channels.Stable.downloads.chromedriver[] | select(.platform == "linux64").url')
DRIVER_VERSION_NO=$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' <<< "$DRIVER_URL")
DRIVER_MAJOR_VERSION=$(echo "$CHROME_VERSION_NO" | cut -d '.' -f 1)

if [ "$CHROME_MAJOR_VERSION" == "$DRIVER_MAJOR_VERSION" ]; then
    echo "Proceeding with chrome version $CHROME_VERSION_NO and driver $DRIVER_VERSION_NO!"
else
    echo "Major versions of chrome $CHROME_VERSION_NO and driver $DRIVER_VERSION_NO are different!"
    exit 1
fi

VERSION=$(cat versions.txt | tail -n 1)

docker build . -t test-runner:$VERSION
