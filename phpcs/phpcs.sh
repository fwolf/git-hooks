#! /usr/bin/env bash
#====================================================================
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-20T10:52:12+08:00, r29
#====================================================================


SCRIPT_DIR=${0%/*}/


EXIT_CODE=0


. "$SCRIPT_DIR"../inc/loop-cached-file.sh
loopCheckCachedFiles "$SCRIPT_DIR"do-phpcs.php


if [ 0 -eq ${EXIT_CODE} ]; then
    exit 0
else
    exit 1
fi
