#!/bin/sh

##log file for wget
WGET_LOG=wgetLog

## new name for smarty tar
NEWPACKNAME='smarty.v3.1.33.tar.gz'

##name of new smarty directory
NEWSMARTYDIR='smarty'

##where you want store smarty
PATHDIRECTORY='test/'

## your project path
PROJECTPATH='test/project'

## your webserver user 
WEBSERVERUSER='apache'

##########################################
##                                      ##
##       DO NOT CHANGE THIS  ...        ##
##                                      ##
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
  echo "Devi essere root per eseguire questo script.\nThis script must be run by system's administrator...not you! "
  exit 2
fi

#download smarty
wget -a logwget $smartyPackages || {
        echo "Can't download smarty. Check you internet connection."
        exit 1
}

#rinomino la directory
mv $PACK $NEWPACKNAME

#scompatto la direcotry
gtar -zxf $NEWPACKNAME

#echo $?>ritorno

mv $SMARTYDIR $NEWSMARTYDIR

cp -r $NEWSMARTYDIR/libs/* $PATHDIRECTORY

mkdir $PROJECTPATH/smarty
mkdir $PROJECTPATH/smarty/$CACHEFOLDER
mkdir $PROJECTPATH/smarty/$CONFIGSFOLDER

mkdir $PROJECTPATH/smarty/$TEMPLATESFOLDER
mkdir $PROJECTPATH/smarty/$TEMPLATES_CFOLDER

chmod 775 $PROJECTPATH/smarty/$TEMPLATES_CFOLDER
chmod 775 $PROJECTPATH/smarty/$CACHEFOLDER
chown $WEBSERVERUSER:$WEBSERVERUSER $PROJECTPATH/smarty/$TEMPLATES_CFOLDER
chown $WEBSERVERUSER:$WEBSERVERUSER $PROJECTPATH/smarty/$CACHEFOLDER

echo "Maybe it's all ok...ENJOY your new framework .."
exit 0
