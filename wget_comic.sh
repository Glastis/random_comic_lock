#!/bin/bash
FILENAME="rcg"
BLURFILE='blur.png'
TRUELASTPOST="true_last_post.png"
LASTPOST="lock_image/last_post.png"
FLAGG=0
BEG_PWD=`pwd`
USER_HOME=`eval echo "~$different_user"`
CONFIG_PATH="$USER_HOME/.xscreensaver"

trap ctrl_c INT

function ctrl_c() {
    cp xscreensaver.bkp $CONFIG_PATH
    cd $BEG_PWD
    exit
}

cd "$( dirname "${BASH_SOURCE[0]}" )"
cp $CONFIG_PATH ./xscreensaver.bkp
cp xscreensaver_comic.blank xscreensaver_comic
sed s:'NON_REDONDANT_STRING_HERE':`pwd`: < xscreensaver_comic.blank > xscreensaver_comic
cp xscreensaver_comic $CONFIG_PATH
while [ 1 ];do
    if [ $FLAGG \< 1 ];then
	FLAGG=10
	xscreensaver-command --lock
    fi
    wget http://explosm.net/rcg
    LINK_IMG=`./a.out | grep http://files.explosm.net/rcg/ | head -1`
    PICTURE_NAME=`echo $LINK_IMG | awk -F "/" '{print $NF}'`
    rm -f $FILENAME $TRUELASTPOST $BLURFILE
    wget $LINK_IMG > /dev/null 2> /dev/null
    mv $PICTURE_NAME $TRUELASTPOST
    SIZE_FILE=`file $TRUELASTPOST | awk -F " " '{print $5,$7}' | awk -F "," '{print $1}'`
    echo $SIZE_FILE
    SIZE_X=`echo $SIZE_FILE | awk -F " " '{print $1}'`
    SIZE_Y=`echo $SIZE_FILE | awk -F " " '{print $2}'`
    if (("$SIZE_Y" > "0"));then
	if [ $SIZE_X \< $SIZE_Y ];then MAX_SIZE=$((108000 / SIZE_Y));else MAX_SIZE=$((192000 / SIZE_X));fi
	convert -resize 1920x1080 $TRUELASTPOST $TRUELASTPOST
	echo -en "Begining blur...\t"
	convert $TRUELASTPOST -resize "2800x1080" -channel RGBA  -blur 0x15 -crop 1920x1080+400x0 $BLURFILE
	convert $BLURFILE $TRUELASTPOST -gravity center -composite -matte $LASTPOST
	rm -f $TRUELASTPOST $BLURFILE $FILENAME
	echo "done"
	echo "Sleeping..."
	sleep 10
    fi
done
