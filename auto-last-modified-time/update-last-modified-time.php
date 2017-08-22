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
 * Last Modified: 2017-08-22T23:24:22+08:00, r40
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
$realFilePath = $argv[2];


require __DIR__ . '/../inc/checks.php';

checkFileExtension($destFile, $allowedExt);


// Replace line with sed, which should be faster
$cmd = <<<TAG
sed -i -e "1,{$scanLines}s/{$pattern}/{$replacement}/" "$destFile"
TAG;

// File size maybe same, so check md5 hash for content change
$fileMd5 = md5_file($destFile);

exec($cmd);

// Print output message
if ($fileMd5 != md5_file($destFile)) {
    echo "Auto update last modified time in: $realFilePath" . PHP_EOL;
}


// End script with error code
exit(0);
