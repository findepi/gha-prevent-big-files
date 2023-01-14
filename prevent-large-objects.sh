#!/bin/sh

set -euf

# This script takes a list of object ids on stdin
# Pipe this script a list of objects/paths from e.g.
# ```
# git rev-list --objects "${MERGE_BASE}..${BRANCH}"
# ```

max_size="${1:?need max object size}"

found="false"
while read -r obj_id path; do
  size="$(git cat-file -s "$obj_id")"
  if [ "$size" -lt "$max_size" ]; then
    continue
  fi

  if [ "$found" = "false" ]; then
    # First time we got a positive
    echo "Large git objects found:"
  fi
  found="true"

  echo "$size" "$path"
done

if [ "$found" = "false" ]; then
  echo "No large git objects found"
  exit 0
else
  exit 1
fi
