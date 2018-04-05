#!/bin/bash
#Set variables
remote=$1
directory=$1
#JSON post data
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
#Git repos
theme="https://github.com/jerrycoe/wp-base-theme.git"
wp="https://github.com/WordPress/WordPress.git"
#Generated git repo
remote="https://github.com/jerrycoe/WP-Theme-${directory}"

#curl call Github API
curl -s -H 'Content-Type: application/json' -u OUATHTOKEN:x-oauth-basic -d "$generate_post_data" "https://api.github.com/user/repos"


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