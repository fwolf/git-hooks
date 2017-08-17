#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-17T12:36:16+08:00, r16
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp -r "$SCRIPT_DIR"../inc/ "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"../fix-permissions.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"findReadonlyObjects.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"setObjectsWritable.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x fix-permissions.sh \
    findReadonlyObjects.sh \
    setObjectsWritable.sh
chmod +x inc/*


HOOK_CONTENT="\${0%/*}/setObjectsWritable.sh"

installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
installHook post-merge $HOOK_CONTENT 1l0ebpnpj11s5j5p


cd "$PWD_BAK"
