# Check and display the status of common web services
for service in apache2 nginx php8.2-fpm mariadb; do
  echo "===== $service status ====="
  sudo systemctl status $service --no-pager
  echo
done
