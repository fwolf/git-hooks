#! /usr/bin/env php
<?php
/**
 * @copyright   Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
 * @license     https://opensource.org/licenses/MIT MIT
 *
 * Last Modified: 2017-08-20T10:52:12+08:00, r29
 */


// Config
$phpcsPath = '/usr/local/bin/phpcs';
$allowedExt = [
    'php',
];
$codingStandard = 'psr2';
// Other options used by phpcs
$otherOptions = '';


$destFile = $argv[1];
$realFilePath = $argv[2];


// Check file type
$pathParts = pathinfo($destFile);
if (isset($pathParts['extension'])) {
    $ext = $pathParts['extension'];
} else {
    $ext = "";
}

if (!in_array($ext, $allowedExt)) {
    exit(0);
}


// Do check
$output = [];
$returnStatus = 0;
$cmd = <<<TAG
$phpcsPath --standard={$codingStandard} $otherOptions "$destFile"
TAG;

exec($cmd, $output, $returnStatus);


// Print error message
if (0 != $returnStatus) {
    // Replace 'FILE:' line with actual file path
    array_shift($output);
    array_shift($output);
    array_unshift($output, "FILE: $realFilePath");

    // Remove tailing 'Time: ... Memory: ...' line
    array_pop($output);
    array_pop($output);
    echo implode(PHP_EOL, $output);
    echo PHP_EOL;
}


// End script with error code
exit($returnStatus);
