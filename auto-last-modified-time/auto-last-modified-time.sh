#! /usr/bin/env bash
#====================================================================
# Auto update last modified time when commit
#
# Although git keeps all version information, for some script who maybe used
# standalone out of project environment, a last modified time is useful to find
# which is newer.
#
#
# Usage: Write a start date like `Last Modified: 2017-08-17` in head lines of
# your code, the script will change it to full format, and update when hook run.
# Configs like time format pattern, allowed file types, are set in
# `update-last-modified-time.php'.
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-18T17:26:28+08:00, r26
#====================================================================


SCRIPT_DIR=${0%/*}/


EXIT_CODE=0


. "$SCRIPT_DIR"../inc/loop-cached-file.sh
loopChangeCachedFiles "$SCRIPT_DIR"update-last-modified-time.php


if [ 0 -eq ${EXIT_CODE} ]; then
    exit 0
else
    exit 1
fi
