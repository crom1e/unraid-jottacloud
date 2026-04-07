FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -L -o /tmp/jotta-cli.deb https://repo.jotta.cloud/debian/pool/main/j/jotta-cli/jotta-cli_0.17.159692_amd64.deb && \
    apt-get install -y /tmp/jotta-cli.deb && \
    rm /tmp/jotta-cli.deb && \
    apt-get clean

WORKDIR /backup

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]