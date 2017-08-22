<?php
/**
 * @copyright   Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
 * @license     https://opensource.org/licenses/MIT MIT
 *
 * Last Modified: 2017-08-22T23:24:22+08:00, r40
 */


/**
 * Check if given path is executable, exit when fail
 *
 * @SuppressWarnings(PHPMD.ExitExpression)
 *
 * @param string $path
 */
function checkPathExecutable($path)
{
    if (!is_executable($path)) {
        echo "Bin path '{$path}' is not executable'" . PHP_EOL;
        exit(1);
    }
}


/**
 * Check if given file's extension in range
 *
 * @SuppressWarnings(PHPMD.ExitExpression)
 *
 * @param string $destFile
 * @param array  $allowedExt
 */
function checkFileExtension($destFile, array $allowedExt)
{
    $pathParts = pathinfo($destFile);
    if (isset($pathParts['extension'])) {
        $ext = $pathParts['extension'];
    } else {
        $ext = "";
    }

    if (!in_array($ext, $allowedExt)) {
        exit(0);
    }
}
