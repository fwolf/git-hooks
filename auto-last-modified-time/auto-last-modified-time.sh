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
# Last Modified: 2017-08-18T16:40:33+08:00, r24
#====================================================================


SCRIPT_DIR=${0%/*}/


EXIT_CODE=0

for FILE in `git diff-index --cached --name-only HEAD`
do
    # Pipe create sub shell so exit code can't write back
    # Possible solution is to use "Process Substitution"
    # @see https://stackoverflow.com/a/124349/1759745
    # git ls-files --stage "$FILE" | while read MODE OBJECT STAGE FILE_PATH; do
    #
    # Here we use bash array
    # @see https://stackoverflow.com/a/9294015/1759745
    ARR=( `git ls-files --stage "$FILE"` )
    MODE=${ARR[0]}
    OBJECT=${ARR[1]}
    STAGE=${ARR[2]}
    FILE_PATH=${ARR[3]}

    if [[ "10" == "${MODE:0:2}" ]]; then
        # Deal with this file, copy staged status out
        STAGED_FILE=$(mktemp)
        git show "$OBJECT" > "$STAGED_FILE"

        # Do change
        # Target file need current ext name for filter by update script
        CHANGED_FILE_BASENAME=`basename "$FILE_PATH"`
        CHANGED_FILE_EXT=`sed 's/^\w\+.//' <<< "${CHANGED_FILE_BASENAME}"`
        CHANGED_FILE=$(mktemp).${CHANGED_FILE_EXT}
        cp "$STAGED_FILE" "$CHANGED_FILE"
        "$SCRIPT_DIR"update-last-modified-time.php "$CHANGED_FILE"

        # Catch error code
        let EXIT_CODE+=$?

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


if [ 0 -eq ${EXIT_CODE} ]; then
    exit 0
else
    exit 1
fi
