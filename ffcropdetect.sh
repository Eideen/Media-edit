#!/usr/bin/env bash

function ffcropdetect() {
    ffmpeg -i $1 -t 1 -vf cropdetect -f null - 2>&1 | awk '/crop/ { print $NF }' | tail -1
}


function RegexPat(){

  pat_file='(.*)(avi|mp4)'
  pat_crop='.*([0-9]{3}):([0-9]{3}):([0-9]{1,3}):([0-9]{1,3})'
  if [[ "$1" =~ $pat_file ]]; then
    local crop=$(ffcropdetect $1)

    if [[ "$crop" =~ $pat_crop ]]; then
      CW=${BASH_REMATCH[1]}
      CH=${BASH_REMATCH[2]}
      CX=${BASH_REMATCH[3]}
      CY=${BASH_REMATCH[4]}
      if [[ "$CX" != "0" ]] || [[ "$CY" != "0" ]]; then
        echo  "$PWD/${1##./} $CW:$CH:$CX:$CY"
      fi
    else
      echo "output is wrong $1 ${crop}"
    fi

    #echo \e[31m"output not expected"\033[0m

 else
 echo "regex not correct expected .*avi or .*mp4 $a"
  fi

}

loopA() {
	for a in `ls`; do
  	RegexPat $a
        done

}

if [ -z $1 ]; then
 loopA
else
	#echo '$1 is defined, doing $@'

	for a in "$@"; do
		RegexPat $a
	done

fi
