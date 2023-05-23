#!/bin/bash -ue
#
# This script just builds the image, generates a map, then launches the server.
#

v=test-data
docker volume rm $v && true

bazel run //:server_image
i=bazel:server_image

docker run --rm -v $v:/data $i --create /data/save

docker run --rm -v $v:/data $i --start-server /data/save
