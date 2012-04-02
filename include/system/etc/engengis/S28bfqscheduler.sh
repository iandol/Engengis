#!/system/bin/sh
# Copyright (c) 2012, redmaner
L="log -p i -t ENGENGIS"
$L "S28scheduler Script starting@ $(date)"
if [ -e /data/do_debug ]; then
	LOG=/data/debug.log
	echo "========================================" >> $LOG
	echo "S28scheduler Script starting @ $(date)" >> $LOG
	echo "Build: $(getprop ro.build.version.release)" >> $LOG
	echo "Mod: $(getprop ro.modversion)" >> $LOG
	echo "Kernel: $(uname -r)" >> $LOG
	exec >> $LOG 2>&1
	if [ $(grep "verbose" /data/do_debug | wc -l) -gt 0 ]
		set -x
	fi
fi

BML=`ls -d /sys/block/bml*`;
MMC=`ls -d /sys/block/mmc*`;
MTD=`ls -d /sys/block/mtd*`;
STL=`ls -d /sys/block/stl*`;
TFSR=`ls -d /sys/block/tfsr*`;
ZRAM=`ls -d /sys/block/zram*`;

# Scheduler = bfq
for i in $BML $MMC $MTD $STL $TFSR $ZRAM; do
	if [ -e $i/queue/scheduler ]; 	then
		echo "bfq" > $i/queue/scheduler
	fi
done
$L "S28scheduler Script ending@ $(date)"