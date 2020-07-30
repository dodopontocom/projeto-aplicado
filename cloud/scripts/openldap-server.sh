#!/usr/bin/env bash

# Instalar e configurar o servidor openldap

yum update -y
yum install openldap openldap-clients openldap-servers -y
systemctl enable slapd
systemctl start slapd