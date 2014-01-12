#!/bin/bash
     DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
     tmp="$DIR/tmp"
     cfgsrc="$DIR/config"
     tmpfile="$tmp/screencast"
     files="$tmp/screencast_files"
     mkdir "$tmp/"
     source $cfgsrc
     file=$(sed -n '2p' $tmpfile)

      # Close the screencasting process gracefully
      # ==========================================
        killall ffmpeg
        if [ -f $tmpfile ]; then
			rm -f $tmpfile
		fi
     # notification - completion
     notify-send -t 3000  "$KEYBOARDSTOP : Screencast finished   :-)"
 
 	# mege files
	cmd="mkvmerge -o $output/"
	cmd+=$file
	cmd+='.mkv '
	n=0
	while read line
	do
	n=$(($n + 1))
	if [ $n -gt 1 ]; then
	cmd+="+"
	fi
    cmd+="$output/$line"
	cmd+='.mkv '
	done < $files

#	sleep 3
	eval $cmd
#    sleep 3
	
	# delete part files
	while read line
	do
	rm -f "$output/$line.mkv"
	done < $files

	rm -f "$files"
    
	# open thunar to show video
	thunar $output
    #killall key-mon
      # ==========================================
