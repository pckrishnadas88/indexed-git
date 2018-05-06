#!/bin/bash
# Script Name: git-bash.sh
#
# Author: Krishnadas P.C<pckrishnadas88@gmail.com>
# Date : 05-05-2018
#
# Description: A simple script to manipulate git files.
# TODO add more options and add Error Handlers. 

#decalre color variables
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

if [ $# -ge 3 ];
then
   if [ $2 == "st" ];
   then
       git $1 ${gitstaged[$3]}
   elif [ $2 == "nt" ]; 
   then  
   	git $1 ${gitnotstaged[$3]}
   elif [ $2 == "ut" ]; 
   then  
   	git $1 ${gituntracked[$3]}
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
