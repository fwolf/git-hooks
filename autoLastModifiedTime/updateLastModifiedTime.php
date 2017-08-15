#! /usr/bin/env php
<?php
/**
 * Update last modified time by pattern
 *
 * Implement with PHP due to bash lack of array operate.
 *
 *
 * @copyright   Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
 * @license     https://opensource.org/licenses/MIT MIT
 *
 * Last Modified: 2017-08-16T02:30:52+08:00, r9
 */


// Config
// A little strange for compatible with sed regex
$pattern = "^\([#* ]\{2,\}\)Last Modified: [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" .
    "\(T[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}+[0-9]\{2\}:[0-9]\{2\}\)\?" .
    "\(, r[0-9]\+\)\?";
$replacement = "\\1Last Modified: " .
    date('c') .
    ", r`git rev-list HEAD | wc -l | tr -d '[:space:]'`";
$scanLines = 50;
$allowedExt = [
    "md",
    "php",
    "rst",
    "sh",
    "txt",
];


$destFile = $argv[1];


// Check file type
$pathParts = pathinfo($destFile);
if (isset($pathParts['extension'])) {
    $ext = $pathParts['extension'];
} else {
    $ext = "";
}

if (!in_array($ext, $allowedExt)) {
    return;
}


// Replace line with sed, which should be faster
$cmd = <<<TAG
sed -i -e "1,{$scanLines}s/{$pattern}/{$replacement}/" "$destFile"
TAG;

exec($cmd);
