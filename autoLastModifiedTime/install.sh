#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-16T02:30:52+08:00, r9
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../setObjectsWritable/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-operate.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp "$SCRIPT_DIR"updateLastModifiedTime.php "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"autoLastModifiedTime.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x updateLastModifiedTime.php \
    autoLastModifiedTime.sh


# Special call with 'source' and exit code check when commit maybe rejected
HOOK_CONTENT=". \${0%/*}/autoLastModifiedTime.sh
if [ 0 -ne \${EXIT_CODE} ]; then
    echo Commit rejected by autoLastModifiedTime hook
    exit 1
fi"

installHook pre-commit "$HOOK_CONTENT" 1l0pmscuzl1szqu7


cd "$PWD_BAK"
