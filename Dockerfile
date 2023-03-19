FROM debian:bullseye

WORKDIR /browser

COPY ./get_chrome.sh \
  ./get_chromedriver.sh \
  ./init.sh \
  ./

RUN ./init.sh && \
  ./get_chrome.sh && \
  ./get_chromedriver.sh && \
  apt-get remove -y curl unzip && \
  apt-get clean && \
  rm ./*sh

RUN useradd -ms /bin/bash testrunner
USER testrunner
WORKDIR /home/testrunner

COPY ./install_python_deps.sh \
  ./requirements.txt \
  ./

RUN ./install_python_deps.sh && \
  rm ./install_python_deps.sh && \
  rm ./requirements.txt

WORKDIR /home/testrunner/tests

CMD [ "python3", "./run_tests.py" ]
