FROM openresty/openresty:alpine

# Create the log directory and ensure it's writable
RUN mkdir -p /var/log/nginx && \
    touch /var/log/nginx/error.log /var/log/nginx/access.log && \
    chown -R nobody:nogroup /var/log/nginx

COPY mime.types /usr/local/openresty/nginx/conf/mime.types
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY purge_cache.sh /usr/local/bin/purge_cache.sh

RUN chmod +x /usr/local/bin/purge_cache.sh

# Add debugging info
RUN echo "Container built successfully and all files copied" > /var/log/nginx/build.log

# Override CMD to allow inspection in case of failure
CMD ["/bin/sh", "-c", "tail -f /var/log/nginx/build.log /var/log/nginx/error.log & /usr/local/openresty/nginx/sbin/nginx -g 'daemon off;'"]
