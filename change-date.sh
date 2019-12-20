	#!/usr/bin/env bash


pat='(.*)([0-9]{4})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-](avi)'
RegexPat(){
  if [[ "$1" =~ $pat ]]; then
    NAVN=${BASH_REMATCH[1]}
    YEAR=${BASH_REMATCH[2]}
    MANE=${BASH_REMATCH[3]}
    DAG=${BASH_REMATCH[4]}
    TIME=${BASH_REMATCH[5]}
    MINUTT=${BASH_REMATCH[6]}
    SEKUND=${BASH_REMATCH[7]}
    FORMAT=${BASH_REMATCH[8]}

    touch -d "${YEAR}-${MANE}-${DAG} ${TIME}:${MINUTT}:${SEKUND}" $a
    echo "change date: $a -> ${YEAR}-${MANE}-${DAG} ${TIME}:${MINUTT}:${SEKUND} "

    #statements
 else 
 echo "regex not correct expected .*2019-12-12_12-12-00.avi got $a"
  fi

}

loopA() {
	for a in `ls`; do
  	RegexPat $a
        done

}

if [ -z $1 ]; then
echo "hi"
 loopA
else
	echo '$1 is defined, doing $@'

	for a in "$@"; do
		RegexPat $a
	done

fi
