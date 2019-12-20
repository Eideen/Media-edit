#!/usr/bin/env bash


pat='(.*)([0-9]{4})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-](avi|mp4|mkv)'

#([0-9]{2})[\._-]([0-9]{2})[\._-](avi)'
RegexPat(){
  if [[ "$1" =~ $pat ]]; then
    NAVN=${BASH_REMATCH[1]}
    YEAR=${BASH_REMATCH[2]}
    MANE=${BASH_REMATCH[3]}
    DAG=${BASH_REMATCH[4]}

    FORMAT=${BASH_REMATCH[5]}

    touch -d "${YEAR}-${MANE}-${DAG} 00:00:00" $a
    echo "change date: $a -> ${YEAR}-${MANE}-${DAG} 00:00:00"

 else 
 echo "regex not correct expected .*2019-12-12.(avi|mp4) got $a"
  fi

}

loopA() {
  for a in *; do
    RegexPat $a
        done

}

if [ -z $1 ]; then
echo "Doing all in local(*)"
 loopA
else
  echo '$1 is defined, doing $@'

  for a in "$@"; do
    RegexPat $a
  done


