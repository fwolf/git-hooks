#! /usr/bin/env bash
#====================================================================
# Find readonly object files in .git directory
#
# The readonly files in .git/ will cause nutstore stop sync.
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T16:31:19+08:00, r19
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"inc/git-functions.sh

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
