SP=$PWD
OUTPUTDIR=$1
mkdir $OUTPUTDIR
for A in `ls`; do
  #echo "cd $A"
  cd $A
  ffmpeg-merge.sh merge_as_chapter *.mp4 "$OUTPUTDIR/$A.mp4"
  cd $SP
done
