#!/usr/bin/env bash

# Instalar e configurar o servidor openldap

export LDAP_ADMIN_PASS=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/LDAP_ADMIN_PASS)

yum update -y
yum install openldap openldap-clients openldap-servers -y
systemctl enable slapd
systemctl start slapd

pasta_temp="$(mktemp -d)"
#/etc/openldap
#/usr/share/openldap-servers

cat << _EOF > ${pasta_temp}/db.ldif
dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=paigti,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=ldapadmin,dc=paigti,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {SSHA}rdAxyhqCsXVLNZY0N2Isq6Ml9Izt6Kh4
_EOF

#
ldapmodify -H ldapi:/// -f ${pasta_temp}/db.ldif

cat << _EOF > ${pasta_temp}/monitor.ldif
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=ldapadmin,dc=paigti,dc=com" read by * none
_EOF

ldapmodify -H ldapi:/// -f ${pasta_temp}/monitor.ldif

cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap:ldap /var/lib/ldap/DB_CONFIG

ldapadd -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
ldapadd -H ldapi:/// -f /etc/openldap/schema/nis.ldif

cat << _EOF > ${pasta_temp}/base.ldif
dn: dc=paigti,dc=com
dc: paigti
objectClass: top
objectClass: domain

dn: cn=ldapadmin, dc=paigti,dc=com
objectClass: organizationalRole
cn: ldapadmin
description: LDAP Manager

dn: c=BR,dc=paigti,dc=com
objectClass: country
c: BR

dn: ou=TI,c=BR,dc=paigti,dc=com
objectClass: organizationalUnit
ou: TI
_EOF

cat << _EOF > ${pasta_temp}/users.ldif

dn: uid=ana,ou=TI,c=BR,dc=paigti,dc=com
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: ana
uid: ana
uidNumber: 9999
gidNumber: 100
homeDirectory: /home/ana
loginShell: /bin/bash
gecos: Ana [LDAP]
userPassword: {crypt}x
_EOF

ldapadd -x -w ${LDAP_ADMIN_PASS} -D "cn=ldapadmin,dc=paigti,dc=com" -f ${pasta_temp}/base.ldif
ldapadd -x -w ${LDAP_ADMIN_PASS} -D "cn=ldapadmin,dc=paigti,dc=com" -f ${pasta_temp}/users.ldif
#ldappasswd -S -w ${LDAP_ADMIN_PASS} -D "cn=ldapadmin,dc=paigti,dc=com" -x "uid=ana,ou=TI,c=BR,dc=paigti,dc=com"
