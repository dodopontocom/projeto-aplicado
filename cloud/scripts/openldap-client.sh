#!/usr/bin/env bash

# Instalar e configurar o client openldap e o RDP (xrdp)

# export DEBIAN_FRONTEND=noninteractive
# MINIMAL_APT_GET_INSTALL='apt-get install -y --no-install-recommends'

apt-get update
apt-get install xrdp xfce4 -y
service xrdp restart

apt-get install ldap-client libpam-ldap libnss-ldap -y