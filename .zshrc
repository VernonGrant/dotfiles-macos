# Re-source the current file.
alias reload='. ~/.zshrc'

# Clear all notifications.
alias clear-notifications='killall NotificationCenter'

# ==============================================================================
# Unblocks currently blocked social media websites. Must be used under sudo.
#
# - facebook
# - youtube
# - instagram
# - twitter
#
# OUTPUTS: The updated hosts file.
# RETURNS: void
function social() {
    sudo cat /etc/hosts > ~/.hosts_old
    sudo awk '!/facebook|youtube|instagram|twitter/' /etc/hosts > ~/.hosts_new
    sudo mv ~/.hosts_new /etc/hosts

    sudo cat /etc/hosts
}

# ==============================================================================
# Blocks the current list of social media websites. Must be used under sudo.
#
# - facebook
# - youtube
# - instagram
# - twitter
#
# OUTPUTS: The updated hosts file.
# RETURNS: void
function unsocial() {
    sudo social

    sudo cat /etc/hosts > ~/.hosts_old && cat ~/.hosts_old > ~/.hosts_new
    sudo echo '0.0.0.0 youtube.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 www.youtube.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 facebook.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 www.facebook.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 instagram.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 www.instagram.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 twitter.com' >> ~/.hosts_new
    sudo echo '0.0.0.0 www.twitter.com' >> ~/.hosts_new
    sudo mv ~/.hosts_new /etc/hosts
    sudo chown root:wheel /etc/hosts

    sudo cat /etc/hosts
}

####################
# Helper Functions #
####################

# ==============================================================================
# Generates a php script to dump a mysql database via curl.
#
# ARGUMENTS:
# - $1 | The database host name.
# - $2 | The database name.
# - $3 | The database username.
# - $4 | The database user password.
#
# OUTPUTS: Creates a .temp folder in the current path containing the database
# dump script.
function generate_php_mysql_dump_script() {
    # create temp php dump script.
    local php_file_path="./.temp/tmp_db_dump.php"

    mkdir -p "./.temp"

    touch $php_file_path

    echo "<?php" > $php_file_path
    echo "\$dbhost = '$1';" >> $php_file_path
    echo "\$dbname = '$2';" >> $php_file_path
    echo "\$dbuser = '$3';" >> $php_file_path
    echo "\$dbpass = '$4';" >> $php_file_path
    echo "exec(\"mysqldump --user=\$dbuser --password='\$dbpass' --host=\$dbhost \$dbname > ./database.sql\");" >> $php_file_path
}
