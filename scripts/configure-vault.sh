#!/bin/bash

# Run this script using root Vault token

# Setup for both users
vault secrets enable ssh
vault auth enable github
vault write auth/github/config organization=insight-ab

# OTP users
echo "Configuring the ssh secrets engine for SSH OTP"
vault policy write qa-policy ./policies/qa.hcl
vault write ssh/roles/qa @./roles/qa.json

echo "Configuring the auth backend for SSH OTP"
vault write auth/github/map/teams/qa value=qa-policy

# CA users
echo "Configuring the ssh secrets engine for SSH CA"
vault write ssh/config/ca generate_signing_key=true
vault policy write dev-policy ./policies/dev.hcl
vault write ssh/roles/dev @./roles/dev.json

echo "Configuring the auth backend for SSH CA"
vault write auth/github/map/teams/dev value=dev-policy

echo "Enable auditing
vault audit enable file file_path=/tmp/vault_audit.log