#!/usr/bin/env bash 
set -euxo pipefail

dir=$(mktemp -d)
cat adblock.source | shuf | xargs -n10 -P4 wget --continue --random-wait --directory-prefix=$dir
ls $dir
find $dir -name '*' ! -name adblock.list  -type f -exec cat {} + | sed 's/0\.0\.0\.0//' | grep -v '#' | egrep -o '\<.*\..*\>$' | tr -d '^' | tr -d '|' | xargs basename | sort | uniq > adblock.list

