#!/system/bin/sh
# Copyright (c) 2012, Redmaner
L="log -p i -t ENGENGIS"
$L "S56 Script starting@ $(date)"
if [ -e /data/do_debug ]; then
     LOG=/data/debug.log
	 echo "========================================" >> $LOG
     echo "S56 Script starting @ $(date)" >> $LOG
     echo "Build: $(getprop ro.build.version.release)" >> $LOG
     echo "Mod: $(getprop ro.modversion)" >> $LOG
     echo "Kerne l: $(uname -r)" >> $LOG
     exec >> $LOG 2>&1
     #set -x
fi
# -------------------------------------------------------
# IPv4 tweaks
# -------------------------------------------------------
# Internet speed improvements
if [ -e /proc/sys/net/core/rmem_default ]; then
      echo "163840" > /proc/sys/net/core/rmem_default;
fi
if [ -e /proc/sys/net/core/rmem_max ]; then
      echo "204800" > /proc/sys/net/core/rmem_max;
fi
if [ -e /proc/sys/net/core/wmem_default ]; then
      echo "163840" > /proc/sys/net/core/wmem_default;
fi
if [ -e /proc/sys/net/core/wmem_max ]; then
      echo "204800" > /proc/sys/net/core/wmem_max;
fi
if [ -e /proc/sys/net/ipv4/tcp_abc ]; then
      echo "0" > /proc/sys/net/ipv4/tcp_abc
fi
if [ -e /proc/sys/net/ipv4/tcp_cookie_size ]; then
      echo "0" > /proc/sys/net/ipv4/tcp_cookie_size
fi; 
if [ -e /proc/sys/net/ipv4/tcp_fin_timeout ]; then
      echo "40" > /proc/sys/net/ipv4/tcp_fin_timeout;
fi
if [ -e /proc/sys/net/ipv4/tcp_keepalive_probes ]; then
      echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes;
fi
if [ -e /proc/sys/net/ipv4/tcp_keepalive_intvl ]; then
      echo "40" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
fi
if [ -e /proc/sys/net/ipv4/tcp_rmem ]; then
      echo "8192,87380,204800" > /proc/sys/net/ipv4/tcp_rmem;
fi
if [ -e /proc/sys/net/ipv4/tcp_timestamps ]; then
      echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
fi
if [ -e /proc/sys/net/ipv4/tcp_tw_recycle ]; then
      echo "0" > /proc/sys/net/ipv4/tcp_tw_recycle;
fi
if [ -e /proc/sys/net/ipv4/tcp_tw_reuse ]; then
      echo "0" > /proc/sys/net/ipv4/tcp_tw_reuse;
fi
if [ -e /proc/sys/net/ipv4/tcp_window_scaling ]; then
      echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
fi
if [ -e /proc/sys/net/ipv4/tcp_wmem ]; then
      echo "4096,16384,204800" > /proc/sys/net/ipv4/tcp_wmem;
fi
$L "S56 Script ending@ $(date)"