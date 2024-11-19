load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

VERSION_factorio = "2.0.20"
HEADLESS_URL = "https://factorio.com/get-download/{}/headless/linux64".format(VERSION_factorio)

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
        integrity = "",
        strip_prefix = "factorio",
        type = "tar.xz",
        urls = [HEADLESS_URL],
    )

repos_bzlmod = module_extension(implementation = repos)
