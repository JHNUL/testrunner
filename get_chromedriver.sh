#!/bin/bash -e

##############################################
#
# Download latest released version of chrome
# webdriver.
#
##############################################

CHROMEDIVER_INFO_URL="https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"

URL=$(curl -s "$CHROMEDIVER_INFO_URL" | jq -r '.channels.Stable.downloads.chromedriver[] | select(.platform == "linux64").url')

mkdir -p /browser

curl -s $URL -o /browser/driver.zip

unzip -q /browser/driver.zip -d /browser

rm -r /browser/driver.zip

ln -sf /browser/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
