#!/system/bin/sh
# Copyright (c) 2012, redmaner
# Governor tweaks
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
# Conservative governor
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpu1/cpufreq/conservative/up_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpufreq/conservative/up_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_treshold ]; then 
	echo "50" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_treshold ]; then 
	echo "50" > /sys/devices/system/cpu/cpu1/cpufreq/conservative/down_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_treshold ]; then 
	echo "50" > /sys/devices/system/cpu/cpufreq/conservative/down_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step ]; then 
	echo "70" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step ]; then 
	echo "70" > /sys/devices/system/cpu/cpu1/cpufreq/conservative/freq_step
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step ]; then 
	echo "70" > /sys/devices/system/cpu/cpufreq/conservative/freq_step
fi

# Ondemand
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_treshold
fi
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_treshold ]; then
	echo "85" > /sys/devices/system/cpu/cpufreq/ondemand/up_treshold
fi
#================================================
if [ -s /data/recoverlog ]; then
  $L "Script ran fine; recovery file: $self removed..."
  sed -i -e "/$self/d" /data/recoverlog #remove name from recoverlog
fi
$L "$self Script ending @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================