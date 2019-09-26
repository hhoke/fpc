# Fast Path Checker
Double-check a long path and find errors faster.

## Demo
```
user@host:~$ fpc /srv/users/shared/brain_masks/mnimask_thresh_clean.nii.gz
path exists up to '/srv/users/shared/brain_masks'
==========| 'mnimask_thresh_clean.nii.gz' does not exist
user@host:~$ fpc /srv/users/shared/brain_masks/mnimask_thresh_clean.nii.gz --parseable
/srv/users/shared/brain_masks
user@host:~$ fpc /srv/users/shared/brain_masks/mnimask_thresh_clean.nii
user@host:~$
```
In this case, `/srv/users/shared/brain_masks/mnimask_thresh_clean.nii` actually exists.

## usage
Designed to take one argument, the path to be checked. Returns 66 if a file or directory is not found, or 77 if there is a permissions error, and outputs report to stdout. If no error is found, return value is 0.

With the --parseable option, simply dumps the last reachable path to stdout.

Designed for 'ppc' file to be sourced in your bashrc, or copied in.

# Path Permissions Checker
Checks for permissions. Like fpc, but takes a first argument -r,-w, or -x, and checks the file for this permission, in addition to existence.
sample usage:

```
user@host:~$ ppc -r /srv/users/shared/brain_masks/mnimask_thresh_clean.nii.gz
```

## Similar tools

Some existing tools you can use for directory checking that are very robust and useful, but behave differently:

### namei
Absolutely fantastic for symlinks or debugging complex permissions issues. It lists directories vertically from bottom to top instead of as a chunk like fpc, but maybe that's what you're looking for! Also uses error code 1 for all errors, instead of 66 (file/dir not found) and 77(permissions error) like fpc.
