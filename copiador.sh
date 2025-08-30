#!/bin/bash


dir="$(pwd)"
dir_extensiones="$dir/extensiones"
mkdir -p "$dir_extensiones"
. "$dir/funciones.sh"

mapfile -t extensiones_configuradas < <(dconf dump /org/gnome/shell/extensions/ | grep -E '^\[[a-z].*\]$' | sed 's/\[//; s/\]//' | grep -v '/')
mapfile -t extensiones < <(/bin/ls ~/.local/share/gnome-shell/extensions)


for e in "${extensiones[@]}"; do
echo "$e"
done
