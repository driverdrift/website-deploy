edit_configuration() {
	_edit_php_configuration
}


_edit_php_configuration() {
	PHP_VER=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
	PHP_INI="/etc/php/$PHP_VER/fpm/php.ini"

	awk '
	BEGIN {
		u = p = e = c = 0
	}
	
	{
		if ($0 ~ /^[[:space:]]*upload_max_filesize[[:space:]]*=/) {
			print "upload_max_filesize = 2000M"
			u = 1
			next
		}
		if ($0 ~ /^[[:space:]]*post_max_size[[:space:]]*=/) {
			print "post_max_size = 2006M"
			p = 1
			next
		}
		if ($0 ~ /^[[:space:]]*max_execution_time[[:space:]]*=/) {
			print "max_execution_time = 3000"
			e = 1
			next
		}
		if ($0 ~ /^[[:space:]]*;?[[:space:]]*cgi\.fix_pathinfo[[:space:]]*=/) {
			print "cgi.fix_pathinfo=0"
			c = 1
			next
		}
		print
	}
	
	END {
		if (!(u && p && e && c)) exit 1
	}
	' "$PHP_INI" > "$PHP_INI.tmp" && mv "$PHP_INI.tmp" "$PHP_INI" || {
		echo "ERROR: $PHP_INI does not match the expected template; at least one required setting was not found." >&2
		rm "$PHP_INI.tmp" >&2
		exit 1
	}
}
