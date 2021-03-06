#! /usr/bin/env bash
set -e

#/uwsgi-nginx-entrypoint.sh

# Get the URL for static files from the environment variable
#USE_STATIC_URL=${STATIC_URL:-'/static'}
# Get the absolute path of the static files from the environment variable
#USE_STATIC_PATH=${STATIC_PATH:-'/app/static'}
# Get the listen port for Nginx, default to 80
#USE_LISTEN_PORT=${LISTEN_PORT:-80}

RPC_ENDPOINT=${HSELING_RPC_ENDPOINT}


content_server='server {\n'
content_server=$content_server"    listen 80;\n"
#    content_server=$content_server'    location / {\n'
#    content_server=$content_server'        try_files $uri @app;\n'
#    content_server=$content_server'    }\n'
content_server=$content_server'    gzip on;\n'
content_server=$content_server'    gzip_min_length 256;'
content_server=$content_server'    gzip_types application/javascript;'
#    content_server=$content_server'    location @app {\n'
#    content_server=$content_server'        include uwsgi_params;\n'
#    content_server=$content_server'        uwsgi_pass unix:///tmp/uwsgi.sock;\n'
#    content_server=$content_server'    }\n'
#    content_server=$content_server"    location $USE_STATIC_URL {\n"
#    content_server=$content_server"        alias $USE_STATIC_PATH;\n"
#    content_server=$content_server'    }\n'
content_server=$content_server'    location / {\n'
content_server=$content_server'        root   /usr/share/nginx/html;\n'
content_server=$content_server'        index  index.html index.htm;\n'
content_server=$content_server'        try_files $uri $uri/ /index.html;\n'
content_server=$content_server'    }\n'
content_server=$content_server'    location /rpc/ {\n'
content_server=$content_server'        add_header Access-Control-Allow-Origin *;\n'
content_server=$content_server'        add_header X-Robots-Tag "noindex, follow" always;\n'
content_server=$content_server"        proxy_pass $RPC_ENDPOINT;\n"
content_server=$content_server'    }\n'
content_server=$content_server'    error_page  405     =200 $uri;'
# If STATIC_INDEX is 1, serve / with /static/index.html directly (or the static URL configured)
#    if [ "$STATIC_INDEX" = 1 ] ; then
#        content_server=$content_server'    location = / {\n'
#        content_server=$content_server"        index $USE_STATIC_URL/index.html;\n"
#        content_server=$content_server'    }\n'
#    fi
content_server=$content_server'}\n'
# Save generated server /etc/nginx/conf.d/nginx.conf
printf "$content_server" > /etc/nginx/conf.d/default.conf

exec "$@"