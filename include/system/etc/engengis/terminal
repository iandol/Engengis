#!/system/bin/sh
# Copyright (c) 2012 - redmaner
# Engengis Project
# Version: 0.5.0.5

BPROP=/system/build.prop

terminal () {
mount -o remount,rw /system
clear
echo " ~ Engengis terminal ~"
echo "------------------------"
echo -n "Enter option : "; read options;

case "$options" in
  "wipe batterystats") clear; wipebatterystats;;
  "wipe dalvikcache") clear; wipedalvikcache;;
  "wipe cache") clear; wipecache;;
  "wipe init.d") clear; wipe init.d;;
  "setdpi") clear; setdpi;;
  "optimize sqlite") clear; optimizesqlite;;
  "drop caches") clear; dropcaches;;
  "force engengis") clear; forceengengis;;
  "engengis") clear; engengis;; 
  "exit") clear; exit;; 
  "reboot") clear; reboot;; 
  "poweroff") clear; poweroff;; 
  "recovery") clear; reboot recovery;; 
esac
}

wipebatterystats () {
rm -f /data/system/batterystats.bin
terminal;
}

wipedalvikcache () {
rm -rf /data/dalvik-cache
rm -rf /cache/dalvik-cache
echo
echo "your phone will reboot in a few seconds!"
sleep 2
reboot
}

wipecache () {
rm -rf /cache
echo
echo "your phone will reboot in a few seconds!"
sleep 2
reboot
}

wipeinitd () {
rm -rf /system/etc/init.d
mkdir /system/etc/init.d
chmod 0777 /system/etc/init.d
echo
echo "Do you want to reboot your phone now?"
echo "[y/n]"
read rebootphone

case "$rebootphone" in
  "y" | "Y") reboot;;
  "n" | "N") terminal;;
esac
}

setdpi () {
echo
echo "Please enter your dpi value: "; read dpiinput
echo
echo "Your dpi value will be set to: $dpiinput"
echo "Are you sure?"
echo "[y/n]"
read dpioption
case "$dpioption" in
  "y" | "Y")
  sed -i '/ro.sf.lcd_density=*/ d' $BPROP;
  echo "ro.sf.lcd_density=$dpiinput" >> $BPROP;
  echo
  echo "Set dpi to $dpiinput"
  echo "Phone will reboot in a few seconds!"
  sleep 3
  reboot;;
  "n" | "N") clear; terminal;;
esac
}

optimizesqlite () {
clear
echo "Ignore all errors during proces!"
echo "Errors won't harm your phone!"
sleep 3
clear
echo "Optimizing Sqlite db's please wait..."
sleep 1
# Thanks to pikachu01 for this script.
# All credits for this script goes to him.
	for i in \
	`busybox find /data -iname "*.db"`; 
	do \
		/system/xbin/sqlite3 $i 'VACUUM;'; 
		/system/xbin/sqlite3 $i 'REINDEX;'; 
	done;
	if [ -d "/dbdata" ]; then
		for i in \
		`busybox find /dbdata -iname "*.db"`; 
		do \
			/system/xbin/sqlite3 $i 'VACUUM;'; 
			/system/xbin/sqlite3 $i 'REINDEX;'; 
		done;
	fi;
	if [ -d "/datadata" ]; then
		for i in \
		`busybox find /datadata -iname "*.db"`; 
		do \
			/system/xbin/sqlite3 $i 'VACUUM;'; 
			/system/xbin/sqlite3 $i 'REINDEX;'; 
		done;
	fi;
	for i in \
	`busybox find /sdcard -iname "*.db"`; 
	do \
		/system/xbin/sqlite3 $i 'VACUUM;'; 
		/system/xbin/sqlite3 $i 'REINDEX;'; 
	done;
 clear; terminal;
}

dropcaches () {
sync;
sleep 1
echo "3" > /proc/sys/vm/drop_caches
sleep 1
echo "1" > /proc/sys/vm/drop_caches
sleep
echo
echo "Caches dropped!"
sleep 2
clear; terminal;
}

forceengengis () {
sh /system/etc/init.d/S*
sleep 3
clear; terminal;
}

terminal;
