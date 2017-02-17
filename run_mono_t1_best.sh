#!/bin/bash

best_number=4896
gaussian_num=$best_number
echo "------------>>testing best gaussian number $gaussian_num <<-------------"
exp_dir="exp/mono_$gaussian_num"
if [ -d "../$exp_dir" ]; then
   echo "../$exp_dir exists, delete."
   rm -R -f "../$exp_dir"
fi
SECONDS=0
ret1=$(cd ..; steps/train_mono.sh --nj 4 --totgauss $gaussian_num data/train data/lang $exp_dir)
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds for training with gaussian parameter $gaussian_num. total: $duration seconds." 

SECONDS=0
ret2=$(cd ..; utils/mkgraph.sh --mono data/lang_test_bg $exp_dir $exp_dir/graph)
ret3=$(cd ..; steps/decode.sh --nj 4 $exp_dir/graph data/test $exp_dir/decode_test)
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds for evaluation with gaussian parameter $gaussian_num. total: $duration seconds" 
ret4=$(cd ..; grep Sum $exp_dir/decode_test/score_*/*.sys | utils/best_wer.sh)
echo $ret4 
