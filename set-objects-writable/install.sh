#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T17:01:23+08:00, r21
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"../inc/git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-functions.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp -r "$SCRIPT_DIR"../inc/ "$GIT_REPO_DIR"hooks/
cp -r "$SCRIPT_DIR"../set-objects-writable/ "$GIT_REPO_DIR"hooks/
rm "$GIT_REPO_DIR"hooks/set-objects-writable/install.sh
cp "$SCRIPT_DIR"../fix-permissions.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x inc/*
chmod +x set-objects-writable/*
chmod +x fix-permissions.sh


HOOK_CONTENT="\${0%/*}/set-objects-writable/set-objects-writable.sh"

installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
installHook post-merge $HOOK_CONTENT 1l0ebpnpj11s5j5p


cd "$PWD_BAK"
