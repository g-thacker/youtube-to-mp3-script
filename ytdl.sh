#!/bin/bash

URL=$1

if ! command -v youtube-dl &> /dev/null; then
	echo "$0 requires youtube-dl to be installed"
	exit 2
fi

if ! command -v python3 &> /dev/null; then
	echo "$0 requires Python3 to be installed"
	exit 2
fi

if ! test -f "/usr/bin/python"; then
	if test -f "/usr/bin/python3"; then
		sudo ln -s /usr/bin/python3 /usr/bin/python
	else
		echo "$0 cannot find Python env"
		exit 2
	fi
fi

if [ $# -lt 1 ]; then
	echo "$0: Missing argument
Requires a YouTube video URL"
	exit 2
fi

if [ $# -gt 1 ]; then
	echo "$0: Too many arguments
Script cannot take multiple arguments"
	exit 2
fi

if [[ $URL != http?(s)://www.youtube.com/watch* ]]; then
	echo "$0: Script must be provided a YouTube video URL as an argument
URL must begin with \"https://www.youtube.com/watch\""
	exit 2
else	
	youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 $1
	exit 0
fi
