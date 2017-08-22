#! /usr/bin/env php
<?php
/**
 * @copyright   Copyright 2017 Fwolf <fwolf.aide+git-hooks@gmail.com>
 * @license     https://opensource.org/licenses/MIT MIT
 *
 * Last Modified: 2017-08-22T23:24:22+08:00, r40
 */


// Config
$copyrightUpdaterBinPath = '/usr/local/bin/copyright-year-updater';
$allowedExt = [
    "md",
    "php",
    "rst",
    "sh",
    "txt",
];
$otherOptions = '';

// Load user config
$userConfigFile = __DIR__ . '/config.php';
if (file_exists($userConfigFile) && is_readable($userConfigFile)) {
    /** @noinspection PhpIncludeInspection */
    require $userConfigFile;
}


$destFile = $argv[1];
$realFilePath = $argv[2];


require __DIR__ . '/../inc/checks.php';

checkPathExecutable($copyrightUpdaterBinPath);
checkFileExtension($destFile, $allowedExt);


// Do change
$output = [];
$returnStatus = 0;
$cmd = <<<TAG
$copyrightUpdaterBinPath $otherOptions "$destFile"
TAG;

$fileSize = filesize($destFile);

exec($cmd, $output, $returnStatus);


// Print output message
if (0 != $returnStatus) {
    echo implode(PHP_EOL, $output);
    echo PHP_EOL;
} else {
    clearstatcache();
    if ($fileSize != filesize($destFile)) {
        echo "Auto update copyright year in: $realFilePath" . PHP_EOL;
    }
}


// End script with error code
exit($returnStatus);
