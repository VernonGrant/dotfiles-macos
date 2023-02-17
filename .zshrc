# Re-source the current file.
alias reload='. ~/.zshrc'

# Clear all notifications.
alias clear-notifications='killall NotificationCenter'

# Restore permissions to their defaults.
alias reset-permissions='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'

# Always use terminal Emacs.
alias emacs='emacs -nw'

########
# GIT #
########

alias git-set-origin-url='git remote set-url origin '

########
# TMUX #
########

# Attaches Tmux to a session (example: ta portal).
alias ta='tmux attach'

# Kill all sessions.
alias tka='tmux kill-server'

# Setup Tmux sessions.
alias ts="~/.scripts/tmux-setup-sessions.sh"

#########################
# Locate Customizations #
#########################

alias locate='glocate'

alias locate-update='gupdatedb --localpaths=/Users/vernon/Devenv/ --output=/Users/vernon/locate-database'

export LOCATE_PATH='/Users/vernon/locate-database'

###############################
# Media And File Manipulation #
###############################

# Convert this to a function instead.

# ==============================================================================
# Will resize all images inside a folder. Images that matches the given format
# will be overwritten.
#
# ARGUMENTS:
# - $1 | The format: jpg/png.
# - $2 | The maximum width in pixels.
#
# OUTPUTS: Resized images.
# RETURNS: void
function resize-image() {
    local -r format="${1}"
    local -r width="${2}"
    mogrify -format $format -quality 80 -resize $width -strip *
}

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
# Converts all markdown files inside a folder into PDF files using Pandoc.
#
# ARGUMENTS:
#
# OUTPUTS: Resized images.
# RETURNS: void
function markdown-to-pdf() {
    for i in *.md; do
        [ -f "$i" ] || break
        echo ${i%.*};
        pandoc --pdf-engine=xelatex -f markdown-implicit_figures -t pdf ./${i%.*}.md > ./${i%.*}.pdf
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
# - Facebook
# - YouTube
# - Instagram
# - Twitter
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
# - Facebook
# - YouTube
# - Instagram
# - Twitter
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

#########################
# Remote Server Helpers #
#########################

# ==============================================================================
# Pull files to a remote server.
#
# ARGUMENTS:
# - $1 | The host name.
# - $2 | The source path.
# - $3 | The destination path.
#
# OUTPUTS: void
function remote-pull-files() {
    rsync -auv $1:$2 $3
}

# ==============================================================================
# Upload files to a remote server.
#
# ARGUMENTS:
# - $1 | The host name.
# - $2 | The source path.
# - $3 | The destination path.
#
# OUTPUTS: void
function remote-push-files() {
    rsync -auv $2 $1:$3
}

# ==============================================================================
# Download a MYSQL database from remote server.
#
# ARGUMENTS:
# - $1 | The host name.
# - $2 | The MYSQL user name.
# - $3 | The MYSQL user password.
# - $4 | The MYSQL database name.
# - $5 | The local destination of the SQL file.
#
# OUTPUTS: void
function remote-pull-mysql-db() {
    # dump database on server.
    ssh $1 "mkdir -p ~/temp && mysqldump --user=\"$2\" --password=\"$3\" $4 > ~/temp/$4.sql && ls -la ~/temp/"

    # Rsync it down.
    rsync -auv $1:~/temp/$4.sql $5
}

#################################
# WordPress Development Helpers #
#################################

# ==============================================================================
# Uploads the provided SQL file into the MySQL container. Replaces the main
# database used for the WordPress projects development.
#
# ARGUMENTS:
# - $1 | The MySQL Docker container id.
# - $2 | Relative path to the database file.
#
# OUTPUTS: void
function wordpress-docker-upload-mysql-db() {
    # all local WordPress projects uses the following MySQL passwords.
    local loc_mysql_user="root"
    local loc_mysql_password="my-secret-pw"
    local loc_mysql_database="exampledb"

    # upload database to local running container.
    cat $2 | docker exec -i $1 /usr/bin/mysql --user="$loc_mysql_user" --password="$loc_mysql_password" $loc_mysql_database
}

# ==============================================================================
# Changes the URL of a WordPress docker instance, using the WordPress CLI.
#
# ARGUMENTS:
# - $1 | The WordPress Docker container id.
# - $2 | The current URL.
# - $3 | The replacement URL.
#
# OUTPUTS: void
function wordpress-docker-replace-url() {
    # install WordPress CLI.
    docker exec -i $1 sh -c "cd /var/www/html && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
    docker exec -i $1 sh -c "cd /var/www/html && chmod +x wp-cli.phar"
    docker exec -i $1 sh -c "cd /var/www/html && mv wp-cli.phar /usr/local/bin/wp"

    # replace the sites URL.
    docker exec -i $1 sh -c "cd /var/www/html && wp search-replace --all-tables '$2' '$3' --allow-root"
}

# ==============================================================================
# Installs development plugins and de-activates plugins that might cause
# production interferences.
#
# ARGUMENTS:
# - $1 | The WordPress Docker container id.
# - $2 | The current URL.
# - $3 | The replacement URL.
#
# OUTPUTS: void
# Corrects the permissions of a WordPress container.
# $1, container id.
function wordpress-docker-setup-dev-plugins() {
    # deactivate plugins that might cause production related issues.
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate autoptimize --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate wordfence --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate autoptimize --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate easy-wp-smtp --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate wp-mail-smtp --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate wpcf7-recaptcha --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate login-recaptcha --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin deactivate wps-hide-login --allow-root"

    # activate development plugins.
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin install disable-emails --activate --allow-root"
    docker exec -i $1 sh -c "cd /var/www/html && wp plugin install query-monitor --activate --allow-root"
}
