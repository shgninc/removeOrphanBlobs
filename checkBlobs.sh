#!/bin/bash

BASE_PATH="/storage/registry/docker/registry/v2/blobs/sha256/$1"
folders=("$BASE_PATH"/*)
total=${#folders[@]}
count=0
progress_bar() {
    progress=$(( 100 * count / total ))
    bar_size=40
    filled=$(( bar_size * progress / 100 ))
    empty=$(( bar_size - filled ))

    printf "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    printf "] %d%% (%d/%d)" "$progress" "$count" "$total"
}

for dir in "${folders[@]}";
do
  if [ -d "$dir" ]; then
        folder=$(basename "$dir")
        exist=$(docker exec harbor-db psql -d registry --no-align --tuples-only -c "select count(*) from public.blob where digest like '%$folder%'")
        if [ "$exist" -eq 0 ]; then
                echo "folder removed $dir"
                rm -rf "$dir"
        else
                echo "folder not removed $dir"
        fi
  fi
  count=$((count + 1))
  progress_bar
done
