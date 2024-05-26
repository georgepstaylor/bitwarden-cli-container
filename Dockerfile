FROM debian:bookworm-slim
ARG DEBIAN_FRONTEND=noninteractive

ARG BW_VERSION

RUN apt update -y && apt install -y curl unzip coreutils && apt clean

RUN curl -L https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip --output /tmp/bw.zip && \
    curl -L https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-sha256-${BW_VERSION}.txt --output /tmp/bw.zip.sha256 \
    && sha256sum /tmp/bw.zip | grep -q -F "$(cat /tmp/bw.zip.sha256)" \
    && unzip /tmp/bw.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/bw && \
    rm /tmp/bw*

ENTRYPOINT ["/usr/local/bin/bw"]
