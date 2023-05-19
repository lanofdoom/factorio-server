# LAN of DOOM Factorio Server

This repository repackages the factorio dedicated server as a container image.

# Usage

This contain is not prescriptive about config or data paths. These paths are specified in the server command line options and can be set to any path.

- ``docker run --rm -it -v factorio:/data ghcr.io/lanofdoom/factorio-server:latest --create /data/save``
- ``docker run --rm -it -v factorio:/data ghcr.io/lanofdoom/factorio-server:latest --start-server /data/save``

The included `/config/server-settings.json` and `/config/map-settings.json` files are loaded by default.

More information on server configuration on https://wiki.factorio.com/Multiplayer.

# Updates

The Factorio version used is specified in the `WORKSPACE` file and must be updated manually.
