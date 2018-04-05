#!/bin/bash

remote=$1
directory=$1
generate_post_data=$(cat <<-END
{
    "name": "WP-Theme-${remote}",
    "description": "${remote} WordPress Theme",
    "homepage": "https://github.com/jerrycoe/",
    "private": false,
    "has_issues": true,
    "has_projects": true,
    "has_wiki": true
}
END
)
curl -s -H 'Content-Type: application/json' -u 8be6390855b847a87138b6630455c9b027402596:x-oauth-basic -d "$generate_post_data" "https://api.github.com/user/repos"
theme="https://github.com/jerrycoe/wp-base-theme.git"
wp="https://github.com/WordPress/WordPress.git"
remote="https://github.com/jerrycoe/WP-Theme-${directory}"

#make new directory for clone
mkdir $directory
cd $directory

echo "Cloning Wordpress latest stable release"
echo $wp
git clone $wp .
#clone boilerplate repo
cd "wp-content/themes/"
mkdir "$directory-theme"
cd "$directory-theme"
git clone $theme .

#change remote url to user supplied repo
git remote set-url origin "${remote}"

#add all files, commit and push
git add -A
git commit -m "Initial Commit"
git push origin master