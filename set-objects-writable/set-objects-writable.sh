#! /usr/bin/env bash
#====================================================================
# Set git object files writable so can sync with nutstore
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T16:50:33+08:00, r20
#====================================================================


SCRIPT_DIR=${0%/*}/


"$SCRIPT_DIR"find-readonly-objects.sh | xargs -I '{}' chmod u+w '{}'
