#!/bin/bash

    # SCREENCAST = LOSSLESS SCREENCAST
    tmpfile='/home/lsc/.scripts/tmp/screencast'
	files='/home/lsc/.scripts/tmp/screencast_files'
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
    OUTPUT="/home/lsc/Dropbox/Videos/Screencasts"
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
    # =========

      # ===========
      # INFORMATION
      # ===========
      
      # ==========================================
      # keyboard bindings for chosen keys [rc.xml]
      # ==========================================
      # <keybind key="A-F1"><action name="Execute"><command>screencast</command></action></keybind>
      # <keybind key="A-F3"><action name="Execute"><command>screencast-stop</command></action></keybind>
      # ==========================================

      # ==============================
      # terminal conversion MKV >> MP4
      # ==============================
      # ffmpeg -i screencast.mkv -c:v libx264 -preset fast -crf 18 -y screencast.mp4
      # ==============================

      # ===============================
      # thunar custom action MKV >> MP4
      # ===============================
      # terminal --title="Screencast MKV Conversion to MP4" --geometry="200x35" --icon="$HOME/.icons/ffmpeg/convert.png" -e " ffmpeg -i %f -c:v libx264 -preset fast -crf 18 -y `basename %f .mkv`.mp4"
      # ===============================

    # ============
    # SCRIPT BELOW
    # ============
    
    # notification - starting
    notify-send -t 6000 "$KEYBOARDSTART : screencast will begin in 6 seconds"
    
    #key-mon &
    
    # pause!
    sleep 6
 

    # start screencasting losslessly without audio in mkv
    ffmpeg -f x11grab -s $SIZE -r $RATE -i :0.0+1680,0 -vcodec $VCODEC -preset $PRESET -crf 0 -threads 0 -y "$OUTPUT"/"$input".mkv
    #ffmpeg -f x11grab -r 24 -s 1920x1080 -i :0.0+1680,0 -vcodec libx264 -preset ultrafast -crf 0 -threads 0 "$OUTPUT"/"$INPUT".mkv

    
    # start screencasting losslessly without audio in ogg (WIP)
    #ffmpeg -f x11grab -s $SIZE -r $RATE -i input -c:v libtheora -q:v 8 output.ogg

    ## screencast-stop ## << script (assigned to keyboard shortcut) silently brings the ffmpeg process to a halt here! >>

    # notification - completion
    #notify-send -t 3000  "$KEYBOARDSTOP : Screencast finished   :-)"

    # pause
    #sleep 3

    # open thunar to show video
    #thunar "$OUTPUT"
   
