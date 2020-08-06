#!/usr/bin/env bash

# Instalar e configurar o client openldap e o RDP (xrdp)

#export DEBIAN_FRONTEND=noninteractive
# MINIMAL_APT_GET_INSTALL='apt-get install -y --no-install-recommends'

apt-get update
apt-get install xrdp xfce4 -y
service xrdp restart

apt-get install ldap-client -y

# apt-get install libpam-ldap libnss-ldap -y

# cat << _EOF > /etc/nsswitch.conf
# passwd:         compat systemd ldap
# group:          compat systemd ldap
# shadow:         compat ldap
# gshadow:        files

# hosts:          files dns
# networks:       files

# protocols:      db files
# services:       db files
# ethers:         db files
# rpc:            db files

# netgroup:       nis
# _EOF

# cat << _EOF > /etc/pam.d/common-session

# # here are the per-package modules (the "Primary" block)
# session [default=1]                     pam_permit.so
# # here's the fallback if no module succeeds
# session requisite                       pam_deny.so
# # prime the stack with a positive return value if there isn't one already;
# # this avoids us returning an error just because nothing sets a success code
# # since the modules above will each just jump around
# session required                        pam_permit.so
# # The pam_umask module will set the umask according to the system default in
# # /etc/login.defs and user settings, solving the problem of different
# # umask settings with different shells, display managers, remote sessions etc.
# # See "man pam_umask".
# session optional                        pam_umask.so
# # and here are more per-package modules (the "Additional" block)
# session required        pam_unix.so 
# session optional        pam_systemd.so 
# session optional        pam_ldap.so
# session required        pam_mkhomedir.so skel=/etc/skel umask=077
# # end of pam-auth-update config
# _EOF

# cat << _EOF > /etc/ldap.conf
# base dc=paigti,dc=com
# uri ldap://10.10.0.2
# ldap_version 3
# rootbinddn cn=ldapadmin,dc=paigti,dc=com
# pam_password md5
# _EOF