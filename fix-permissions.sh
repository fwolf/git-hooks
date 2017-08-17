#! /usr/bin/env bash
#====================================================================
# Fix permissions of hook file and relate scripts
#
# All script file in hook dir will be marked executable, so DO NOT leave useless
# file here.
#
# All install script should copy this script to hook dir.
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-17T12:21:39+08:00, r13
#====================================================================


SCRIPT_DIR=${0%/*}/


addPermissions() {
    FILES="$1"
    if ls ${FILES} > /dev/null 2>&1 ; then
        chmod +x ${FILES}
    fi
}


cd ${SCRIPT_DIR}

addPermissions "*.php"
addPermissions "*.sh"

addPermissions post-commit
addPermissions post-merge
addPermissions pre-commit
