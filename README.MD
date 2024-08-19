# Nginx Image Cache Proxy

This project configures an Nginx server to cache image files with a specific focus: only images that are requested at least twice are cached. It also includes functionality to selectively purge cached images via HTTP requests.

## Getting Started


### 1. Start the Services

Run the following command to build and start the Docker containers:

    docker-compose up


### 2. Check Cache Status

Make a request to an image URL to see the cache status:

    curl -I http://localhost:8080/cat-dog.webp

- **First Call**: The response header `X-Cache-Status` should be `MISS`, indicating that the image is not yet cached.
- **Second Call**: The response header `X-Cache-Status` should be `HIT`, indicating that the image is now cached.

### 3. Purge Cache for an Image

To remove the cached version of an image, use `curl` command:

    curl -X PURGE http://localhost:8080/purge/cat-dog.webp

You should receive a response indicating that the cache file has been successfully purged:

    Successful "Cache file purged."

### Cache Purge Script

The cache purge is handled by a shell script located at `/usr/local/bin/purge_cache.sh`. This script:

- Computes the MD5 hash of the image URL.
- Determines the cache file path based on the hash.
- Deletes the cache file if it exists.

### Configuration

- **Nginx Configuration**: The Nginx configuration file defines the proxy cache path and caching behavior.
- **Cache Path**: All cached files are stored directly in `/var/cache/nginx/image_cache` without directory levels.
