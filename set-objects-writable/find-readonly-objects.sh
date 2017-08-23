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
# Last Modified: 2017-08-23T12:48:54+08:00, r44
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh

checkGitCommandAvailable

checkGitRoot

findGitRepositoryDir "$GIT_ROOT"


cd "$GIT_ROOT"

# -perm /u=w means have any of permission: owner can write
# put ! before -perm means condition check fail
find "$GIT_REPO_DIR" -type f ! -perm /u=w
