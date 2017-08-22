#! /usr/bin/env bash
#====================================================================
# Auto update copyright year when commit
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-22T22:02:27+08:00, r33
#====================================================================


SCRIPT_DIR=${0%/*}/


EXIT_CODE=0


. "$SCRIPT_DIR"../inc/loop-cached-file.sh
loopChangeCachedFiles "$SCRIPT_DIR"update-copyright-year.php


if [ 0 -eq ${EXIT_CODE} ]; then
    exit 0
else
    exit 1
fi
