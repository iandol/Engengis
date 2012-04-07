#!/system/bin/sh
# Automatic ZipAlign
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

ZALOG=/data/zipalign.log
ZIPALIGNDB=/data/zipalign.db

busybox mount -o remount,rw /system

if [ -e $ZALOG ]; then
  rm $ZALOG
fi
if [ ! -f $ZIPALIGNDB ]; then
  touch $ZIPALIGNDB
fi
echo "Automatic ZipAlign starting at $( date "+%d/%m/%Y %H:%M:%S" )" | tee -a $ZALOG
for DIR in /system/app /data/app /system/framework ; do
  cd $DIR
  for APK in *.apk ; do
    if [ $APK -ot $ZIPALIGNDB ] && [ $(grep "$DIR/$APK" $ZIPALIGNDB|wc -l) -gt 0 ] ; then
      echo "Already checked: $DIR/$APK" | tee -a $ZALOG
    else
      ZIPCHECK=$(/system/xbin/zipalign -c -v 4 $APK | grep FAILED | wc -l);
      if [ $ZIPCHECK == "1" ] ; then
        echo "Now aligning: $DIR/$APK" | tee -a $ZALOG
        zipalign -f 4 $APK /cache/$APK
        cp -f -p /cache/$APK $APK
        busybox rm -f /cache/$APK
        grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
      else
        echo "Already aligned: $DIR/$APK" | tee -a $ZALOG
        grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
      fi
    fi
  done
done
unset DIR APK
sync
busybox mount -o ro,remount /system
touch $ZIPALIGNDB
echo "Automatic ZipAlign finished at $( date "+%d/%m/%Y %H:%M:%S" )" | tee -a $ZALOG
#================================================
if [ -s /data/recoverlog ]; then
  $L "Script ran fine; recovery file: $self removed..."
  sed -i -e "/$self/d" /data/recoverlog #remove name from recoverlog
fi
$L "$self Script ending @ $(date "+%d/%m/%Y %H:%M:%S")"
#================================================