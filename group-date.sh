#!/usr/bin/env bash
#([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})
#a='2013-10-13_15-07.01.mp4'
# [._-]
pat='(.*)[\._-]?([0-9]{4})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})\.(avi|mp4)'
for F in *; do
  #statements
  if [[ "$F" =~ $pat ]]; then
    NAVN=${BASH_REMATCH[1]}
    YEAR=${BASH_REMATCH[2]}
    MANE=${BASH_REMATCH[3]}
    DAG=${BASH_REMATCH[4]}
    TIME=${BASH_REMATCH[5]}
    MINUTT=${BASH_REMATCH[6]}
    SEKUND=${BASH_REMATCH[7]}
    FORMAT=${BASH_REMATCH[8]}

    PATDIR="${YEAR}-${MANE}-${DAG}"

    if [[ ! "$(pwd)" =~ ${PATDIR} ]]; then
      install -d ${PATDIR}
      mv $F  ${PATDIR}/
    else
      echo "## current folder is $patdir, not moving $F"

    fi

  fi

done
