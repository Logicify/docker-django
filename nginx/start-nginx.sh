#!/bin/sh

cat > /etc/nginx/nginx_params <<-EOF
proxy_send_timeout $PROXY_TIMEOUT;
proxy_read_timeout $PROXY_TIMEOUT;
set \$wsgi_host '127.0.0.1';
set \$wsgi_port $APP_PORT;
set \$static_location $STATIC_PATH;
set \$media_location $MEDIA_PATH;
EOF

nginx -g 'daemon off;'
