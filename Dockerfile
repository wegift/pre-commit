FROM python:3.9

# https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG NODE_VERSION=18.12.1
ARG PRE_COMMIT_VERSION=v2.17.0
ARG GO_VERSION=1.18.2
# Install nodejs, pre-commit and make cache directory
RUN (curl -sL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar -xz --strip-components=1 -C /usr/) \
    && npm -g update \
    && npm cache clean --force \
    && pip install --no-cache-dir pre-commit==${PRE_COMMIT_VERSION} \
    && mkdir -p /pre-commit-cache \
    && curl -sL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -xz -C /usr/local/

ENV PATH="/usr/local/go/bin:${PATH}" PRE_COMMIT_HOME=/pre-commit-cache

# Make a test directory and set default command to run pre-commit on it
RUN mkdir /test
WORKDIR /test
CMD [ "pre-commit", "run", "--all-files", "--show-diff-on-failure" ]
