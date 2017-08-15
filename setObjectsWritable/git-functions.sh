#! /usr/bin/env bash
#====================================================================
# Git relate functions
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


# Check if git command is available
# @see https://stackoverflow.com/a/7522866/1759745
function checkGitCommandAvailable() {
    if ! type "git" > /dev/null 2>&1; then
        echo
        echo "Command 'git' is not available"
        exit
    fi
}


# Check current is in .git dir, and return its location
# Will return absolute path
# This root is also working tree (root)
function checkGitRoot() {
    GIT_ROOT=`git rev-parse --show-toplevel`
    if [ 0 -ne $? ]; then
        echo
        echo "This command must run in git repository"
        exit
    fi
}


# Find git repository dir, aka .git dir(various in submodule)
# @see https://git-scm.com/docs/gitrepository-layout
function findGitRepositoryDir() {
    local GIT_ROOT="$1"

    # Check is git or submodule
    if [ -d "$GIT_ROOT"/.git ]; then
        # This is a normal git repository, dest is absolute path
        GIT_REPO_DIR="$GIT_ROOT"/.git/

    else
        # This a git submodule repository, dest is relate path from submodule root
        # Git dir is under parent git repo, but still is a complete repo
        # Got: gitdir: ../../.git/modules/blah
        GIT_REPO_DIR=`cat "$GIT_ROOT"/.git`
        # Get tail part
        GIT_REPO_DIR=${GIT_REPO_DIR:8}
    fi
}
