# LAN of DOOM Factorio Server

This repository repackages the factorio server as a container image.

# Usage

The server can be started by running the container with the `--start-server save.zip` option. The `--create save.zip` option can be used to create a new map which must exist before starting the server.

- ``docker run --rm -it -v factorio:/data ghcr.io/lanofdoom/factorio-server:latest --start-server save.zip``

By default, the server listens on `UDP` port `34197`, the `write-data` directory is `~/.factorio`, and the `config-path` is `/etc/factorio`.

# Configuration

More information on server configuration can be found on https://wiki.factorio.com/Multiplayer.

The server is mostly configured by config files, boilerplate can be found in the `/usr/share/factorio` directory in the container or over at https://github.com/wube/factorio-data. These files will need to be mapped into the container and their paths provided to the server using command line options.

# Updates

The Factorio version used is specified in `repos.bzl` and must be updated manually.
