#!/bin/bash

best_gauss=4896

echo "Copying data/train for plp usage ..."
cp -r data/train data/train_plp || exit 1
echo "Copying data/test for plp usage ..."
cp -r data/test data/test_plp || exit 1

echo "step1.create plp features..."
for train_plp test_plp; do 
    ret1=$(cd ..; steps/make_plp.sh data/$dir exp/make_plp/$dir plp)
done

echo "step2.training mono phone based on plp feature..."
ret2=$(cd ..; steps/train_mono.sh --nj 4 --totgauss $best_gauss data/train_plp/ data/lang exp/plp)
echo "step3.make graph..."
ret3=$(cd ..; utils/mkgraph.sh --mono data/lang_test_bg/ exp/plp/ exp/plp/graph)
echo "step4.decode..."
ret4=$(cd ..; steps/decode.sh --nj 4 exp/plp/graph/ data/test exp/plp/decode_test)
echo "step5.generate WER..."
ret5=$(cd ..; grep Sum exp/mono/decode_test/score_*/*.sys | utils/best_wer.sh)
