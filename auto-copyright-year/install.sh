#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-22T22:02:27+08:00, r33
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp -r "$SCRIPT_DIR"../inc "$GIT_REPO_DIR"hooks/
cp -r "$SCRIPT_DIR"../auto-copyright-year "$GIT_REPO_DIR"hooks/
rm "$GIT_REPO_DIR"hooks/auto-copyright-year/install.sh
cp "$SCRIPT_DIR"../fix-permissions.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x inc/*
chmod +x auto-copyright-year/*
chmod +x fix-permissions.sh


# Script need explicit exit with a code, and check here for reject
HOOK_CONTENT="\${0%/*}/auto-copyright-year/auto-copyright-year.sh
if [ 0 -ne \$? ]; then
    echo Commit is rejected by auto-copyright-year hook
    exit 1
fi"

installHook pre-commit "$HOOK_CONTENT" 1l88daa4h81e55wa


cd "$PWD_BAK"
