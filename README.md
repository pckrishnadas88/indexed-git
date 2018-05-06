# indexed-git - Add files to git using it's index ie not with it's filename.

## ut stands for untracked files.
##  nt stands for notstaged tracked files.
##st stands for staged files.

### Sample output
```
$ ./git-bash.sh 
On Branch - * master
Untracked files:
ut0 - git-bash.sh
ut1 - git-status.txt
ut2 - test

$ ./git-bash.sh add ut 2
On Branch - * master
Changes to be committed:
st0 - test
Untracked files:
ut0 - git-bash.sh
ut1 - git-status.txt
```
