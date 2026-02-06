#!/usr/bin/env bash

set -euo pipefail
trap 'rm -rf /tmp/website-deploy' EXIT
trap 'echo "operation is interrupted"; exit 130' INT

source ./set_domain_storage_path.sh
read DOMAIN DIR < <(set_domain_storage_path)

source ./install_packages.sh
install_packages "$DIR"

source ./edit_configuration.sh
edit_configuration "$DOMAIN" "$DIR"

echo "Install website successfully."
