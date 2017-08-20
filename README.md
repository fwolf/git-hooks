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


### auto-last-modified-time

Update Last Modified Time in source code when submit.

Script `update-last-modified-time.php` can use manually.

Usage: Write a start date like `Last Modified: 2017-08-17` in head lines of your
code, the script will change it to full format, and update when hook run.
Configs like time format pattern, allowed file types, are set in
`update-last-modified-time.php'.


### phpcs


Call [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer) executable
to check commit file, prevent commit when fail.

User can customize config by create `config.php` under `phpcs/` dir, default
config is in head of `do-phpcs.php`, just declare variable with same name, will
overwrite default config. Don't forget `<?php` tag.



### set-objects-writable


Set all files in `.git` writable for current user.

Script `find-readonly-objects.sh` can use manually to find readonly files in
`.git`.



## License

Distribute under the MIT license.
