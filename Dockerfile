FROM node:16-alpine
# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone


ENV CHROME_BIN="/usr/bin/chromium-browser" \
    NODE_ENV="production"
    
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    chromium
    
# Install other libs
RUN apk add --update --no-cache \
    python3 \
    openssh-client \
    git
    
RUN npm install -g yarn
    
RUN apk del --no-cache make gcc g++ binutils-gold gnupg libstdc++

RUN rm -rf /tmp/* \
/usr/include \
/var/cache/apk/* \
/root/.node-gyp \
/usr/share/man
