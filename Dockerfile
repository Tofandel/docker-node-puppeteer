FROM node:16-alpine
# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone


ENV CHROME_BIN="/usr/bin/chromium-browser" \
    NODE_ENV="production"
    
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    dumb-init \
    udev \
    ttf-freefont \
    chromium
    
# Install other libs
RUN apk add --update --no-cache \
    python3 \
    openssh-client \
    git bash \
    npm yarn
    
RUN apk del --no-cache make gcc g++ python binutils-gold gnupg libstdc++

RUN rm -rf /tmp/* \
/usr/include \
/var/cache/apk/* \
/root/.node-gyp \
/usr/share/man

SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "-l", "-c"]
