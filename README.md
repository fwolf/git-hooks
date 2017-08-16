# Some Git Hooks



## Install, Update, Delete


### Install

Call `install.sh` in hook sub directory, eg:

```bash
some/git/repo/dir$ path/to/git-hooks/hook-sub-dir/install.sh
```

Each install script has a hash code in it, eg:

```bash
installHook post-commit $HOOK_CONTENT 1l0ebpnpj11s5j5p
```

The `1l0ebpnpj11s5j5p` is hash code, its used when update or delete hook, to
identify where to change in hook script.


### Update

Just run install script again.

Notice hook content may have multiple lines written to hook script, if user
changed hook content and number of lines changed, run `install.sh` again may
affect wrong number of rows in hook script. In this case, leave more empty lines
in hook script, or manual delete then install again.


### Delete

You need manual edit hook script(like `post-commit`),  find hook content by hash
code of the hook you want, and delete code rows.



## Hooks Intro


### autoLastModifiedTime

Update Last Modified Time in source code when submit.

Script `updateLastModifiedTime.php` can use manually.


### setObjectsWritable


Set all files in `.git` writable for current user.

Script `findReadonlyObjects.sh` can use manually to find readonly files in `.git`.



## License

Distribute under MIT License.
