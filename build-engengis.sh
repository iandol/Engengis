#!/bin/sh
# Copyright (c) 2012, Jake "redmaner" van der Putten
# Engengis build tool
# Version: 2301121804

# System requirements
# -----------------------------------------
# - Ubuntu (or any other unix based system)
# - Java (to sign zip file)
# - zip/unzip (apt-get install zip/apt-get install unzip)

VERSION=`cat currentversion`

check () {
if [ -d build ]; then
     echo "Start building engengis..."
     sleep 1
     echo
     echo "Do you want to build with extra options?"
     echo "[y/n]"
     read extraoptionbuild
else
     mkdir build
     check;
fi;

case "$extraoptionbuild" in
  "y" | "Y") terminal;;
  "n" | "N") compile;;
esac
}

terminal () {
echo
echo "Do you want to include engengis terminal?"
echo "[y/n]"
read includeterminal;

case "$includeterminal" in
  "y" | "Y")
  cp extra/terminal include/system/etc/engengis/terminal;
  settingsconfig;;
  "n" | "N") settingsconfig;;
esac
}

settingsconfig () {
echo
echo "Do you want to include pre-build settings.conf file?"
echo "[y/n]"
read includesettingsconfig;

case "$includesettingsconfig" in
  "y" | "Y")
  cp extra/settings.conf include/data/settings.conf;
  engengisconfig;;
  "n" | "N") engengisconfig;;
esac
}

engengisconfig () {
echo
echo "Do you want to include pre-build engengis.conf file?"
echo "[y/n]"
read includeengengisconfig;

case "$includeengengisconfig" in
  "y" | "Y")
  cp extra/engengis.conf include/data/engengis.conf;
  compile;;
  "n" | "N") compile;;
esac
}

compile () {
cd include
echo
echo "Making zip archieve..."
sleep 1
zip -r engengis * 
cd ..
sleep 2
echo "Signing zip archieve..."
mv include/engengis.zip signzip/engengis.zip
cd signzip
java -jar signapk.jar testkey.x509.pem testkey.pk8 engengis.zip signed-engengis.zip
cd ..
mv signzip/signed-engengis.zip build/$VERSION.zip
echo "Done find build at:"
echo "/build/$VERSION.zip"
rm -f signzip/engengis.zip
sleep 3
echo
echo "Do you want to keep extra options?"
echo "[y/n]"
read remove

case "$remove" in
  "y" | "Y") 
  echo
  echo "End off build progress"
  sleep 2; exit;;
  "n" | "N" )
  rm -f include/system/etc/engengis/terminal
  rm -f include/data/settings.conf
  rm -f include/data/engengis.conf
  echo
  echo "Extra options removed"
  echo
  echo "End off build progress"
  sleep 2; exit;;
esac  
}

check;
