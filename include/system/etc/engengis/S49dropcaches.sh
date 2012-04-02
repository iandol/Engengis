#!/system/bin/sh
# Copyright (c) 2012, redmaner
# Copyright (c) 2012, pikachu01 << it's his idea
L="log -p i -t ENGENGIS"
$L "S49dropcaches Script starting@ $(date)"
if [ -e /data/do_debug ]; then
     LOG=/data/debug.log
	 echo "========================================" >> $LOG
     echo "S49dropcaches Script starting @ $(date)" >> $LOG
     echo "Build: $(getprop ro.build.version.release)" >> $LOG
     echo "Mod: $(getprop ro.modversion)" >> $LOG
     echo "Kerne l: $(uname -r)" >> $LOG
     exec >> $LOG 2>&1
     #set -x
fi
# Drop caches
sync;
sleep 1;
free
echo "3" > /proc/sys/vm/drop_caches;
sleep 1;
echo "1" > /proc/sys/vm/drop_caches;
free

$L "S49dropcaches Script ending@ $(date)"