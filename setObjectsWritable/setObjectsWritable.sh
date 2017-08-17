#! /usr/bin/env bash
#====================================================================
# Set git object files writable so can sync with nutstore
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# Distributed under the MIT license.
#
# Last Modified: 2017-08-17T16:31:19+08:00, r19
#====================================================================


SCRIPT_DIR=${0%/*}/


"$SCRIPT_DIR"findReadonlyObjects.sh | xargs -I '{}' chmod u+w '{}'
