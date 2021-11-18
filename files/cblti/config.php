<?php

// Application settings
define('APP_NAME', 'Coursebuilder LTI Tool');
define('SESSION_NAME', 'php-coursebuilder');
define('VERSION', '0.2.0');

// Setup paths
define('WEBDIR', '/lti');
define('WEBCONTENTDIR', '/lti/content');

define('INSTALLDIR', '/srv/www/lti');
define('CONTENTDIR', '/srv/www/lti/content');
define('UPLOADDIR', '/srv/www/lti/upload');
define('PROCESSDIR', '/opt/processing/');
define('PROCESSUSER', "cblti");

// Database connection settings
define('DB_NAME', 'mysql:dbname=cblti;host=mysql');
define('DB_USERNAME', 'cblti');
define('DB_PASSWORD', '{{ getv "/mysql/password" }}');
define('DB_TABLENAME_PREFIX', '');

?>
