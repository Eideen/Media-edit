##!/usr/bin/env bash

composer="Torstein Eide"
copyright=$composer
SP=$PWD
program_is_installed {
  local return_=1
  type $1 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

check_fail {
  printf "\e[31m✘ ${1}"
  echo -e "\033[0m"
}

function check_pass {
  printf "\e[32m✔ ${1}"
  echo -e "\033[0m"
}

function check_if {
  if [ $1 == 1 ]; then
    check_pass $2
  else
    check_fail $2
  fi
}



merge_as_chapter(){
    # https://medium.com/@dathanbennett/adding-chapters-to-an-mp4-file-using-ffmpeg-5e43df269687
    # https://ffmpeg.org/ffmpeg-formats.html#Metadata-1
    # https://stackoverflow.com/questions/47415660/how-to-add-chapters-into-mp4-mkv-file-using-ffmpeg

    echo "### Merge As Chapter ###"


    # Set output file (get last agument)
    echo $@
    local output=${@: -1}
    echo "output file: $output"
    local TMPname=${output##*/}


    # remove last argument
    set -- ${@:1:$# -1}
    echo
    chapterfile="/tmp/chapterfile_${TMPname}"
    mergefile="/tmp/mergefile_${TMPname}"

    echo "making chapterfile: $chapterfile"
    touch $mergefile $chapterfile
    create_chapterfile "$@" "$output" > "$chapterfile"
    check_pass
    echo
    echo "### making mergefile ###"
    echo "making mergefile: $mergefile"
    echo
    create_mergefile "$@" > "$mergefile"
    check_pass
    echo "### making chapterfile ###"
    echo "making chapterfile: $chapterfile"

    echo "ffmpeg_merge $mergefile $chapterfile $output"
    ffmpeg_merge $mergefile $chapterfile $output
    check_pass
}
function create_mergefile() {
  for f in $@; do
  echo "file '$SP/$f'"
  done
}
function ffmpeg_merge() {
  #-hide_banner -loglevel error
  ffmpeg  -f concat -safe 0 -i $1 -i $2 -map_metadata 1  -codec copy $3
}
# call arguments verbatim:
function create_chapterfile() {
  local output=${@: -1}
  local output=${output##*/}
  set -- ${@:1:$# -1}
  i=0
  chapter=0
  printf ";FFMETADATA1""%s\n"
  printf "title=${output%%.*}""%s\n"
  printf "composer=$composer""%s\n"
  printf "copyright=$copyright""%s\n"
  printf "%s\n"
  printf "%s\n"
  pat='(.*)([0-9]{2,4})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-n]([0-9]{2})[\._-](.*)'

  #
  for  A in $@; do
    lenge=$(duration $A)

  if [[ "$A" =~ $pat ]]; then
  NAVN=${BASH_REMATCH[1]}
  YEAR=${BASH_REMATCH[2]}
  MANE=${BASH_REMATCH[3]}
  DAG=${BASH_REMATCH[4]}
  TIME=${BASH_REMATCH[5]}
  MINUTT=${BASH_REMATCH[6]}
  SEKUND=${BASH_REMATCH[7]}
  fi
    #echo $A $i $lenge $chapter
    let "i+=1"

    printf "[CHAPTER]""%s\n"
    printf ""TIMEBASE=1/1000"%s\n"
    printf "START=$chapter""%s\n"
    chapter=$(echo "( $lenge * 10^3 ) + $chapter" | bc -l )
    chapter=${chapter%.*}
    printf "END=$chapter""%s\n"
    printf "title=${YEAR}-${MANE}-${DAG}_${TIME}:${MINUTT}:${SEKUND} \#$i""%s\n"

  done
}

function duration(){
        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1"
}

function HELP() {
  echo "base functions:"
  echo "- merge_as_chapter"
  echo "- merge_file"
  echo "- merge_as_chapter"
  echo "Usage: merge_as_chapter input.mp4 [input.mp4...] output.mp4"
}

if  [[ "$@" =~ "-h" ]]; then
  echo "printing help:"
  HELP
  exit
elif [[ "$#" -lt 2 ]]; then

   echo "Error: Wrong number of parameters"
   echo
   echo "printing help:"
   HELP
   exit
fi

echo "### checking dependencyes ###"
echo "     ffmpeg $(check_if $(program_is_installed ffmpeg))"
echo "       gpac $(check_if $(program_is_installed MP4Box))"
echo "mp4v2-utils $(check_if $(program_is_installed mp4chaps))"
echo "  coreutils $(check_if $(program_is_installed realpath))"
echo "         bc $(check_if $(program_is_installed bc))"
"$@"
