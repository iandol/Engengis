#!/system/bin/sh
# Copyright© 2011 redmaner
# Engengis updater V16

checkupdate () {
clear
CONFIG=/data/engengis.conf
VERSION=506
OLDVERSION=`cat /system/etc/engengis/version`

echo
echo " ------------------------"
echo "    Engengis.Updater   " 
echo " ------------------------"
echo
echo "Latest version = Engengis.Delta_v0.5.0.6"
echo
if [ $OLDVERSION -eq $VERSION ]; then
     echo "Update is not needed"
     echo "Do you want to force an update?"
     echo "[y or n]"
     read forceupdate
elif [ $OLDVERSION -lt $VERSION ]; then
     echo "There is an update available"
     echo "Do you want to update?"
     echo "[y or n]"
     read update
elif [ $OLDVERSION -gt $VERSION ]; then
     echo "You are using a newer version off Engengis"
     echo "Your version is not yet supported by the mainline"
     echo "Update cancelled"
     sleep 3
     clear
     engengis 
fi;

case "$update" in
  "y" | "Y")
  mount -o remount,rw /system
  echo
  echo "This will take a moment..."
  mount -o remount,rw /system
  rm -rf /system/etc/engengis
  rm -f /system/bin/engengis
  rm -f /system/bin/engengisa
  rm -f /system/bin/engengissettings
  rm -f /system/bin/engengisg
  rm -f /system/bin/engengishss
  rm -f /system/bin/engengisr
  rm -f /system/bin/engengiss
  rm -f /system/bin/terminal
  rm -f /system/xbin/sqlite3
  rm -f /system/xbin/zipalign
  rm -f /system/etc/init.d/S00systemtweak
  rm -f /system/etc/init.d/S00ramscript
  rm -f /system/etc/init.d/S07hsstweak
  rm -f /system/etc/init.d/S21governortweak
  rm -f /system/etc/init.d/S21hsstweak
  rm -f /system/etc/init.d/S14zipalign
  rm -f /system/etc/init.d/S21sqlite
  rm -f /system/etc/init.d/S28scheduler
  rm -f /system/etc/init.d/S35sdreadspeed
  rm -f /system/etc/init.d/S42cpugovernor
  rm -f /system/etc/init.d/S49dropcaches
  rm -f /system/etc/init.d/S56internet
  rm -f /system/etc/init.d/S63internetsecurity
  rm -f /data/engengis.log
  rm -f /data/zipalign.db
  rm -f /data/zipalign.log
  echo "Installing new files..."
  mkdir /system/etc/engengis
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/bin/engengis -O /system/bin/engengis; 
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S00systemtweak -O /system/etc/engengis/S00systemtweak
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S07hsstweak -O /system/etc/engengis/S07hsstweak
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S14zipalign -O /system/etc/engengis/S14zipalign
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S21governortweak -O /system/etc/engengis/S21governortweak
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28bfqscheduler -O /system/etc/engengis/S28bfqscheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28cfqscheduler -O /system/etc/engengis/S28cfqscheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28deadlinescheduler -O /system/etc/engengis/S28deadlinescheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28noopscheduler -O /system/etc/engengis/S28noopscheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28sioscheduler -O /system/etc/engengis/S28sioscheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S28vrscheduler -O /system/etc/engengis/S28vrscheduler
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd256 -O /system/etc/engengis/S35sd256
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd512 -O /system/etc/engengis/S35sd512
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd1024 -O /system/etc/engengis/S35sd1024
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd2048 -O /system/etc/engengis/S35sd2048
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd3072 -O /system/etc/engengis/S35sd3072
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S35sd4096 -O /system/etc/engengis/S35sd4096
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S49dropcaches -O /system/etc/engengis/S49dropcaches
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S56internet -O /system/etc/engengis/S56internet
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/S63internetsecurity -O /system/etc/engengis/S63internetsecurity
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/terminal -O /system/etc/engengis/terminal
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/etc/engengis/version -O /system/etc/engengis/version
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/lib/libncurses.so -O /system/lib/libncurses.so
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/xbin/sqlite3 -O /system/xbin/sqlite3
  wget -q http://dl.dropbox.com/u/26139869/engengis/system/xbin/zipalign -O /system/xbin/zipalign
  echo "Setting permissions..."
  chmod 777 /system/bin/engengis
  chmod 775 /system/xbin/sqlite3
  chmod 775 /system/xbin/zipalign
  chmod 775 /system/lib/libncurses.so
  if [ -e /data/engengis.conf ]; then
      sed -i '/status=*/ d' /data/engengis.conf;
      echo "status=updated" >> /data/engengis.conf;
  fi;
  echo
  echo "Installation complete!"
  sleep 5
  clear 
  engengis
  ;;
  "n" | "N")
  echo "Update cancelled"
  sleep 3
  clear
  engengis 
  ;;
esac

case "$forceupdate" in
  "y" | "Y")
  mount -o remount,rw /system
  echo "1" > /system/etc/engengis/version
  checkupdate;;
  "n" | "N") clear; engengis;;
esac
}

checkupdate;



