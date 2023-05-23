load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")

container_layer(
    name = "factorio_server",
    directory = "/opt",
    tars = ["@factorio_headless_release//file"],
)

container_layer(
    name = "config",
    directory = "/etc/factorio",
    files = [
        "map-gen-settings.json",
        "map-settings.json",
        "server-settings.json",
    ],
)

container_image(
    name = "server_image",
    base = "@distroless_cc_base//image",
    entrypoint = [
        "/opt/factorio/bin/x64/factorio",
        "--server-settings=/etc/factorio/server-settings.json",
        "--map-settings=/etc/factorio/map-settings.json",
        "--map-gen-settings=/etc/factorio/map-gen-settings.json",
    ],
    layers = [
        ":factorio_server",
        ":config",
    ],
)

sh_test(
    name = "server_image_test",
    srcs = ["test.sh"],
    deps = [":server_image"],
)
