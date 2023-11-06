load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def repos(bzlmod = False):
    """Fetches repositories"""
    http_archive(
        name = "factorio_headless_release",
        build_file_content = """

filegroup(
    name = "data",
    srcs = glob(["data/**"], exclude = [
        "data/*.txt",
        "data/base/campaigns/**",
        "data/base/scenarios/**",
        "data/core/fonts/**",
        "data/core/graphics/**",
    ]),
    visibility = ["//visibility:public"]
)

filegroup(
    name = "bin",
    srcs = glob(["bin/**"]),
    visibility = ["//visibility:public"]
)

        """,
        sha256 = "96289caf52d1c7b15eb95be54104c69d41752b345c6fdc6b984a7cdb06425a2a",
        strip_prefix = "factorio",
        type = "tar.xz",
        urls = ["https://factorio.com/get-download/1.1.94/headless/linux64"],
    )

repos_bzlmod = module_extension(implementation = repos)
