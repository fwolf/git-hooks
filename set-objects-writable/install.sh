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


HOOK_NAME="set-objects-writable"
copyHookScripts "$HOOK_NAME"


HOOK_CONTENT="\${0%/*}/${HOOK_NAME}/${HOOK_NAME}.sh"

installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
installHook post-merge $HOOK_CONTENT 1l0ebpnpj11s5j5p


cd "$PWD_BAK"
