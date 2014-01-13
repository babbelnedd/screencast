#!/bin/bash
killall ffmpeg
#notify-send -t 6000 "Screencast paused"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
zenity --question --text "Would you like to resume?"
if [ $? = 0 ];then
# 'yes'
bash $DIR/screencast.sh
else
# 'no'
notify-send -t 6000 "Screencast stopped"
fi

#killall key-mon
