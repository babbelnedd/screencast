#!/bin/bash

     tmpfile='/home/lsc/.scripts/tmp/screencast'
     files='/home/lsc/.scripts/tmp/screencast_files'
     file=$(sed -n '2p' $tmpfile)
	 output='/home/lsc/Dropbox/Videos/Screencasts/'

      # Close the screencasting process gracefully
      # ==========================================
        killall ffmpeg
        if [ -f $tmpfile ]; then
			rm -f $tmpfile
		fi
     # notification - completion
     notify-send -t 3000  "$KEYBOARDSTOP : Screencast finished   :-)"
 
 	# mege files
	cmd="mkvmerge -o $output"
	cmd+=$file
	cmd+='.mkv '
	n=0
	while read line
	do
	n=$(($n + 1))
	if [ $n -gt 1 ]; then
	cmd+="+"
	fi
    cmd+="$output$line"
	cmd+='.mkv '
	done < $files

#	sleep 3
	eval $cmd
#    sleep 3
	
	# delete part files
	while read line
	do
	rm -f "$output$line.mkv"
	done < $files

	rm -f "$files"
    
	# open thunar to show video
	thunar $output
    #killall key-mon
      # ==========================================
