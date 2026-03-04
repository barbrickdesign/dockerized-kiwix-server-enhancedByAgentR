FROM alpine:3.21
LABEL maintainer="Jan Szumiec <jan.szumiec@gmail.com>"

# Install kiwix-tools from the Alpine community repository
RUN apk add --no-cache kiwix-tools

# Create a non-root user and set up the data directory
RUN adduser -D -u 1000 kiwix && \
    mkdir -p /kiwix-data && \
    chown kiwix:kiwix /kiwix-data

USER kiwix
WORKDIR /kiwix-data
VOLUME /kiwix-data

EXPOSE 8080

# Verify the server is healthy and responding
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD wget -qO- http://localhost:8080/ > /dev/null || exit 1

# CMD arguments are appended to ENTRYPOINT, allowing the caller to pass
# a single ZIM filename or flags like --library /kiwix-data/library.xml
ENTRYPOINT ["kiwix-serve", "--port", "8080"]


