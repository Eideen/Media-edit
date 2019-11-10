SP=$PWD
for A in `ls -d $PWD/*`; do 
  cd $A 
  rename-video.sh 
done 
cd $SP
