#!/usr/bin/env bash
#([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})
#a='kamera.2005-06-03_10-40.00.avi'
# [._-]
pat='(.*)[\._-]([0-9]{4})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-]([0-9]{2})[\._-](avi)'
for a in `ls`; do
  #statements
  if [[ "$a" =~ $pat ]]; then
    NAVN=${BASH_REMATCH[1]}
    YEAR=${BASH_REMATCH[2]}
    MANE=${BASH_REMATCH[3]}
    DAG=${BASH_REMATCH[4]}
    TIME=${BASH_REMATCH[5]}
    MINUTT=${BASH_REMATCH[6]}
    SEKUND=${BASH_REMATCH[7]}
    FORMAT=${BASH_REMATCH[8]}

    mv -v $a ${YEAR}-${MANE}-${DAG}_${TIME}-${MINUTT}-${SEKUND}.${FORMAT}
    #statements
  fi

done

# echo $a
# echo "  full: ${BASH_REMATCH[0]}"
# echo
# echo "  Navn: ${BASH_REMATCH[1]}"
# echo "    År: ${BASH_REMATCH[2]}"
# echo "  måne: ${BASH_REMATCH[3]}"
# echo "   dag: ${BASH_REMATCH[4]}"
# echo "  time: ${BASH_REMATCH[5]}"
# echo "minutt: ${BASH_REMATCH[6]}"
# echo "sekund: ${BASH_REMATCH[7]}"
# echo "format: ${BASH_REMATCH[8]}"


# for i in "${BASH_REMATCH[@]}"
# do
#   N=1
#    echo "$i"
#
# done
