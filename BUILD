load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")

# config-path.cfg configures the following:
# - `config-path` is `/etc/factorio`
# - `write-data` is `~/.factorio` (via use-system-read-write-data-directories=true)
# - `read-data` is `/usr/share/factorio` (via use-system-read-write-data-directories=true)
#

pkg_tar(
    name = "factorio_headless",
    srcs = [
        "config-path.cfg",
        "@factorio_headless_release//:bin",
        "@factorio_headless_release//:data",
    ],
    remap_paths = {
        "config-path.cfg": "/opt/factorio/config-path.cfg",
        "/data": "/usr/share/factorio",
        "/bin": "/opt/factorio/bin",
    },

    # this is taking advantage of a bug that causes the tree to not be flatened
    strip_prefix = "./external/_main~repos_bzlmod~factorio_headless_release",
)

pkg_tar(
    name = "mods",
    srcs = [],
    package_dir = "/root/.factorio/mods",
)

oci_image(
    name = "image",
    base = "@distroless_base",
    entrypoint = ["/opt/factorio/bin/x64/factorio"],
    tars = [
        ":factorio_headless",
        ":mods",
    ],
)

oci_push(
    name = "image_push",
    image = ":image",
    remote_tags = ["latest"],
    repository = "ghcr.io/lanofdoom/factorio-server",
)

oci_tarball(
    name = "image_tarball",
    image = ":image",
    repo_tags = ["factorio-server:bazel"],
)

sh_test(
    name = "test_create_map",
    srcs = ["test_create_map.sh"],
    data = [":image_tarball"],
    deps = ["@bazel_tools//tools/bash/runfiles"],
)
