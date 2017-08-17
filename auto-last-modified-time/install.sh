#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T16:50:33+08:00, r20
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp -r "$SCRIPT_DIR"../inc/ "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"../fix-permissions.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"update-last-modified-time.php "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"auto-last-modified-time.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x fix-permissions.sh \
    update-last-modified-time.php \
    auto-last-modified-time.sh
chmod +x inc/*


# Special call with 'source' and exit code check when commit maybe rejected
HOOK_CONTENT=". \${0%/*}/auto-last-modified-time.sh
if [ 0 -ne \${EXIT_CODE} ]; then
    echo Commit rejected by auto-last-modified-time hook
    exit 1
fi"

installHook pre-commit "$HOOK_CONTENT" 1l0pmscuzl1szqu7


cd "$PWD_BAK"
