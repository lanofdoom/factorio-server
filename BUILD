load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")

container_layer(
    name = "factorio_headless_release_layer",
    directory = "/app",
    tars = ["@factorio_headless_release//file"],
)

container_layer(
    name = "config",
    directory = "/config",
    files = [
        "map-settings.json",
        "server-settings.json",
    ],
)

container_image(
    name = "server_image",
    base = "@distroless_cc_base//image",
    entrypoint = [
        "/app/factorio/bin/x64/factorio",
        "--server-settings=/config/server-settings.json",
        "--map-settings=/config/map-settings.json",
    ],
    layers = [
        ":config",
        ":factorio_headless_release_layer",
    ],
)
