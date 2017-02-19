#!/bin/bash

best_gauss=4896

echo "Create a export dir for delta test"
mkdir exp/delta || exit 1

echo "Copying data/train for delta test ..."
cp -rf exp/mono_$best_gauss exp/delta/ali || exit 1

echo "step1.Train delta model and keep the leaf number and gauss number in lab3 ..."
ret1 = $(cd ..; steps/train_deltas.sh 2500 15000 data/train data/lang exp/delta/ali exp/delta/tri1)

echo "step2.Make graph..."
ret2 = $(cd ..; utils/mkgraph.sh --mono data/lang_test_bg exp/delta/tri1 exp/delta/tri1/graph)

echo "step3.decode..."
ret3 = $(cd ..; steps/decode.sh --nj 4 exp/delta/tri1/graph data/test exp/delta/decode_test)

echo "step4.generate WER..."
ret4 = $(cd ..; grep Sum exp/delta/tri1/decode_test/score_*/*.sys | utils/best_wer.sh)

