#!/system/bin/sh
# Automatic ZipAlign
L="log -p i -t ENGENGIS"
$L "S14zipalign Script starting@ $(date)"
if [ -e /data/do_debug ]; then
	LOG=/data/debug.log
	echo "========================================" >> $LOG
	echo "S14zipalign Script starting @ $(date)" >> $LOG
	echo "Build: $(getprop ro.build.version.release)" >> $LOG
	echo "Mod: $(getprop ro.modversion)" >> $LOG
	echo "Kernel: $(uname -r)" >> $LOG
	exec >> $LOG 2>&1
	if [ $(grep "verbose" /data/do_debug | wc -l) -gt 0 ]
    set -x
  fi
fi

ZALOG=/data/zipalign.log
ZIPALIGNDB=/data/zipalign.db

busybox mount -o remount,rw -t auto /system

if [ -e $ZALOG_FILE ]; then
	rm $ZALOG
fi
if [ ! -f $ZIPALIGNDB ]; then
	touch $ZIPALIGNDB
fi
echo "Automatic ZipAlign starting at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $ZALOG
for DIR in /system/app /data/app /system/framework ; do
  cd $DIR
  for APK in *.apk ; do
    if [ $APK -ot $ZIPALIGNDB ] && [ $(grep "$DIR/$APK" $ZIPALIGNDB|wc -l) -gt 0 ] ; then
      echo "Already checked: $DIR/$APK" | tee -a $ZALOG
    else
      zipalign -c -v 4 $APK
      if [ $? -eq 0 ] ; then
        echo "Already aligned: $DIR/$APK" | tee -a $ZALOG
        grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
      else
        echo "Now aligning: $DIR/$APK" | tee -a $ZALOG
        zipalign -f 4 $APK /cache/$APK
        cp -f -p /cache/$APK $APK
        busybox rm -f /cache/$APK
        grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
      fi
    fi
  done
done

sync
busybox mount -o ro,remount /system
touch $ZIPALIGNDB
echo "Automatic ZipAlign finished at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $ZALOG
$L "S14zipalign Script ending@ $(date)"