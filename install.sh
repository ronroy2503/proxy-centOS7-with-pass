#!/bin/bash

yum install -y squid httpd-tools
chkconfig squid on
# Copy config from github
curl -o /etc/squid/squid.conf https://raw.githubusercontent.com/akkradet/proxy-centOS7/master/squid.conf
# Add user
htpasswd -bc /etc/squid/.htpasswd admin $PROXY_PASS
systemctl start squid
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3128 -j ACCEPT
iptables -F
systemctl status squid
