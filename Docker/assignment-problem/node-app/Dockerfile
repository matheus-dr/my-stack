FROM node:18.13.0-alpine

WORKDIR /usr/app

COPY package.json .

RUN npm i

COPY . .

EXPOSE 3000

CMD [ "node", "server.js" ]
