#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-20T10:52:12+08:00, r29
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp -r "$SCRIPT_DIR"../inc "$GIT_REPO_DIR"hooks/
cp -r "$SCRIPT_DIR"../phpcs "$GIT_REPO_DIR"hooks/
rm "$GIT_REPO_DIR"hooks/phpcs/install.sh
cp "$SCRIPT_DIR"../fix-permissions.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x inc/*
chmod +x phpcs/*
chmod +x fix-permissions.sh


# Script need explicit exit with a code, and check here for reject
HOOK_CONTENT="\${0%/*}/phpcs/phpcs.sh
if [ 0 -ne \$? ]; then
    echo Commit is rejected by phpcs hook
    echo Notice: this hook only check staged status of file
    exit 1
fi"

installHook pre-commit "$HOOK_CONTENT" 1l5jm1tain17is4s


cd "$PWD_BAK"
