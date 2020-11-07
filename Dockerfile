FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY appfiles/ ./appfiles/
RUN cd appfiles && npm install @angular/cli && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/appfiles/dist ./appfiles/dist
COPY package*.json ./
RUN npm install
COPY index.js .

EXPOSE 3070

ENTRYPOINT ["node"]

CMD ["index.js"]
