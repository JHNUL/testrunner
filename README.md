# Testrunner Robot Framework Chrome Docker Image

Image for running RF tests from docker container. Only has Chrome browser and driver.

Current versions of main dependencies are:

- Chrome 116.0.5845.96
- Chromedriver 116.0.5845.96
- Python 3.9.2
- robotframework 6.0.2
- robotframework-seleniumlibrary 6.0.0
- robotframework-requests 0.9.4

## Instructions for running locally

The build script checks that there is a Chrome browser (deb package) and a Chromedriver whose major versions match and then builds the container image tagging it with the latest version number found in `versions.txt`.

```sh
./build.sh
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
 --volume ./test-results:/home/testrunner/test-results \
 somename:sometag
```

The mounted test folder must contain `run_tests.py` script at the root level. `run_tests` will be invoked at container start.

```sh
.
├── testsuite1
├── testsuite2
├── testsuiteN
│   ├── TestLibrary.py
│   ├── test_resource.robot
│   └── test.robot
└── run_tests.py
```

Where the content can be something like this

```python
# run_tests.py

from os import path
from robot import run

script_folder = path.dirname(__file__)
parent_folder = path.join(script_folder, "..")

options = {
    'outputdir': f"{parent_folder}/test-results",
    # other options
}

exit_code = run(f"{script_folder}", **options)
# If you want the process to report non-zero
# exit code on failed tests.
exit(exit_code)
```
