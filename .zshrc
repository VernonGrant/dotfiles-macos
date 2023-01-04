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
