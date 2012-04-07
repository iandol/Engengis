#!/system/bin/sh
# Copyright (c) 2012, redmaner
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

BML=`ls -d /sys/block/bml*`;
MMC=`ls -d /sys/block/mmc*`;
STL=`ls -d /sys/block/stl*`;

# Scheduler = VR
for i in $BML $MMC $STL; do
	if [ -e $i/queue/scheduler ]; 	then
		echo "vr" > $i/queue/scheduler; 
	fi
done
unset i BML MMC STL
#================================================
if [ -s /data/recoverlog ]; then
  $L "Script ran fine; recovery file: $self removed..."
  sed -i -e "/$self/d" /data/recoverlog #remove name from recoverlog
fi
$L "$self Script ending @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================