#!/bin/bash
# User Data script used to setup the target OTP host. This could also be done
# using a configuration management tool such as Chef, Ansible, etc.

echo "Update packages and install vault-ssh-helper"
apt-get update
apt-get install -y unzip

mkdir -p /etc/vault-ssh-helper.d
mkdir -p /usr/local/bin
cd /usr/local/bin
wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip -O tmp.zip && unzip tmp.zip && rm tmp.zip

echo "Create vault-ssh-helper configuration"
cat << EOF > /etc/vault-ssh-helper.d/config.hcl
vault_addr = "https://vault.insight-ab.net"
ssh_mount_point = "ssh"
ca_cert = "/etc/vault-ssh-helper.d/ca_public_key.pem"
tls_skip_verify = false
allowed_roles = "qa"
allowed_cidr_list="0.0.0.0/0"
EOF

echo "Update PAM sshd configuration"
sed -i -e 's/@include common-auth/#@include common-auth/' -e '/#@include common-auth/ a\
auth    [success=2 default=ignore]      pam_exec.so quiet expose_authtok log=/tmp/vaultssh.log /usr/local/bin/vault-ssh-helper -config=/etc/vault-ssh-helper.d/config.hcl\
auth    [success=1 default=ignore]      pam_unix.so nullok_secure\
auth    requisite                       pam_deny.so\
auth    required                        pam_permit.so' /etc/pam.d/sshd

echo "Update sshd configuration"
sed -i -e '/ChallengeResponseAuthentication/ s/no/yes/' -e '/UsePAM/ s/no/yes/' /etc/ssh/sshd_config

service sshd stop
service sshd start