# Fast Path Checker
Double-check a long path and find errors faster.

## Demo
```
user@host:~$ fpc /srv/users/shared/brain_masks/mnimask_thresh_clean.nii.gz
path exists up to '/srv/users/shared/brain_masks'
==========| 'mnimask_thresh_clean.nii.gz' does not exist
user@host:~$ fpc /srv/users/shared/brain_masks/mnimask_thresh_clean.nii
user@host:~$
```
In this case, `/srv/users/shared/brain_masks/mnimask_thresh_clean.nii` actually exists.

## usage
Designed to take one argument, the path to be checked. Returns 1 if an error is found, and outputs report. If no error is found, return value is 0.

Designed to be sourced in your bashrc, or copied in. Goodies are in 'ppc' file.

# Path Permissions Checker
Checks for permissions. Like fpc, but takes a first argument -r,-w, or -x, and checks the file for this permission, in addition to existence.
sample usage:

```
user@host:~$ ppc -r /srv/users/shared/brain_masks/mnimask_thresh_clean.nii.gz
```
