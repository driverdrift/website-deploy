#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]; then
  echo "请使用 sudo 运行此脚本，或者以 root 用户身份运行。"
  exit 1
fi

set -e

apt update
apt install nginx -y
apt install mariadb-server -y
apt install php-fpm php php-mysqli php-json php-curl  -y
