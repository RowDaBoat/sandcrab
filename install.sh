#!/usr/bin/env sh
# sandcrab installer — run with:
#   curl -fsSL https://raw.githubusercontent.com/<owner>/sandcrab/master/install.sh | sh
#
# Override the source with SANDCRAB_REPO_RAW (raw base URL, no trailing slash):
#   curl -fsSL .../install.sh | SANDCRAB_REPO_RAW=https://raw.githubusercontent.com/me/sandcrab/master sh
set -eu

# Raw base URL the files are fetched from. Defaults to this repo's master branch.
REPO_RAW="${SANDCRAB_REPO_RAW:-https://raw.githubusercontent.com/LibreriadeSatoshi/sandcrab/master}"

BIN_DIR="${HOME}/.sandcrab/bin"
FILES="sandcrab Dockerfile.template"

# Pick a downloader.
if command -v curl >/dev/null 2>&1; then
    fetch() { curl -fsSL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
    fetch() { wget -qO "$2" "$1"; }
else
    echo "sandcrab: need curl or wget to install" >&2
    exit 1
fi

mkdir -p "${BIN_DIR}"

for f in ${FILES}; do
    echo "sandcrab: fetching ${f}"
    fetch "${REPO_RAW}/${f}" "${BIN_DIR}/${f}"
done

chmod +x "${BIN_DIR}/sandcrab"

echo
echo "sandcrab: installed to ${BIN_DIR}"
echo "Add it to your PATH by adding this line to your shell profile (~/.bashrc, ~/.zshrc, ...):"
echo
echo "    export PATH=\"\$HOME/.sandcrab/bin:\$PATH\""
echo
