#! /usr/bin/env bash
#====================================================================
# Auto update last modified time when commit
#
# Although git keeps all version information, for some script who maybe used
# standalone out of project environment, a last modified time is useful to find
# which is newer.
#
#
# Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
#
# Distributed under the MIT License.
# https://opensource.org/licenses/MIT
#
# Last Modified: 2017-08-15
#====================================================================


SCRIPT_DIR=${0%/*}/


for FILE in `git diff-index --cached --name-only HEAD`
do
    git ls-files --stage "$FILE" | while read MODE OBJECT STAGE FILE_PATH; do
        if [[ "10" == "${MODE:0:2}" ]]; then
            # Deal with this file, copy staged status out
            STAGED_FILE=$(mktemp)
            git show "$OBJECT" > "$STAGED_FILE"

            # Do change
            CHANGED_FILE=$(mktemp)
            cp "$STAGED_FILE" "$CHANGED_FILE"
            "$SCRIPT_DIR"updateLastModifiedTime.php "$CHANGED_FILE"

            # Write new file blob to object database
            CHANGED_HASH=`git hash-object -w "$CHANGED_FILE"`

            # Register new written file to working tree index
            git update-index --cacheinfo ${MODE} ${CHANGED_HASH} "$FILE_PATH"

            # Patch file in workspace, make it seems changed too
            diff "$STAGED_FILE" "$CHANGED_FILE" | patch "$FILE_PATH"

            rm "$STAGED_FILE"
            rm "$CHANGED_FILE"
        fi
    done
done

EXIT_CODE=0
