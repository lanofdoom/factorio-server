workspace(name = "com_github_lanofdoom_factorio_server")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_file(
    name = "factorio_headless_release",
    downloaded_file_path = "factorio.tar.xz",
    sha256 = "60b3884b6dad1f4c7b30b7ef2b63619ff4a3204ac7fd894cf09d382b349857cc",
    urls = ["https://factorio.com/get-download/1.1.87/headless/linux64"],
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.25.0/rules_docker-v0.25.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
    name = "distroless_cc_base",
    digest = "sha256:41036fc7ed8df0f6addc18484cef0c94a85867508967789f947e11ffd5ff0cc8",
    registry = "gcr.io",
    repository = "distroless/cc",
)
