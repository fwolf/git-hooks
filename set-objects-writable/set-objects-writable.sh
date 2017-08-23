#! /usr/bin/env bash
#====================================================================
# Set git object files writable so can sync with nutstore
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

find "$GIT_REPO_DIR" -type f ! -perm /u=w -exec chmod u+w '{}' \;
