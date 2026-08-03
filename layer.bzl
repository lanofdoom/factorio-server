def _dest_under(path, marker, prefix):
    index = path.find(marker)
    if index == -1:
        fail("expected '{}' in '{}'".format(marker, path))
    return "{}/{}".format(prefix, path[index + len(marker):])

def _factorio_layer_impl(ctx):
    manifest = ctx.actions.declare_file(ctx.label.name + ".manifest")
    lines = [
        "{}\t{}\n".format(ctx.file.config.path, "opt/factorio/config-path.cfg"),
    ]

    for src in ctx.files.bin_srcs:
        lines.append("{}\t{}\n".format(src.path, _dest_under(src.short_path, "/bin/", "opt/factorio/bin")))

    for src in ctx.files.data_srcs:
        lines.append("{}\t{}\n".format(src.path, _dest_under(src.short_path, "/data/", "usr/share/factorio/data")))

    ctx.actions.write(manifest, "".join(lines))

    output = ctx.outputs.out
    command = """set -euo pipefail
staging="$$(mktemp -d "$${TMPDIR:-/tmp}/factorio-layer.XXXXXX")"
trap 'rm -rf "$$staging"' EXIT

mkdir -p "$$staging/root/.factorio/mods"

while IFS=$'\t' read -r src dest; do
  target="$$staging/$$dest"
  mkdir -p "$$(dirname "$$target")"
  cp -a "$$src" "$$target"
done < "$1"

tar \
  --create \
  --file "$2" \
  --directory "$$staging" \
  --sort=name \
  --mtime='UTC 1970-01-01' \
  --owner=0 \
  --group=0 \
  --numeric-owner \
  .
"""

    ctx.actions.run_shell(
        inputs = depset([manifest], transitive = [
            depset(ctx.files.bin_srcs),
            depset(ctx.files.data_srcs),
            depset([ctx.file.config]),
        ]),
        outputs = [output],
        arguments = [manifest.path, output.path],
        command = command,
        mnemonic = "FactorioLayerTar",
        progress_message = "Building {}".format(output.short_path),
    )

factorio_layer = rule(
    implementation = _factorio_layer_impl,
    attrs = {
        "config": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "bin_srcs": attr.label_list(
            mandatory = True,
            allow_files = True,
        ),
        "data_srcs": attr.label_list(
            mandatory = True,
            allow_files = True,
        ),
        "out": attr.output(
            mandatory = True,
        ),
    },
)
