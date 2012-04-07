#!/system/bin/sh
# Copyright (c) 2012, brainmaster
# Copyright (c) 2012, redmaner
# Copyright (c) 2012, Others who found more read_ahead_kb locations
#================================================
L="log -p i -t ENGENGIS"
self=$(basename $(readlink -nf $0))
if [ -e /data/debugon ]; then
  LOG=/data/debug.log
  echo "========================================" >> $LOG
  echo "$self Script starting @ $(date "+%d/%m/%Y %H:%M:%S")" >> $LOG
  echo "Build: $(getprop ro.build.version.release)" >> $LOG
  echo "Mod: $(getprop ro.modversion)" >> $LOG
  echo "Kernel: $(uname -r)" >> $LOG
  exec >> $LOG 2>&1
  if [ $(grep "verbose" /data/debugon | wc -l) -gt 0 ]; then
    set -x
  fi
fi
if [ -s /data/recoverlog ]; then
  #we test if recoverlog has same name as this script
  if [ $(grep $self /data/recoverlog | wc -l) -gt 0 ]; then
    $L "Script errored out last time --- STOPPING SCRIPT!"
    sync
    sleep 1
    exit
  else
    $L "Script was OK last boot, append $self to log..."
    echo $self >> /data/recoverlog
  fi
else
  echo $self > /data/recoverlog
  $L "$self bootloop Recovery file created..."
fi
$L "$self Script starting @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================

# SD-Readspeed = 2048kb
if [ -e /sys/devices/virtual/bdi/0:18/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/0:18/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/179:0/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/179:0/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/179:8/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/179:8/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:16/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/179:16/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:28/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/179:28/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:33/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/179:33/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/7:0/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:0/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:1/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:1/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:2/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:2/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:3/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:3/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:4/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:4/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:5/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:5/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:6/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:6/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/7:7/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/7:7/read_ahead_kb
fi

if [ -e /sys/devices/virtual/bdi/default/read_ahead_kb ]; then
	echo "2048" > /sys/devices/virtual/bdi/default/read_ahead_kb;
fi
#================================================
if [ -s /data/recoverlog ]; then
  $L "Script ran fine; recovery file: $self removed..."
  sed -i -e "/$self/d" /data/recoverlog #remove name from recoverlog
fi
$L "$self Script ending @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================