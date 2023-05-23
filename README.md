# LAN of DOOM Factorio Server

This repository repackages the factorio server as a container image.

# Usage

To run a server, start the container with the `--start-server /data/save` command line argument. This will fail if the designated save file (`/data/save.zip` in this case) does not exist. Start the container with the `--create /data/save` option to use the map generator or alternately upload an existing save.

- ``docker run --rm -it -v factorio:/data ghcr.io/lanofdoom/factorio-server:<tag> --start-server /data/save``

Map and server configuration files are provided in `/etc/factorio` and are loaded by default.

More information on server configuration on https://wiki.factorio.com/Multiplayer.

# Updates

The Factorio version used is specified in the `WORKSPACE` file and must be updated manually.
