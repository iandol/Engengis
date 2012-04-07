#!/system/bin/sh
# Copyright© 2011 redmaner
# Engengis updater V16a

checkupdate () {
clear
CONFIG=/data/engengis.conf
VERSION=555
OLDVERSION=$(cat /system/etc/engengis/version)
VERSIONNR=V0.5.5.5

echo
echo " ------------------------"
echo "    Engengis.Updater   " 
echo " ------------------------"
echo
echo "Latest version = Engengis.Delta_$VERSIONNR"
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
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/bin/engengis.sh -O /system/bin/engengis; 
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S00systemtweak -O /system/etc/engengis/S00systemtweak
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S07hsstweak -O /system/etc/engengis/S07hsstweak
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S14zipalign -O /system/etc/engengis/S14zipalign
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S21governortweak -O /system/etc/engengis/S21governortweak
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28bfqscheduler -O /system/etc/engengis/S28bfqscheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28cfqscheduler -O /system/etc/engengis/S28cfqscheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28deadlinescheduler -O /system/etc/engengis/S28deadlinescheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28noopscheduler -O /system/etc/engengis/S28noopscheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28sioscheduler -O /system/etc/engengis/S28sioscheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S28vrscheduler -O /system/etc/engengis/S28vrscheduler
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd256 -O /system/etc/engengis/S35sd256
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd512 -O /system/etc/engengis/S35sd512
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd1024 -O /system/etc/engengis/S35sd1024
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd2048 -O /system/etc/engengis/S35sd2048
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd3072 -O /system/etc/engengis/S35sd3072
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S35sd4096 -O /system/etc/engengis/S35sd4096
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S49dropcaches -O /system/etc/engengis/S49dropcaches
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S56internet -O /system/etc/engengis/S56internet
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/S63internetsecurity -O /system/etc/engengis/S63internetsecurity
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/terminal -O /system/etc/engengis/terminal
  wget -q https://raw.github.com/iandol/Engengis/master/include/system/etc/engengis/version -O /system/etc/engengis/version
  wget -q https://github.com/iandol/Engengis/raw/master/include/system/etc/engengis/resources/libncurses.so -O /system/etc/engengis/libncurses.so
  wget -q https://github.com/iandol/Engengis/raw/master/include/system/etc/engengis/resources/sqlite3 -O /system/etc/engengis/sqlite3
  wget -q https://github.com/iandol/Engengis/raw/master/include/system/etc/engengis/resources/zipalign -O /system/etc/engengis/zipalign
  echo "Setting permissions..."
  chmod 777 /system/bin/engengis
  chmod 775 /system/etc/engengis/sqlite3
  chmod 775 /system/etc/engengis/zipalign
  if [ -e /data/engengis.conf ]; then
      sed -i '/status=*/ d' /data/engengis.conf;
      echo "status=updated" >> /data/engengis.conf;
  fi;
  echo
  echo "Installation complete!"
  sleep 3
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



