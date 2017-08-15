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


# Check if git command is available
# @see https://stackoverflow.com/a/7522866/1759745
if ! type "git" > /dev/null 2>&1; then
    echo
    echo "Command 'git' is not available"
    exit
fi


# Find .git dir location
# Will return absolute path
GIT_ROOT=`git rev-parse --show-toplevel`
if [ 0 -ne $? ]; then
    echo
    echo "This command must run in git repository"
    exit
fi


# Check is git or submodule
if [ -d "$GIT_ROOT"/.git ]; then
    # This is a normal git repository, dest is absolute path
    DEST_DIR="$GIT_ROOT"/.git/
else
    # This a git submodule repository, dest is relate path from submodule root
    # Git dir is under parent git repo, but still is a complete repo
    # Got: gitdir: ../../.git/modules/blah
    DEST_DIR=`cat "$GIT_ROOT"/.git`
    # Get tail part
    DEST_DIR=${DEST_DIR:8}
fi


checkFile() {
    if [[ -f "$1" && ! -w "$1" ]]; then
        echo "$1"
    fi
}


cd "$GIT_ROOT"
find "$DEST_DIR" | xargs -I '{}' bash -c "$(declare -f checkFile); checkFile '{}'"
