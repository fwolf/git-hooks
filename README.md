# Some Git Hooks



## Install

Call `install.sh` in hook sub directory, eg:

    some/git/repo/dir$ path/to/git-hooks/hook-sub-dir/install.sh



## Hooks Intro


### autoLastModifiedTime

Update Last Modified Time in source code when submit.

Script `updateLastModifiedTime.php` can use manually.


### setObjectsWritable


Set all files in `.git` writable for current user.

Script `findReadonlyObjects.sh` can use manually to find readonly files in `.git`.



## License

Distribute under MIT License.
