#!/bin/bash

best_gauss=4896

echo "step1.create cmvn..."
#for dir in train test; do 
#    ret1=$(cd ..; steps/compute_cmvn_stats.sh data/$dir exp/make_mfcc/$dir mfcc)
#done

for dir in cmvn_mean cmvn_var cmvn_reverse 
do
   #chcek dir existence and delete it if necessary
   exp_dir="exp/$dir"
   if [ -d "../$exp_dir" ]; then
       echo "../$exp_dir exists, delete."
       rm -R -f "../$exp_dir"
   fi

   if [ "$dir" == "cmvn_mean" ]
   then

   	echo "step2.training mono phone with opt norm-means false..."
	ret2=$(cd ..; steps/train_mono.sh --nj 4 --totgauss $best_gauss --cmvn-opts "--norm-means=false" data/train/ data/lang $exp_dir)
           
   elif [ "$dir" == "cmvn_var" ]
   then
   	echo "step2.training mono phone with opt norm-vars true..."
   	ret2=$(cd ..; steps/train_mono.sh --nj 4 --totgauss $best_gauss --cmvn-opts "--norm-vars=true" data/train/ data/lang $exp_dir)
   
   else #[ "$dir" == "cmvn_reverse" ]
   
    	echo "step2.training mono phone with opt reverse true..."
   	ret2=$(cd ..; steps/train_mono.sh --nj 4 --totgauss $best_gauss --cmvn-opts "--reverse=true" data/train/ data/lang $exp_dir)

   fi

   echo "step3.make graph..."
   ret3=$(cd ..; utils/mkgraph.sh --mono data/lang_test_bg/ $exp_dir $exp_dir/graph)

   echo "step4.decode..."
   ret4=$(cd ..; steps/decode.sh --nj 4 $exp_dir/graph/ data/test $exp_dir/decode_test)
   
   echo "step5.generate WER..."
   ret5=$(cd ..; grep Sum $exp_dir/decode_test/score_*/*.sys | utils/best_wer.sh)
   echo $ret5
done
