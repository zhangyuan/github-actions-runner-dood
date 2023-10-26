#! /bin/bash

if [ "$1" = "run" ]; then
    set -euo pipefail
    (cd $HOME/actions-runner && ./config.sh --unattended --url "$REPO_URL" --token "$REGISTRATION_TOKEN" --name "${RUNNER_NAME}" --replace && ./run.sh)
    cd $HOME/actions-runner && echo | ./config.sh remove
else
    set -euo pipefail
    eval $@
fi
