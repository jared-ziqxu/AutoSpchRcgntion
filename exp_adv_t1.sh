#!/bin/bash


#GM_pLeaf_upBound = 20

echo "test different lmwt parameters and explore the impact to WER"


for ((min=1 ; min <= 200 ; min+=5))
do
   for ((max=min ; max <= $(($min * 20)) ; max+=$min))
     do
        echo "----->>> testing ---- min_lmwt: $min, max_lmwt: $max  baseline number is lab3 WER result: 46.90<<<-------"

        echo "scoring..."
        ret4=$(cd ..; local/score_words.sh --min_lmwt $min --max_lmwt $max data/test_words exp/word/tri1/graph exp/word/tri1/decode_test)
        echo "$ret4"

        echo "step5.generate WER..."
        ret5=$(cd ..; more exp/word/tri1/decode_test/scoring_kaldi/best_wer)
        echo "$ret5"

     done
done
