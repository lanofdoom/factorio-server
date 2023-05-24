load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")

container_layer(
    name = "factorio_server",
    directory = "/opt",
    tars = ["@factorio_headless_release//file"],
)

# config-path.cfg configures the following:
# - `config-path` is `/etc/factorio`
# - `write-data` is `~/.factorio` (via use-system-read-write-data-directories=true)
# - `read-data` is `/usr/share/factorio` (via use-system-read-write-data-directories=true)
#
# To match the default `read-data` path, a symlink is created to the data
# directory from the extracted factorio package (`/opt/factorio/data`).
#
container_layer(
    name = "config_path_cfg",
    directory = "/opt/factorio",
    files = [
        "config-path.cfg",
    ],
    symlinks = {"/usr/share/factorio": "/opt/factorio/data"},
)

container_image(
    name = "server_image",
    base = "@distroless_cc_base//image",
    entrypoint = ["/opt/factorio/bin/x64/factorio"],
    layers = [
        ":factorio_server",
        ":config_path_cfg",
    ],
)

sh_test(
    name = "generate_map_test",
    srcs = ["generate_map_test.sh"],
    data = [":server_image.tar"],
    deps = ["@bazel_tools//tools/bash/runfiles"],
)
