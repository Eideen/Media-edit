SP=$PWD
for A in `ls -d $PWD/*`; do 
  cd $A 
  rename-video-2Y.sh 
done 
cd $SP
