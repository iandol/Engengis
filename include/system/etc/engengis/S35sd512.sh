#!/system/bin/sh
# Copyright (c) 2012, brainmaster
# Copyright (c) 2012, redmaner
# Copyright (c) 2012, Others who found more read_ahead_kb locations
L="log -p i -t ENGENGIS"
$L "S35sdtweak Script starting@ $(date)"
if [ -e /data/do_debug ]; then
	LOG=/data/debug.log
	echo "========================================" >> $LOG
	echo "S35sdtweak Script starting @ $(date)" >> $LOG
	echo "Build: $(getprop ro.build.version.release)" >> $LOG
	echo "Mod: $(getprop ro.modversion)" >> $LOG
	echo "Kernel: $(uname -r)" >> $LOG
	exec >> $LOG 2>&1
	if [ $(grep "verbose" /data/do_debug | wc -l) -gt 0 ]
		set -x
	fi
fi
# SD-Readspeed = 512kb
if [ -e /sys/devices/virtual/bdi/0:18/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/0:18/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/179:0/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/179:0/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/179:8/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/179:8/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:16/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/179:16/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:28/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/179:28/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:33/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/179:33/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/7:0/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:0/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:1/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:1/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:2/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:2/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:3/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:3/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:4/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:4/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:5/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:5/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:6/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:6/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:7/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/7:7/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/default/read_ahead_kb ]; then
	echo "512" > /sys/devices/virtual/bdi/default/read_ahead_kb;
fi
$L "S35sdtweak Script ending@ $(date)"