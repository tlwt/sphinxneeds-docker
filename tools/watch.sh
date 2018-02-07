#!/bin/sh
# Path to watch
dir1=/project/input
echo "Waiting for a change in $dir1 ..."
# Wait for a modify event ...
while inotifywait -qqre modify "$dir1"; do
    # Rebuild the doc ...
    /tools/runAfterBoot.sh
    echo "Waiting for a change in $dir1 ..."
# Over and over ...
done
