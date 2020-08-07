#!/usr/bin/env bash

# Instalar e configurar o client openldap e o RDP (xrdp)
export DEBIAN_FRONTEND=noninteractive
# MINIMAL_APT_GET_INSTALL='apt-get install -y --no-install-recommends'

#Script para montar o ssd na pasta home
#==============================================================================
mount_point="/home-ldap"
#ssd_by_id="google-${TF_VAR_ssd_name}"
ssd_by_id="google-ssd-disk-home"

[[ ! -d ${mount_point} ]] && sudo mkdir ${mount_point}
sudo mount /dev/disk/by-id/${ssd_by_id} ${mount_point}
if [[ $? -ne 0 ]]; then
  sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/${ssd_by_id}
  echo UUID=$(sudo blkid -s UUID -o value /dev/disk/by-id/${ssd_by_id}) ${mount_point} ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
  sudo mount ${mount_point}
else
  echo UUID=$(sudo blkid -s UUID -o value /dev/disk/by-id/${ssd_by_id}) ${mount_point} ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
  sudo mount ${mount_point}
fi
#==============================================================================

apt-get update
apt-get install xrdp xfce4 -y

apt-get install ldap-client -y
apt-get install libpam-ldap libnss-ldap -y
apt-get install chromium-browser -y

cat << _EOF > /etc/nsswitch.conf
passwd:         compat systemd ldap
group:          compat systemd ldap
shadow:         compat ldap
gshadow:        files

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
_EOF

cat << _EOF > /etc/pam.d/common-session

# here are the per-package modules (the "Primary" block)
session [default=1]                     pam_permit.so
# here's the fallback if no module succeeds
session requisite                       pam_deny.so
# prime the stack with a positive return value if there isn't one already;
# this avoids us returning an error just because nothing sets a success code
# since the modules above will each just jump around
session required                        pam_permit.so
# The pam_umask module will set the umask according to the system default in
# /etc/login.defs and user settings, solving the problem of different
# umask settings with different shells, display managers, remote sessions etc.
# See "man pam_umask".
session optional                        pam_umask.so
# and here are more per-package modules (the "Additional" block)
session required        pam_unix.so 
session optional        pam_systemd.so 
session optional        pam_ldap.so
session required        pam_mkhomedir.so skel=/etc/skel umask=077
# end of pam-auth-update config
_EOF

cat << _EOF > /etc/ldap.conf
base dc=paigti,dc=com
uri ldap://10.10.0.3
ldap_version 3
rootbinddn cn=ldapadmin,dc=paigti,dc=com
pam_password md5
_EOF

service xrdp restart