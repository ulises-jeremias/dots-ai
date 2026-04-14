#!/usr/bin/env bash

if [[ -t 1 && -z ${NO_COLOR:-} ]]; then
  c_reset=$'\033[0m'
  c_blue=$'\033[1;34m'
else
  c_reset=''
  c_blue=''
fi

info() { printf '%b[easy-options-example]%b %s\n' "$c_blue" "$c_reset" "$*"; }

## EasyOptions Example
## Copyright (C) Someone
## Licensed under XYZ
##
## This program is an example of EasyOptions. It just prints the options and
## arguments provided in command line. Usage:
##
##     @script.name [option] ARGUMENTS...
##
## Options:
##     -h, --help              All client scripts have this, it can be omitted.
##     -o, --some-option       This is a boolean option. Long version is
##                             mandatory, and can be specified before or
##                             after short version.
##         --some-boolean      This is a boolean option without a short version.
##         --some-value=VALUE  This is a parameter option. When calling your script
##                             the equal sign is optional and blank space can be
##                             used instead. Short version is not available in this
##                             format.

ROOT="$(realpath "$(dirname "$0")")"
. "${ROOT}/opts.sh" || exit # Bash implementation, slower

# Boolean and parameter options
[[ -n $some_option ]] && info "Option specified: --some-option"
[[ -n $some_boolean ]] && info "Option specified: --some-boolean"
[[ -n $some_value ]] && info "Option specified: --some-value is $some_value"

# Arguments
for argument in "${arguments[@]}"; do
  info "Argument specified: $argument"
done
