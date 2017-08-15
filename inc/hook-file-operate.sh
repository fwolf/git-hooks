#! /usr/bin/env bash
#====================================================================
# Functions to operate hook file
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


# Create an empty hook file
function createHookFile() {
    local HOOK_NAME="$1"

    echo "#! /usr/bin/env bash" >> "$HOOK_NAME"
    echo "" >> "$HOOK_NAME"
}


# Check if git command is available
# MUST be called in hooks directory.
# Hash is to identify hook content, for removal them when next install
function installHook() {
    local HOOK_NAME="$1"
    local HOOK_CONTENT="$2"
    local HASH="$3"

    if [ ! -f "$HOOK_NAME" ]; then
        createHookFile "$HOOK_NAME"
    fi

    # Clear previous installed hook
    # @see https://stackoverflow.com/a/4398433/1759745
    # @see https://unix.stackexchange.com/a/152316/53225
    local LINES=`echo "$HOOK_CONTENT" | wc -l`
    let LINES-=1 # Minus current line
    let LINES+=2 # Plus a hash comment line and an empty line
    sed -i -e "/$HASH/, +${LINES}d" "$HOOK_NAME"

    local NOW=`date +"%Y-%m-%d %H:%M:%S"`
    echo "# Installed at $NOW, hash: $HASH" >> "$HOOK_NAME"
    echo "$HOOK_CONTENT" >> "$HOOK_NAME"
    echo "" >> "$HOOK_NAME"

    chmod +x "$HOOK_NAME"
}
