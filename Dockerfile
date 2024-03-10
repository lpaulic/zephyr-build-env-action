# Use Zephyr project CI image 
FROM zephyrprojectrtos/ci:v0.26.9

ARG ZEPHYR_PROJECT_DIR="/opt/zephyrproject"
ARG ZEPHYR_BUILD_ENV_SCRIPT="${ZEPHYR_PROJECT_DIR}/zephyr/zephyr-env.sh" 

RUN mkdir "${ZEPHYR_PROJECT_DIR}" && \
    west init -m https://github.com/zephyrproject-rtos/zephyr --mr v3.6.0 "${ZEPHYR_PROJECT_DIR}"
RUN cd "${ZEPHYR_PROJECT_DIR}" && \
    west update && \
    west zephyr-export
RUN pip3 install --user -r "${ZEPHYR_PROJECT_DIR}"/zephyr/scripts/requirements.txt

USER root
ENV ZEPHYR_BUILD_ENV_SCRIPT=$ZEPHYR_BUILD_ENV_SCRIPT

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
