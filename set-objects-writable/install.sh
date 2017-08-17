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
cp "$SCRIPT_DIR"find-readonly-objects.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"set-objects-writable.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x fix-permissions.sh \
    find-readonly-objects.sh \
    set-objects-writable.sh
chmod +x inc/*


HOOK_CONTENT="\${0%/*}/set-objects-writable.sh"

installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
installHook post-merge $HOOK_CONTENT 1l0ebpnpj11s5j5p


cd "$PWD_BAK"
