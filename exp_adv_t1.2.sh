#!/bin/bash


#GM_pLeaf_upBound = 20

#word_ins_penalty

declare -a wip_arr=("0.0,0.7,1.0" "0.2,0.5,1.0" "0.0,0.5,0.7" "0.5,0.5,0.5"
                   "1.0,1.0,1.0" "1.0,0.5,1.0" "1.0,1.0,0.5" "0.5,1.0,2.0"
                   "0.0,0.5,2.0" "0.5,0.0,2.0" "0.5,0.7,2.0" )


echo "test different word insertion penalty and explore the impact to WER"


for wip in "${arr[@]}")
do
        echo "----->>> testing ---- word insetion penalty:$wip;  baseline number is lab3 WER result: 46.90<<<-------"

        echo "scoring..."
        ret4=$(cd ..; local/score_words.sh --word_ins_penalty $wip data/test_words exp/word/tri1/graph exp/word/tri1/decode_test)
        echo "$ret4"

        echo "step5.generate WER..."
        ret5=$(cd ..; more exp/word/tri1/decode_test/scoring_kaldi/best_wer)
        echo "$ret5"

done
