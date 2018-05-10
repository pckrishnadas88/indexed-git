# indexed-git - Add/Remove files to git using it's file index ie not with it's filename.

## ut stands for untracked files.
## nt stands for notstaged tracked files.
## st stands for staged files.


#### After a command has been executed it shows the updated status.

1. To Simply view the status execute the command without any args.
```
  $ ./igit.sh 
  Untracked files
  ut0 - igit.sh
  ut1 - git-status.txt
  ut2 - test
  ```
2. To add an untracked file(ut) run like this where 0 is the index from the previous command.
```
  $./igit.sh add ut 0
  Staged files
  st0 - igit.sh
  st1 - git-status.txt
  Untracked files
  ut0 - test
  ```
3. To add multiple files using comma seperated method
```
   $./igit.sh add ut 1,2,3  #Here 1, 2, 3 are the index of the files.
```
4. To add multiple files using a range like 1..10 adds 10 files.
```
  $./igit.sh add ut 1..10
```
5. To view the help text simply pass the help as the arguement
```
$./igit.sh help
```