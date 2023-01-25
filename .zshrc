# Re-source the current file.
alias reload='. ~/.zshrc'

# Clear all notifications.
alias clear-notifications='killall NotificationCenter'

# Restore permissions to their defaults.
alias reset-permissions='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'

###############################
# Media And File Manipulation #
###############################

# ==============================================================================
# Appends a random number to the end of each file matching the given file
# extension.
#
# ARGUMENTS:
# - $1 | The stand-alone file extension. (pdf, jpg, png, ...)
#
# OUTPUTS: void
# RETURNS: void
function files-append-random-number() {
    local -r extension="${1}"

    for i in *.$extension; do
        [ -f "$i" ] || break
        echo ${i%.*};
        local new_name=${i%.*}-$RANDOM
        mv $i ./$new_name.$extension
    done
}

# ==============================================================================
# Converts a PDF file to JPG images.
#
# ARGUMENTS:
# - $1 | The name of the PDF file.
#
# REQUIRES:
# - brew install poppler
#
# OUTPUTS: void
# RETURNS: void
function pdf-to-jpg() {
    pdftoppm -jpeg -rx 200 -ry 200 $1 page
}

##############################
# Block Social Media Helpers #
##############################

# ==============================================================================
# Unblocks currently blocked social media websites. Must be used under sudo.
#
# - facebook
# - youtube
# - instagram
# - twitter
# OUTPUTS: The updated hosts file.
#
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
function generate-php-mysql-dump-script() {
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
