FROM node:lts-alpine as front

COPY ./hseling-web-antidict/package*.json ./app/hseling_web_antidict/

WORKDIR ./app/hseling_web_antidict/
RUN npm install .
WORKDIR ../..
COPY ./hseling-web-antidict/ ./app/hseling_web_antidict/

WORKDIR ./app/hseling_web_antidict/

RUN npm run build

FROM nginx

COPY --from=front /app/hseling_web_antidict/build /usr/share/nginx/html
COPY --from=front /app/hseling_web_antidict/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=front /app/hseling_web_antidict/nginx.conf.template /etc/nginx/conf.d

EXPOSE 8000
CMD ["nginx",  "-g", "daemon off;"]
