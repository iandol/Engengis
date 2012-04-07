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
# -------------------------------------------------------
# IPv6 security tweaks
# -------------------------------------------------------
# ping/icmp protection
if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts ]; then
      echo "1" >  /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts;
fi
if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_all ]; then
      echo "1" >  /proc/sys/net/ipv6/icmp_echo_ignore_all;
fi
if [ -e /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses ]; then
      echo "1" >  /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses;
fi

# syn protection
if [ -e /proc/sys/net/ipv6/tcp_synack_retries ]; then
      echo "3" > /proc/sys/net/ipv6/tcp_synack_retries;
fi
if [ -e /proc/sys/net/ipv6/tcp_syncookies ]; then
      echo "0" >  /proc/sys/net/ipv6/tcp_syncookies;
fi

#drop spoof, redirects, etc
if [ -e /proc/sys/net/ipv6/conf/all/rp_filter ]; then
      echo "1" > /proc/sys/net/ipv6/conf/all/rp_filter;
fi
if [ -e /proc/sys/net/ipv6/conf/default/rp_filter ]; then
      echo "1" > /proc/sys/net/ipv6/conf/default/rp_filter;
fi
if [ -e /proc/sys/net/ipv6/conf/all/send_redirects ]; then
      echo "0" > /proc/sys/net/ipv6/conf/all/send_redirects;
fi
if [ -e /proc/sys/net/ipv6/conf/default/send_redirects ]; then
      echo "0" > /proc/sys/net/ipv6/conf/default/send_redirects;
fi
if [ -e /proc/sys/net/ipv6/conf/default/accept_redirects ]; then
      echo "0" > /proc/sys/net/ipv6/conf/default/accept_redirects;
fi
if [ -e /proc/sys/net/ipv6/conf/all/accept_source_route ]; then
      echo "0" > /proc/sys/net/ipv6/conf/all/accept_source_route;
fi
if [ -e /proc/sys/net/ipv6/conf/default/accept_source_route ]; then
      echo "0" > /proc/sys/net/ipv6/conf/default/accept_source_route;
fi

# -------------------------------------------------------
# IPv4 security tweaks
# -------------------------------------------------------
# syn protection
if [ -e /proc/sys/net/ipv4/tcp_synack_retries ]; then
      echo "3" > /proc/sys/net/ipv4/tcp_synack_retries;
fi
if [ -e /proc/sys/net/ipv4/tcp_syncookies ]; then
      echo "0" >  /proc/sys/net/ipv4/tcp_syncookies;
fi

#drop spoof, redirects, etc
if [ -e /proc/sys/net/ipv4/conf/all/rp_filter ]; then
      echo "1" > /proc/sys/net/ipv4/conf/all/rp_filter;
fi
if [ -e /proc/sys/net/ipv4/conf/default/rp_filter ]; then
      echo "1" > /proc/sys/net/ipv4/conf/default/rp_filter;
fi
if [ -e /proc/sys/net/ipv4/conf/all/send_redirects ]; then
      echo "0" > /proc/sys/net/ipv4/conf/all/send_redirects;
fi
if [ -e /proc/sys/net/ipv4/conf/default/send_redirects ]; then
      echo "0" > /proc/sys/net/ipv4/conf/default/send_redirects;
fi
if [ -e /proc/sys/net/ipv4/conf/default/accept_redirects ]; then
      echo "0" > /proc/sys/net/ipv4/conf/default/accept_redirects;
fi
if [ -e /proc/sys/net/ipv4/conf/all/accept_source_route ]; then
      echo "0" > /proc/sys/net/ipv4/conf/all/accept_source_route;
fi
if [ -e /proc/sys/net/ipv4/conf/default/accept_source_route ]; then
      echo "0" > /proc/sys/net/ipv4/conf/default/accept_source_route;
fi

#================================================
if [ -s /data/recoverlog ]; then
  $L "Script ran fine; recovery file: $self removed..."
  sed -i -e "/$self/d" /data/recoverlog #remove name from recoverlog
fi
$L "$self Script ending @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================