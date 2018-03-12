#!/bin/bash

dhclient ma1
ADDRESS=$(ifconfig ma1|grep inet|awk -F " " '{print $2}')
NETMASK=$(ifconfig ma1|grep inet|awk -F " " '{print $4}')
DEFAULT_GW=$(ip route|grep default|awk -F " " '{print $3}')
FastCli -p 15 -c $a"
configure terminal
interface Management1
ip address $ADDRESS $NETMASK
ip route 0.0.0.0 0.0.0.0 $DEFAULT_GW
"
