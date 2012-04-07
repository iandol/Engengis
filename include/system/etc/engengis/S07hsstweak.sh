#!/system/bin/sh
# Copyright (C) 2012, redmaner
# The HSS (High Speed System) project
# Thanks to linux kernel 2.6.37.6 source documentation
# Engengis project
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
#MTD=`ls -d /sys/block/mtd*`;
#TFSR=`ls -d /sys/block/tfsr*`;
#ZRAM=`ls -d /sys/block/zram*`;

# Remount all partitions with noatime
for k in $(busybox mount | grep relatime | cut -d " " -f3)
do
	sync
	busybox mount -o remount,noatime $k
done

# LMK (LowMemoryKiller) and OOM (Out of Memory) tweaks
if [ -e /sys/module/lowmemorykiller/parameters/adj ]; then
	echo "0,1,2,4,6,15" > /sys/module/lowmemorykiller/parameters/adj;
fi
if [ -e /sys/module/lowmemorykiller/parameters/minfree ]; then
	echo "2048,3072,4096,7168,8192,10240" > /sys/module/lowmemorykiller/parameters/minfree;
fi

# Kernel tweaks
if [ -e /proc/sys/kernel/panic ]; then
	echo "0" > /proc/sys/kernel/panic
fi
if [ -e /proc/sys/kernel/panic_on_oops ]; then
	echo "0" > /proc/sys/kernel/panic_on_oops
fi

# VM (Virtual Memory) tweaks
if [ -e /proc/sys/vm/dirty_ratio ]; then
	echo "10" > /proc/sys/vm/dirty_ratio
fi
if [ -e /proc/sys/vm/dirty_background_ratio ]; then
	echo "6" > /proc/sys/vm/dirty_background_ratio
fi
if [ -e /proc/sys/vm/dirty_expire_centisecs ]; then
	echo "500" > /proc/sys/vm/dirty_expire_centisecs
fi
if [ -e /proc/sys/vm/dirty_writeback_centisecs ]; then
	echo "1000" > /proc/sys/vm/dirty_writeback_centisecs
fi
if [ -e /proc/sys/vm/laptop_mode ]; then
	echo "0" > /proc/sys/vm/laptop_mode
fi
if [ -e /proc/sys/vm/min_free_kbytes ]; then
	echo "4096" > /proc/sys/vm/min_free_kbytes
fi
if [ -e /proc/sys/vm/oom_kill_allocating_task ]; then
	echo "0" > /proc/sys/vm/oom_kill_allocating_task
fi
if [ -e /proc/sys/vm/overcommit_memory ]; then
	echo "0" > /proc/sys/vm/overcommit_memory
fi
if [ -e /proc/sys/vm/page-cluster ]; then
	echo "3" > /proc/sys/vm/page-cluster
fi
if [ -e /proc/sys/vm/panic_on_oom ]; then
	echo "0" > /proc/sys/vm/panic_on_oom
fi
if [ -e /proc/sys/vm/swappiness ]; then
	echo "0" > /proc/sys/vm/swappiness
fi
if [ -e /proc/sys/vm/vfs_cache_pressure ]; then
	echo "25" > /proc/sys/vm/vfs_cache_pressure
fi

# CFS scheduler tweaks
if [ -e /proc/sys/kernel/sched_latency_ns ]; then
	echo "3000000" > /proc/sys/kernel/sched_latency_ns
fi
if [ -e /proc/sys/kernel/sched_min_granularity_ns ]; then
	echo "600000" > /proc/sys/kernel/sched_min_granularity_ns
fi
if [ -e /proc/sys/kernel/sched_wakeup_granularity_ns ]; then
	echo "400000" > /proc/sys/kernel/sched_wakeup_granularity_ns
fi

# CFS scheduler features
mount -t debugfs none /sys/kernel/debug
echo NO_NEW_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
echo NO_NORMALIZED_SLEEPERS > /sys/kernel/debug/sched_features
umount /sys/kernel/debug

# IO scheduler settings
for i in $BML $MMC $STL;  do
	if [ -e $i/queue/rotational ];  then
		echo "0" > $i/queue/rotational
	fi
	if [ -e $i/queue/nr_requests ];  then
		echo "1024" > $i/queue/nr_requests  
	fi
	if [ -e $i/queue/iosched/back_seek_penalty ];  then 
		echo "1" > $i/queue/iosched/back_seek_penalty
	fi
	if [ -e $i/queue/iosched/low_latency ];  then
		echo "1" > $i/queue/iosched/low_latency
	fi
	if [ -e $i/queue/iosched/slice_idle ];  then 
		echo "0" > $i/queue/iosched/slice_idle
	fi
	if [ -e $i/queue/iosched/quantum ];  then
		echo "8" > $i/queue/iosched/quantum
	fi
	if [ -e $i/queue/iostats ];  then
		echo "0" > $i/queue/iostats 
	fi
	if [ -e $i/queue/iosched/fifo_batch ];  then
		echo "1" > $i/queue/iosched/fifo_batch
	fi
	if [ -e $i/queue/iosched/writes_starved ];  then
		echo "1" > $i/queue/iosched/writes_starved
	fi
	if [ -e $i/queue/iosched/quantum ];  then
		echo "8" > $i/queue/iosched/quantum
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