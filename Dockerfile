ARG BASEIMAGE=node:12-alpine
FROM ${BASEIMAGE}
RUN apk add --no-cache make pkgconfig gcc g++ python libx11-dev libxkbfile-dev
ARG version=latest
WORKDIR /home/theia
ADD $version.package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL mantainer="Eloy Lopez <elswork@gmail.com>" \
    org.opencontainers.image.title=theia \
    org.opencontainers.image.description="My Multiarch Theia Docker Recipe" \
    org.opencontainers.image.vendor=Deft.Work \
    org.opencontainers.image.url=https://deft.work/theia \
    org.opencontainers.image.source=https://github.com/elswork/theia \
    org.opencontainers.image.version=$VERSION \ 
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.licenses=MIT
# See : https://github.com/theia-ide/theia-apps/issues/34
# RUN addgroup theia && \
#    adduser -G theia -s /bin/sh -D theia;
RUN chmod g+rw /home && \
    mkdir -p /home/project && \
    mkdir -p /home/theia && \
    chown -R node:node /home/theia && \
    chown -R node:node /home/project;
    # chown -R theia:theia /home/theia && \
    # chown -R theia:theia /home/project;
RUN apk add --no-cache git openssh bash
ENV HOME /home/theia
WORKDIR /home/theia
COPY --from=0 --chown=node:node /home/theia /home/theia
# COPY --from=0 --chown=theia:theia /home/theia /home/theia
EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins
ENV USE_LOCAL_GIT true
USER node
# USER theia
ENTRYPOINT [ "node", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0" ]