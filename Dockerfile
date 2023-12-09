FROM node:21-alpine

COPY package.json /app/
COPY src /app/

WORKDIR /app

RUN yarn

CMD [ "yarn", "dev" ]
