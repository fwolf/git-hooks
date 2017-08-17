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
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T12:44:49+08:00, r17
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
addPermissions "inc/*"

addPermissions post-commit
addPermissions post-merge
addPermissions pre-commit
