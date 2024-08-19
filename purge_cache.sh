#!/bin/bash

CACHE_PATH="/var/cache/nginx/img_cache"

if [ -z "$1" ]; then
  echo "Usage: ./purge_cache.sh <file_path>"
  exit 1
fi

FILE_PATH=$1
CACHE_KEY=$(echo -n "${FILE_PATH}" | md5sum | awk '{print $1}')
CACHE_FILE=$(find $CACHE_PATH -type f -name "*${CACHE_KEY}*")

if [ -n "$CACHE_FILE" ]; then
  echo "Purging cache for ${FILE_PATH}..."
  rm -f $CACHE_FILE
  echo "Cache purged for ${FILE_PATH}."
else
  echo "No cache found for ${FILE_PATH}."
fi
