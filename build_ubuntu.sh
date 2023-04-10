#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ]; then
	versions="$(jq -r 'keys | map(@sh) | join(" ")' versions.json)"
	eval "set -- $versions"
fi

# sort version numbers with highest first
IFS=$'\n'; set -- $(sort -rV <<<"$*"); unset IFS

for version; do
	export version
	variant=ubuntu-xenial
	echo build tcimba/python:$version-$variant from $version/$variant
	docker buiuld -t tcimba/python:$version-$variant $version/$variant
done
