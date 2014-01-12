#!/bin/bash
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	tmp="$DIR/tmp"
	cfgsrc="$DIR/config"
    tmpfile="$tmp/screencast"
	files="$tmp/screencast_files"
	mkdir "$tmp/"
	source $cfgsrc


    # SCREENCAST = LOSSLESS SCREENCAST
    if [ -f $tmpfile ];then
		current=$(sed -n '1p' $tmpfile)
	    next=$((current+1))
	    file=$(sed -n '2p' $tmpfile)
		nextfile="${file}_${next}"
	else
		next=1
		file=$(zenity --text "Name of Video?" --entry)
		nextfile="${file}_${next}"
    fi

	if [ -f $files ]; then
		echo $nextfile >> $files
	else
		echo $nextfile > $files
	fi
	echo $next > $tmpfile
	echo $file >> $tmpfile


    # =============
    # USER SETTINGS
    # =============
    #input=$(zenity --text "Name of Video?" --entry)
    #input+="_$next"
    #echo $input
	input=$nextfile
    KEYBOARDSTART="[ Super + F5 ] keys pressed"
    KEYBOARDSTOP="[ Super + F7 ] keys pressed"
    # =============

    # =========
    # VARIABLES
    # =========
    SIZE="1920x1080"
    RATE="25"
    VCODEC="libx264"

    PIXELS="yuv420p"
	PRESET="ultrafast"
    # notification - starting
	d=$(($delay*1000))
    notify-send -t $d "$KEYBOARDSTART : screencast will begin in $delay seconds"
    
    #key-mon &
    
    # pause!
    sleep $delay
 

    # start screencasting losslessly without audio in mkv
    ffmpeg -f x11grab -s $SIZE -r $RATE -i :0.0+1680,0 -vcodec $VCODEC -preset $PRESET -crf 0 -threads 0 -y "$output"/"$input".mkv
