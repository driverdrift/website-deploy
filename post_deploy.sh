post_deploy(){
}

_remind_dns_resolution() {
	real_ip="192.168.1.1"
	DOMAIN="www.example.com"
	
	echo
	echo "Reminder: To open PowerShell, press Win + X and select 'Terminal'. All commands mentioned below should be run in PowerShell."
	# echo "$(printf '-%.0s' {1..80})"
	# In some Bash or BusyBox environments, a format starting with '-' in printf may be misinterpreted as an option.
	echo "$(printf '%s' "$(printf -- '-%.0s' {1..80})")"
	echo "Copy the following command and press Enter to add a DNS record at the bottom of the hosts file:"
	echo
	# Output a PowerShell command to add DNS, so the user can copy it
	cat <<EOF
\$add_dns = '$real_ip $DOMAIN'
Start-Process powershell -Verb RunAs -ArgumentList @(
	"-NoProfile",
	"-ExecutionPolicy Bypass",
	"-Command",
	"\`\$add_dns='\$add_dns'; if ((Get-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Raw).EndsWith('\`r\`n')) { Add-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Value \`\$add_dns } else { Add-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Value ('\`r\`n' + \`\$add_dns) };
	ipconfig /flushdns"
)

EOF
	echo "$(printf '=%.0s' {1..80})"
	# For debugging, end with this below. Do not put a semicolon at the last command.
	# ipconfig /flushdns;
	# Read-Host 'Press Enter to exit'"
	
	echo "However, DNS resolution happens from top to bottom. If an old entry is above the one you just added, your new record might not work, causing issues. If you need to remove or edit the newly added entry, you can copy the following command to manually view and edit the file:"
	echo
	echo 'Start-Process notepad.exe -ArgumentList "C:\Windows\System32\drivers\etc\hosts" -Verb RunAs'
	echo "$(printf '=%.0s' {1..80})"
	
	echo "You can also run the following command to check which DNS the domain currently points to:"
	echo
	echo "ping $DOMAIN"
	echo "$(printf '=%.0s' {1..80})"
	
	echo "Tip: If you added a DNS record in the Cloudflare dashboard, it may take some time to propagate. You can manually change your DNS to 1.1.1.1 or 8.8.8.8, then run the following command to refresh the DNS cache:"
	echo
	echo 'ipconfig /flushdns'
	echo "$(printf '=%.0s' {1..80})"
	echo
}

_remind_wp_init_protection() {
	DOMAIN="www.example.com"
	echo
	echo "$(printf '%s' "$(printf -- '-%.0s' {1..80})")"

	# Inform the user that deployment is complete and WordPress init page is locked
	echo "1. Deployment complete! For security, the WordPress initialization page has been locked."
	echo "   Please run the following command to set your admin username and password:"
	echo
	# Show the command for creating Nginx access credentials
	echo 'read -p "Enter the Nginx access username you want to create: " u; htpasswd -c /etc/nginx/auth/wp_init.pass "$u"'
	echo "$(printf '=%.0s' {1..80})"

	# Instructions after setting credentials
	echo "2. After setting up password, refresh the website page >>>>>> https://${DOMAIN} <<<<<< on a desktop web browser to continue WordPress installation."
	echo "   Do not use a mobile browser, as it may fail to load the login page."
	echo
	echo "$(printf '%s' "$(printf -- '-%.0s' {1..80})")"
	
	# Instructions for restoring site visibility after initialization
	echo "3. After wordpress initialization, you should run the following commands to restore site visibility by removing the protection files: "
	echo
	echo 'rm -rf "/etc/nginx/auth" && \
rm -f "/etc/nginx/conf.d/should_delete_after_wordpress_initialization.conf" && \
nginx -t &>/dev/null && systemctl reload nginx &>/dev/null || systemctl restart nginx &>/dev/null
[[ $? -eq 0 ]] && echo "Success: Your website is now visible." || echo -e "Error: Service failed to restart. The reason is: \n$(nginx -t 2>&1)"'
	echo "$(printf '=%.0s' {1..80})"
	echo
	# echo -e "Error: Service failed to restart. The reason is: \n" $(nginx -t 2>&1)
	# nginx output goes to stderr; without `2>&1`, it will appear before the prompt text
	# echo -e $(nginx -t 2>&1)
	# Without quotes: the shell performs word splitting on the command substitution result.
	# All whitespace characters (spaces, newlines, tabs) are treated as separators,
	# so newlines are converted into spaces.
	# As a result, everything is printed on a single line.
	# The `-e` option only interprets literal escape sequences like `\n`;
	# it does not restore newlines that were removed by the shell.
	# Therefore, the quoted form below is required.
	# echo -e "$(nginx -t 2>&1)"
}
