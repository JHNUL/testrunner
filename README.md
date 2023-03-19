# Testrunner Robot Framework Chrome Docker Image

Image for running RF tests from docker container. Only has Chrome browser and driver.

Current versions of main dependencies are:

- Chrome 111.0.5563.64
- Chromedriver 111.0.5563.64
- Python 3.9.2
- robotframework 6.0.2
- robotframework-seleniumlibrary 6.0.0

## Instructions for running locally

Building the container:

```sh
docker build . --tag somename:sometag
```

Running the container requires the following options passed to `docker run`

```sh
# (Mandatory) mount the folder containing the robot tests
--volume=./test_folder_host:/home/testrunner/tests

# (Mandatory) mount the folder that will contain the test report.
# The folder should exist on the host.
--volume=./test_report_host:/home/testrunner/test-results

# (Optional) pass this only if the target service is running on localhost outside docker
--network="host"

# For example
docker run --network="host" \
 --volume ./tests:/home/testrunner/tests \
 --volume ../tests-results:/home/testrunner/test-results \
 somename:sometag
```
