#!/bin/sh

CACHE_PATH="/var/cache/nginx/image_cache"

if [ -z "$1" ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

FILE_PATH=$1


CACHE_KEY=$(echo -n "$FILE_PATH" | md5sum | awk '{print $1}')
echo "DEBUG: CACHE_KEY is '$CACHE_KEY'"

CACHE_FILE="${CACHE_PATH}/${CACHE_KEY}"

# Debugging output
echo "DEBUG: CACHE_FILE path is '$CACHE_FILE'"

if [ -f "$CACHE_FILE" ]; then
  echo "Cache file found: $CACHE_FILE"
  rm -f $CACHE_FILE
  echo "Cache file purged."
else
  echo "No cache file found for ${FILE_PATH}"
  echo "Cache path: $CACHE_PATH"
  echo "CACHE_KEY: $CACHE_KEY"

  # List all files in the cache directory and its subdirectories
  echo "Listing all cache files in $CACHE_PATH:"
  find "$CACHE_PATH" -type f -print
fi
