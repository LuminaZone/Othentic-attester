FROM node:18

RUN npm install -g npm@10.5.0

RUN source .env.example

# replace with provided npm access token
ARG NPM_TOKEN={NPM_TOKEN}

WORKDIR /app

RUN echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > $HOME/.npmrc

RUN npm i -g @othentic/othentic-cli

ENTRYPOINT [ "othentic-cli" ]