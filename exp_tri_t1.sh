#!/bin/bash


#GM_pLeaf_upBound = 20

for ((leaf=1350 ; leaf <= 5000 ; leaf+=150))
do
   for ((gauss=$leaf*5 ; gauss <= $(($leaf * 20)) ; gauss+=$leaf))
     do
        echo "----->>> testing ---- leaf: $leaf, gauss number: $gauss <<<-------"
        exp_dir="exp/word/tri_$gauss.$leaf"
        if [ -d "../$exp_dir" ]; then
           echo "../$exp_dir exists, delete."
           rm -R -f "../$exp_dir"
        fi
	SECONDS=0
        echo "step1.train triphone model ..."
        ret1=$(cd ..; steps/train_deltas.sh $leaf $gauss data/train_words data/lang_wsj exp/word/mono_ali $exp_dir)
        duration=$SECONDS
        echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds for training with leaf: $leaf, gauss: $gauss. total: $duration seconds." 

	SECONDS=0
        echo "step2.make graph..."
        ret2=$(cd ..; utils/mkgraph.sh data/lang_wsj_test_bg $exp_dir $exp_dir/graph)
        
        echo "step3.decode..."
        ret3=$(cd ..; steps/decode.sh --nj 4 $exp_dir/graph data/test_words $exp_dir/decode_test)
       
        duration=$SECONDS
        echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds for decoding with leaf: $leaf, gauss: $gauss. total: $duration seconds." 


        echo "step4.scoring..."
        ret4=$(cd ..; local/score_words.sh data/test_words $exp_dir/graph $exp_dir/decode_test)
        echo "$ret4"

        echo "step5.generate WER..."
        ret5=$(cd ..; head -5 $exp_dir/decode_test/scoring_kaldi/best_wer)
        echo "$ret5"

        if [ -d "../$exp_dir" ]; then
           echo "---->>> finishing test cycle, delete $exp_dir..."
           rm -R -f "../$exp_dir"
        fi
 
     done
done
