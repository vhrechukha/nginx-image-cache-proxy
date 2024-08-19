FROM openresty/openresty:alpine

# Create necessary directories with correct permissions
RUN mkdir -p /var/cache/nginx /var/log/nginx /usr/local/openresty/nginx/client_body_temp /usr/local/openresty/nginx/proxy_temp && \
    chown -R nobody:nogroup /var/cache/nginx /var/log/nginx /usr/local/openresty/nginx/client_body_temp /usr/local/openresty/nginx/proxy_temp && \
    chmod -R 777 /var/cache/nginx /var/log/nginx /usr/local/openresty/nginx/client_body_temp /usr/local/openresty/nginx/proxy_temp

# Copy configuration and scripts
COPY mime.types /usr/local/openresty/nginx/conf/mime.types
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY purge_cache.sh /usr/local/bin/purge_cache.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/purge_cache.sh

# Start Nginx
CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
