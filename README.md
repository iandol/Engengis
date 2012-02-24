Copyright (c) 2012, Jake "redmaner" van der Putten
Engengis project
Version: Delta 
Universal build 46

Conditions of the source
-------------------------------------------------------------------------------------
You may use the source to build engengis yourself including your own code and improvements.
You may use the source to build engengis specially for your ROM
You may use the source to contribute to engengis project and report bugs or improvements.
You may NOT use the source to build engengis and release it under another name!
You may NOT use the source to include it in another script package!
If you have any questions about the source and using it contact me jakevdputten@live.nl (it's my second email adress)

Engengis official repo
--------------------------------------------------------------------------------------
Includes:
 * Latest source code
 * OTA update service source
 * Old scripts
 * Build-tool + Extra options

How to build engengis?
--------------------------------------------------------------------------------------
To build engengis you need a few things:
 * Linux machine (ubuntu preffered)(not tested on Mac OSX)(Not working on windows)
 * Java installed (to sign zip)
 * zip/unzip (to make zip)(to get it: apt-get install zip)(apt-get install unzip)

Browse to engengis repo on your machine and give "build-engengis.sh" executable permissions.
Run script and let it do it's thing. 
On some devices you have to edit "build-engengis.sh" to let it work on your machine.

Note:
You can build now with extra options.
You can decide to include engengis terminal or not.
For rom developers (and others) can now also include settings.conf and engengis.conf

What is engengis?
--------------------------------------------------------------------------------------
Engengis is like many others a script for android devices.
There is only a huge diffrence between Engengis and other scripts.
Most scripts are totally based on improving something like better RAM or battery.
Engengis is doing something else: it's 100% configureable by the end user.

The main goal is that the end-user desides what's the best for his device.
You must admit all devices are diffrent same as the user off it! So wye should I decide what's best for him?
To achieve the best result Engengis has a lot off features that are configureable.
Not only the features are important but also the knowledge off the user.
That's why we offer some detailed information about the features we offer.

Features
--------------------------------------------------------------------------------------
 * Easy to use interface
 * Secure to use (can't run multiply tweaks at once)
 * All features can be enabled/disabled
 * Supports most android devices
 * Checks the requirements that are needed to use engengis
 * Supports a lot off partition types: BML - MMC - MTD - STL - TFSR - ZRAM
 * Offers a lot off tweaks/scripts
 * Has it's own OTA updater
 * Engengis menu to configure engengis
 * Remembers your tweaks when updated so you run always the most up-to-date scripts after an update
 * Works on most android versions

Included scripts/tweaks
--------------------------------------------------------------------------------------
 * Engengis configureable Systemtweak
 * Zipalign during boot
 * Optimize sqlite db's (not as boot but using the interface)
 * Drop caches during boot
 * Internetspeed tweaks 
 * Internetsecurity tweaks
 * IO schedulers BFQ - CFQ - Deadline - Noop - SIO - VR (can't run multiply schedulers with engengis)
 * Check wich I/O schedulers are supported
 * SD-Readspeeds 256 - 512 - 1024 -2048 - 3072 - 4096
 * CPU governors (can only be set when kernel supports them)
 * Conservative - ondemand - smartassV2 - interactive - lulzactive  supported
 * Possibility to set display resolution (dpi)
 * Has a few build.prop tweaks included

See: http://code.google.com/p/engengis

Credits/maintainers
--------------------------------------------------------------------------------------
Engengis has been made using some other existing code and by studying existing code.
The authors of that code are stated below. Without them Engengis wasn't the way it is now.

 * Brainmaster [SD-Readspeed scripts]
 * GingerReal community [Helped with testing + debugging]
 * Google [Used LMK settings from ICS and GB]
 * Hardcore [Noatime mount using loop]
 * KNZO [void menu][IO scheduler + cpu governor information]
 * Linux [Studied source code documentation]
 * Pikachu01 [Optimiz sqlite db's script][Dropcaches idea]


