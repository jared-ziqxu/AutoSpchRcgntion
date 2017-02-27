#!/bin/bash


echo "------------>>testing gender based model <<-------------"

echo "get female feature speaker list"
ret1=$(cd ..; awk '{if ($2 == "f") { print $1; }}' < data/train/spk2gender > data/train/fspklist)
ret2=$(cd ..; utils/subset_data_dir.sh --spk-list data/train/fspklist data/train data/train_female)

echo "get male feature speaker list"
ret3=$(cd ..; awk '{if ($2 == "m") { print $1; }}' < data/train/spk2gender > data/train/mspklist)
ret4=$(cd ..; utils/subset_data_dir.sh --spk-list data/train/mspklist data/train data/train_male)

echo "training female model ..."
ret5=$(cd ..; steps/train_mono.sh --nj 4 data/train_female data/lang exp/mono_female)

ret6=$(cd ..; utils/mkgraph.sh --mono data/lang_test_bg exp/mono_female exp/mono_female/graph)
ret7=$(cd ..; steps/decode.sh --nj 4 exp/mono_female/graph data/test exp/mono_female/decode_test)
ret8=$(cd ..; grep Sum exp/mono_female/decode_test/score_*/*.sys | utils/best_wer.sh)
echo $ret8

echo "training male model ..."
ret9=$(cd ..; steps/train_mono.sh --nj 4 data/train_male data/lang exp/mono_male)

ret10=$(cd ..; utils/mkgraph.sh --mono data/lang_test_bg exp/mono_male exp/mono_male/graph)
ret11=$(cd ..; steps/decode.sh --nj 4 exp/mono_male/graph data/test exp/mono_male/decode_test)
ret12=$(cd ..; grep Sum exp/mono_male/decode_test/score_*/*.sys | utils/best_wer.sh)
echo $ret12 
