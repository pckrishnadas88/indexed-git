#!/bin/bash
# Script Name: igit.sh
#
# Author: Krishnadas P.C<pckrishnadas88@gmail.com>
# Date : 05-05-2018
#
# Description: A simple script to manipulate git files.
# TODO add more options and add Error Handlers. 

#declare color variables
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#print the current git branch
echo "On Branch - $(git branch)"
#Get only staged files
gitstaged=($(git diff --name-only --cached))

#Get changes not staged for commit
gitnotstaged=($(git diff --name-only))
 
#Get only untracked files
gituntracked=($(git ls-files --others --exclude-standard))

#print the clean message if all three arrays are empty.
cleanmsg="nothing to commit, working directory clean"
if [ ${#gitstaged[@]} == 0 ] && [ ${#gitnotstaged[@]} == 0 ] && [ ${#gituntracked[@]} == 0 ];
  then
  echo $cleanmsg
fi

if [ $# -ge 3 ];
then
   #process comma seperated multiple files ie git add 1,2,3
   fileindex=""
   multifile="false"
   #check whether string contains a ,
   if [[ $3 == *[,]* ]]
   then
     #set multi file to true
     multifile="true"
     a=(`echo $3 | sed 's/,/\n/g'`)
     for i in ${!a[@]}; do # Loop and build the multi file string.
      if [ $2 == "st" ]; #staged files section.
         then
         fileindex+="${gitstaged[$i]} " #use the appropriate git array.
      elif [ $2 == "nt" ]; 
         then
         fileindex+="${gitstaged[$i]} "
      elif [ $2 == "ut" ]; 
         then
         fileindex+="${gituntracked[$i]} "
      else 
         echo "Invalid input provided"
         exit
      fi
     done
   fi
   #multi file adding with lower upper limits ie 1..10
   if [[ $3 == *[..]* ]]
   then
     #set multi file to true
     multifile="true"
     IFS='.. ' read -r -a multiarray <<< "$3"
     lowerlimit=multiarray[0]
     upperlimit=multiarray[2]
     for ((a=$lowerlimit; a <= $upperlimit ; a++))
      do
         if [ $2 == "st" ]; #staged files section.
         then
         fileindex+="${gitstaged[$a]} " #use the appropriate git array.
         elif [ $2 == "nt" ]; 
            then
            fileindex+="${gitstaged[$a]} "
         elif [ $2 == "ut" ]; 
            then
            fileindex+="${gituntracked[$a]} "
         else 
            echo "Invalid input provided"
            exit
         fi
      done
      echo $fileindex
      echo ${gituntracked}
      #exit
      #exit
   fi
   #staged files section.
   if [ $2 == "st" ]; 
   then
      if [ $multifile == "true" ];
      then
        git $1 $fileindex
      else 
       git $1 ${gitstaged[$3]}
      fi
   elif [ $2 == "nt" ]; # not staged but tracked files section.
   then 
      if [ $multifile == "true" ];
      then
        git $1 $fileindex
      else 
       git $1 ${gitnotstaged[$3]}
      fi 
   elif [ $2 == "ut" ]; 
   then 
      if [ $multifile == "true" ];
      then
        git $1 $fileindex
      else 
       git $1 ${gituntracked[$3]}
      fi 
   else
   	 echo "Invalid input provied."
   fi     
fi
#Get the new status after the command has been executed.
gitstaged=($(git diff --name-only --cached))

#Get changes not staged for commit
gitnotstaged=($(git diff --name-only))
 
#Get only untracked files
gituntracked=($(git ls-files --others --exclude-standard))
#print the staged files.
for i in ${!gitstaged[@]}; do
   if [ $i -eq 0 ]; then 
	   echo "Changes to be committed:" 
   fi
    echo "${green}st$i - ${gitstaged[$i]}${reset}"
done
#print the changes not staged files.
for i in ${!gitnotstaged[@]}; do
   if [ $i -eq 0 ]; then 
	echo "Changes not staged for commit:" 
   fi
   echo "${red}nt$i - ${gitnotstaged[$i]}${reset}"
done
#print the untracked files.
for i in ${!gituntracked[@]}; do
   if [ $i -eq 0 ]; then 
	echo "Untracked files:" 
   fi
  echo "${red}ut$i - ${gituntracked[$i]}${reset}"
done

: 'Example how to:
#$ ./git-bash.sh 
Untracked files
ut0 - git-bash.sh
ut1 - git-status.txt
ut2 - test
$./git-bash.sh add ut 0
Staged files
st0 - git-bash.sh
st1 - git-status.txt
Untracked files
ut0 - test
ut stands for untracked files.
nt stands for notstaged tracked files.
st stands for staged files.
'