FROM nginx
MAINTAINER leifengyang
ADD html.tar.gz /usr/share/nginx/html
ADD conf.tar.gz /etc/nginx
EXPOSE 80
ENTRYPOINT nginx -g "daemon off;"