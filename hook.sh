#!/usr/bin/env bash

_stdin=$(cat)

PS4='+ $(date --rfc-3339=seconds), ${BASH_SOURCE-}:${LINENO-}: '
export PS4
trap 'echo Unhandled error at ${BASH_SOURCE-}:${LINENO-} caused exit with code $?. >&2' ERR
set -o nounset -o pipefail -o errexit -o errtrace

global_hooks_dir="${XDG_CONFIG_HOME:-$HOME/.config}/git/global_hooks"
global_specific_hook_dir_d="${global_hooks_dir}/$(basename "${0}").d"
if [ -d "$global_specific_hook_dir_d" ]; then
    for hook in "$global_specific_hook_dir_d"/*; do
        if [ "$_stdin" = "" ]; then
            "$hook" "$@" || exit $?
        else
            "$hook" "$@" <<<"$_stdin" || exit $?
        fi
    done
fi

git_dir=$(git rev-parse --git-dir)
script_name=$(basename "$0")
if [ -x "${git_dir}/hooks/${script_name}" ]; then
    if [ "$_stdin" = "" ]; then
        "${git_dir}/hooks/${script_name}" "$@" || exit $?
    else
        "${git_dir}/hooks/${script_name}" "$@" <<<"$_stdin" || exit $?
    fi
fi
