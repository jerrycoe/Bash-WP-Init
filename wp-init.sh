#!/bin/bash

#parse option
while getopts ":r:" option; do
	case ${option} in
		r) 
			remote=$OPTARG;;
		:) 
			echo "Invalid option";;
	esac
	shift $((OPTIND-1))
done

directory=$1
theme="https://github.com/jerrycoe/wp-base-theme.git"

#make new directory for clone
mkdir $directory
cd $directory

#clone boilerplate repo
git clone $theme .
git init

echo "Setting Remote"
echo $remote

#change remote url to user supplied repo
git remote set-url origin $remote

#add all files, commit and push
git add -A
git commit -m "Initial Commit"
git push origin master