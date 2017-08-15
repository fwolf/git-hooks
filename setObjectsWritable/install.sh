#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


SCRIPT_DIR=${0%/*}/


. "$SCRIPT_DIR"git-functions.sh
. "$SCRIPT_DIR"../inc/hook-file-operate.sh


checkGitRoot
findGitRepositoryDir "$GIT_ROOT"


cp "$SCRIPT_DIR"git-functions.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"findReadonlyObjects.sh "$GIT_REPO_DIR"hooks/
cp "$SCRIPT_DIR"setObjectsWritable.sh "$GIT_REPO_DIR"hooks/

PWD_BAK="$PWD"
cd "$GIT_REPO_DIR"hooks/
chmod +x git-functions.sh \
    findReadonlyObjects.sh \
    setObjectsWritable.sh


HOOK_CONTENT="\${0%/*}/setObjectsWritable.sh"

installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
installHook post-merge $HOOK_CONTENT 1l0ebpnpj11s5j5p


cd "$PWD_BAK"
ls -l --color=auto "$GIT_REPO_DIR"hooks/
