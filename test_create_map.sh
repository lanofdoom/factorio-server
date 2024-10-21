#!/bin/bash -ue
#
# This script does a quick smoke check of the server. It uses the `--create`
# option to generate a new map and check that the process succeeds.

image_load=$1
output=$2

$image_load
docker run --rm factorio-server:bazel --create $output
