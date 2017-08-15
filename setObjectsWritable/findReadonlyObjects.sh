#! /usr/bin/env bash
#====================================================================
# Find readonly object files in .git directory
#
# The readonly files in .git/ will cause nutstore stop sync.
#
# Gist: https://gist.github.com/fwolf/e4b4c99e3c7b9728cd1a9ec9fbc73b21
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"git-functions.sh

checkGitCommandAvailable

checkGitRoot

findGitRepositoryDir "$GIT_ROOT"


checkFile() {
    if [[ -f "$1" && ! -w "$1" ]]; then
        echo "$1"
    fi
}


cd "$GIT_ROOT"
find "$GIT_REPO_DIR" | xargs -I '{}' bash -c "$(declare -f checkFile); checkFile '{}'"
