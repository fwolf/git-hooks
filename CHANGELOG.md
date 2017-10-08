# Changelog of Git Hooks



### v0.2.4 (2017-10-08)

- Allow '// comment' format when detect last modified time


### v0.2.3 (2017-08-31)

- Check file change by md5 instead of file size


### v0.2.2 (2017-08-25)

- Fix git repo path error when call from git submodule


### v0.2.1 (2017-08-23)

- Optimize performance of readonly files search and chmod


## v0.2 (2017-08-22)

- Update README about customize configuration
- Optimize pre checks in php scripts
- Optimize script copy in install.sh
- New hook auto-copyright-year
- New hook phpcs
- Move loop of cached files to function
- Optimize read of staged file in pre-commit
- Move scripts to their own sub directory
- Change filename from camelCase to with dashes


## v0.1 (2017-08-17)

- New script fix-permission.sh to help set hook and script permission
- New hook script autoLastModifiedTime.sh
- New hook script setObjectsWritable.sh to help sync with nutstore
