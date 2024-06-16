#!/usr/bin/env bash

vars=$(dirname "$0")
source "${vars}"/vars.sh

mkdir -p "$config_path"/clipcat
clipcatd default-config >"$config_path"/clipcat/clipcatd.toml
clipcatctl default-config >"$config_path"/clipcat/clipcatctl.toml
clipcat-menu default-config >"$config_path"/clipcat/clipcat-menu.toml
