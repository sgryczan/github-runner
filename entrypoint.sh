#!/bin/sh
url="https://github.com/${ORG_NAME}"

./config.sh \
    --name $(hostname) \
    --token ${TOKEN} \
    --url ${url} \
    --work ${RUNNER_WORKDIR} \
    --labels ${RUNNER_LABELS} \
    --unattended \
    --replace

remove() {
    ./config.sh remove --unattended --token "${TOKEN}"
}

trap 'remove; exit 130' INT
trap 'remove; exit 143' TERM

./run.sh "$*" &

wait $!
