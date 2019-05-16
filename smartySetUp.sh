#!/bin/sh

##log file for wget
WGET_LOG=wgetLog

## new name for smarty tar
NEWPACKNAME='smarty.v3.1.33.tar.gz'

##name of new smarty directory
NEWSMARTYDIR='smarty'

##where you want store smarty
PATHTOSTORE='test/'

## your project path
PROJECTPATH='test/project'

## your webserver user 
WEBSERVERUSER='apache'

##########################################
##                                      ##
##       DO NOT CHANGE THIS  ...        ##
##                                      ##
##########################################

smartyPackages=https://github.com/smarty-php/smarty/archive/v3.1.33.tar.gz
ROOT_UID=0
PACK='v3.1.33.tar.gz'
SMARTYDIR='smarty-3.1.33'
TEMPLATESFOLDER='templates'
TEMPLATES_CFOLDER='templates_c'
CACHEFOLDER='cache'
CONFIGSFOLDER='configs'

# must be root for run
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "This script must be run by system's administrator...not you! "
  exit 2
fi

#download smarty
wget -a logwget $smartyPackages || {
        echo "Can't download smarty. Check you internet connection."
        exit 1
}

echo "download...OK"

#rename directory
mv $PACK $NEWPACKNAME

#extract
tar -zxf $NEWPACKNAME || {
	echo "Can't extract! Check tar packages.."
	exit 4
}
#if [ "$?" -ne "0"]
#then
#	echo "Can't extract! Check tar packages.."
#	exit 4
#fi

echo "extract...OK"

##directory estratta => newsmartydir
mv $SMARTYDIR $NEWSMARTYDIR

if [ ! -d "$PATHTOSTORE" ]
then
	echo "Create $PATHTOSTORE"
	mkdir $PATHTOSTORE
fi

##copy content libs in pathtostore smarty
cp -r $NEWSMARTYDIR/libs/* $PATHTOSTORE/

echo "copied smarty's libs into $PATHTOSTORE" 

if [ ! -d "$PROJECTPATH" ]
then
	echo "create $PROJECTPATH folder"
	mkdir $PROJECTPATH
fi

#mkdir $PROJECTPATH
mkdir $PROJECTPATH/$CACHEFOLDER
echo "create $CACHEFOLDER folder"

mkdir $PROJECTPATH/$CONFIGSFOLDER
echo "create $CONFIGSFOLDER folder"

mkdir $PROJECTPATH/$TEMPLATESFOLDER
echo "create $TEMPLATESFOLDER folder"

mkdir $PROJECTPATH/$TEMPLATES_CFOLDER
echo "create $TEMPLATES_CFOLDER folder"

chmod 775 $PROJECTPATH/$TEMPLATES_CFOLDER
chmod 775 $PROJECTPATH/$CACHEFOLDER
chown $WEBSERVERUSER:$WEBSERVERUSER $PROJECTPATH/$TEMPLATES_CFOLDER
chown $WEBSERVERUSER:$WEBSERVERUSER $PROJECTPATH/$CACHEFOLDER

echo "changed owner and permission for $PROJECTPATH/$TEMPLATES_CFOLDER and $PROJECTPATH/$CACHEFOLDER"
echo "Maybe it's all ok...ENJOY your new framework .."

exit 0
