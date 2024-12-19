#!/usr/bin/env nix-shell
#!nix-shell -p bash -i bash

set -euo pipefail

readonly _day="${1:-}"

if [ -z "${_day}" ];  then
    echo "ERROR: day not provided"
    echo
    echo "USAGE: ${0} [day #]"
    exit 1
fi

main() {
    local part
    local day=$(printf "%02d\n" $_day)
    if [ -d "day_${day}/part_01" ]; then
        local part="02"
        cp -r "day_${day}/part_01" "day_${day}/part_02"
    else
        local part="01"
        local -r path="day_${day}/part_01"
        mkdir -p "${path}"
        touch "${path}/input_test.txt"
        touch "${path}/input.txt"
        cat << EOF  > "${path}/run_it.rb"
def load_input
  File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)
end

main
EOF
    fi

    code "day_${day}/part_${part}"
}

main
