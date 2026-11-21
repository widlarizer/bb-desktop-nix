#!/usr/bin/env bash
# Point release.json at the release that get-bb/bb's desktop-latest tag names.
set -euo pipefail
cd "$(dirname "$0")"
manifest=$(curl -fsSL https://github.com/get-bb/bb/releases/download/desktop-latest/desktop-version-linux.json)
version=$(jq -r .version <<<"$manifest")
path=$(jq -r .path <<<"$manifest")
sha512=$(jq -r .sha512 <<<"$manifest")
jq -n --arg v "$version" \
  --arg u "https://github.com/get-bb/bb/releases/download/desktop-v$version/$path" \
  --arg h "sha512-$sha512" \
  '{version: $v, url: $u, hash: $h}' > release.json
echo "bb desktop $version"
