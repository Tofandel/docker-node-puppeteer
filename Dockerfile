FROM node:18-alpine
# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone


ENV CHROME_BIN="/usr/bin/chromium-browser"
    
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    chromium
    
# Install other libs
RUN apk add --update --no-cache \
    python3 \
    rsync \
    bash \
    curl \
    openssh-client \
    git npm yarn
    
RUN apk del --no-cache make gcc g++ binutils-gold gnupg libstdc++

RUN rm -rf /tmp/* \
/usr/include \
/var/cache/apk/* \
/root/.node-gyp \
/usr/share/man
