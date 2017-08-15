#! /usr/bin/env bash
#====================================================================
# Set git object files writable so can sync with nutstore
#
# Gist: https://gist.github.com/fwolf/085b647532a3bde27de9aee9622212a2
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


SCRIPT_DIR=${0%/*}/


"$SCRIPT_DIR"findReadonlyObjects.sh | xargs -I '{}' chmod u+w '{}'
