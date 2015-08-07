#!/bin/bash

clear

# Prompt for and receive a site name.
echo "Enter sitename:"
read sitename

# Check to see if there's already a site with this name.
while [ -d "/var/www/$sitename" ]; do
	echo "Nope! Already exists. Please try again."
	echo "Enter sitename:"
	read sitename
done

echo "Okay - creating the site $sitename."

# Create appropriate directories.
mkdir -p /var/www/$sitename/public_html/

# Get the user and group to own the directory.
echo "Enter user to own the directory:"
read user
echo "Great! Enter the group that user is in:"
read group

# Set the permissions.
chmod -R 755 /var/www/$sitename
chown -R $user:$group /var/www/$sitename
echo "Created directory /var/www/$sitename and set the owner to $user."

# Set up a new conf file.
cp /etc/apache2/sites-available/base.conf /etc/apache2/sites-available/$sitename.conf
echo "Created site conf file."

# Replace all instances of $SITE in the conf file with $sitename.
sed -i "s/SITENAME/$sitename/g" /etc/apache2/sites-available/$sitename.conf
echo "Set conf to $sitename."

# Prompt to create a database.
echo "Create database? [y/n]"
read createdb

# If yes, create a database.
if [ $createdb == 'y' ]; then
	echo "Okay - what should it be called?"
	read dbname

	while [ -d "/var/lib/mysql/$dbname" ]; do
		echo "Nope! Already exists. Please try again."
		echo "Enter database name:"
		read dbname
	done

	mysql -uroot -ppassword -e "create database $dbname"
	echo "Created database $dbname. Don't forget to add users to it, etc."
else
	echo "Okay, no worries. Moving swiftly on."
fi

# Add an entry to the hosts file.
cat <<EOF >> /etc/hosts

# $sitename
127.0.0.1	$sitename
EOF

# Enable the site.
a2ensite $sitename
service apache2 restart
echo "Site enabled!"

# All done.
echo "All done! Try going to $sitename in your browser."


