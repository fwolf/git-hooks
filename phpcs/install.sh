#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-22T22:55:55+08:00, r39
#====================================================================


SCRIPT_DIR=${0%/*}/
PWD_BAK="$PWD"


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


HOOK_NAME="phpcs"
copyHookScripts "$HOOK_NAME"


# Script need explicit exit with a code, and check here for reject
HOOK_CONTENT="\${0%/*}/${HOOK_NAME}/${HOOK_NAME}.sh
if [ 0 -ne \$? ]; then
    echo Commit is rejected by ${HOOK_NAME} hook
    echo Notice: this hook only check staged status of file
    exit 1
fi"

installHook pre-commit "$HOOK_CONTENT" 1l5jm1tain17is4s


cd "$PWD_BAK"
