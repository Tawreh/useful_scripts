# useful_scripts
Useful bash scripts I've written to make my life easier.

These will probably work best if you copy them into your home directory, but you should be able to run them from anywhere.

Pull requests and improvements are always accepted!

## backup.sh
Go through all databases you have on your local machine and dump them into a dated SQL file.

There are some variables you'll need to modify in order for it to work:
* Username and password to login to MySQL
* Backup path (where you want the backups to be saved)

Personally I have this script set up to run once a day on cron! I have daily backups that are kept for a week.

## makesite.sh
Create a new LAMP stack. You'll be prompted to provide a site name, the owner/group of the site directory, and optionally you can create a database to go with it.

Run this as root/sudo. If you don't supply a username/group when creating the site, it'll create the site as belonging to root.

You'll also need the base.conf file, which will need to be moved to /etc/apache2/sites-available - this provides a basic conf file with a little more info in it than the 000-default.conf file that Apache supplies.
