# Bash-WP-Init

## What this does
1. Downloads latest stable release of Wordpress
2. Downloads boilerplate blank theme from my repo to themes directory
3. Initializes a new git repo for blank theme
4. Makes API call to Github to create new remote repo
5. Pushes theme to new repo
6. Creates new MySQL database
7. Creates new host in /etc/hosts
8. Creates new virtual host in /etc/apache2/extra/httpd-vhosts.conf
9. Restarts apache2
10. Opens new local website in browser
</br>
<p>This automates the process of creating a new local Wordpress Installation and theme git repo for development.</p>
<p>My first bash script.</p>

#### Notes
<p>
	<ul>
		<li>
			Apache Requires unixd_module to be set with proper user and group in httpd.conf, Requires Include /private/etc/apache2/extra/httpd-vhosts.conf to be uncommented
			</li>
		</li>
		<li>
			MySQL Requires valid credentials to create new databases
		</li>
		<li>
			Script is configured to set up a new website in current working directory. This can be modified by adding another prompt at the beginning of the script.
		</li>
		<li>
			 This script must be run under sudo for editing hosts and starting apache, as well as updating permissions.
		</li>
		<li>
			Wordpress will have to finish installation in web browser to create wp-config.php with auth keys and database connection credentials.
		</li>
		<li>
			If homebrew is not installed you will get an error when running brew commands (brew services stop|start mysql). This can be modified to accomodate another environment using other mysql cli command for restarting mysql.
		</li>
	</ul>

</p>

## Usage

<p>sudo wp-init.sh</p>
<p>Follow on screen promts</p>


## Dependencies

<ul>
	<li>Homebrew</li>
	<li>PHP CLI</li>
	<li>Apache2</li>
	<li>MySQL CLI</li>
	<li>Git CLI</li>
	<li>Git API OAuth Token</li>
</ul>
