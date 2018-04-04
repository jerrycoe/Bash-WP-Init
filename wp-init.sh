#!/bin/bash

directory=$1
theme="https://github.com/jerrycoe/wp-base-theme.git"

while getopts r: option
do
case "${option}"
in
r) remote=${OPTARG};;
esac
done

mkdir $DIRECTORY

git clone $theme
 
git init
git add .
git commit -m "Initial Commit"

if [ -o remote ]; then
	git remote add origin $remote
	git push $remote master
fi
