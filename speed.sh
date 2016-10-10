#!/bin/bash
# Change the network speed with ease.

read -p '(T)hrottle or (U)n-throttle? ' state

if [ $state == "t" ]; then
   read -p "Max transfer speed? " speed
   read -p "Interface to throttle, (1)wlp3s0 or (2)enp2s0? " interface
	if [ $interface == '1' ]; then
		NET='wlp3s0'
	elif [ $interface == '2' ]; then
		NET='enp2s0'
	fi
   tc qdisc add dev $NET handle 1: root htb default 11
   tc class add dev $NET parent 1: classid 1:1 htb rate "$speed"kbps
   tc class add dev $NET parent 1:1 classid 1:11 htb rate "$speed"kbps
   echo Speed throttled to $speed kbps on $NET interface.
   exit 1

elif [ $state == "u" ]; then
   tc qdisc del dev wlp3s0 root
   tc qdisc del dev enp2s0 root
   exit 1
   fi
fi
