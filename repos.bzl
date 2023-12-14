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
        sha256 = "9850dd146f93ee4da8ba06316591888860a4058c8548409cdfb5dd693abcd834",
        strip_prefix = "factorio",
        type = "tar.xz",
        urls = ["https://factorio.com/get-download/1.1.100/headless/linux64"],
    )

repos_bzlmod = module_extension(implementation = repos)
