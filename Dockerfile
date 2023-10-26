FROM ubuntu:23.04

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

RUN for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done || true

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

WORKDIR /root
VOLUME [ "/root/work", "/root/actions-runner/" ]

RUN mkdir actions-runner && \
    cd actions-runner && \
    curl -o actions-runner-linux-x64-2.310.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz &&\
    echo "fb28a1c3715e0a6c5051af0e6eeff9c255009e2eec6fb08bc2708277fbb49f93  actions-runner-linux-x64-2.310.2.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-x64-2.310.2.tar.gz && rm ./actions-runner-linux-x64-2.310.2.tar.gz

COPY entrypoint.sh /home/runner/

ENTRYPOINT [ "/home/runner/entrypoint.sh" ]
