#!/bin/bash
#Set variables
read -p "Name: " remote
read -p "New Database Name: " dbName
read -sp "MySQL password: " password
directory=$remote
nicename=$(echo "${remote}" | tr '[:upper:]' '[:lower:]')
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
cd ..
cd ..
cd ..
curdir=$(pwd)
MYSQL_PWD="$password" mysql -u root -e "CREATE DATABASE $dbName;"

#/etc/hosts
cp /etc/hosts /etc/hosts.original
echo -e "127.0.0.1\t${directory}.loc" >> /etc/hosts

#httpd-vhosts.conf
VHOSTSFILE="/etc/apache2/extra/httpd-vhosts.conf"
cp $VHOSTSFILE ${VHOSTSFILE}.original
echo "<VirtualHost *:80>" >> $VHOSTSFILE
echo -e "\tDocumentRoot \"${curdir}\"" >> $VHOSTSFILE
echo -e "\tServerName ${directory}.loc" >> $VHOSTSFILE
echo -e "\tServerAlias www.${directory}.loc" >> $VHOSTSFILE
echo -e "\t<Directory \"${curdir}\">" >> $VHOSTSFILE
echo -e "\t\tDirectoryIndex index.html index.php" >> $VHOSTSFILE
echo -e "\t\tOptions +Includes +Indexes +FollowSymLinks" >> $VHOSTSFILE
echo -e "\t\tAllow from all" >> $VHOSTSFILE
echo -e "\t\tRequire all granted" >> $VHOSTSFILE
echo -e "\t\tAllowOverride all" >> $VHOSTSFILE
echo -e "\t</Directory>" >> $VHOSTSFILE
echo '</VirtualHost>' >> $VHOSTSFILE
#allow writing to wp-config.php
sudo chown -R jerrycoe:admin "${curdir}"
#restart apache
sudo apachectl restart
#open project in web browser to complete wordpress install
open http://"${directory}".loc