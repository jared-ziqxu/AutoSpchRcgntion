#!/bin/bash



for ((leaf=500 ; leaf <= 5000 ; leaf+=50))
do
   for ((gauss=$leaf ; gauss <= $(($leaf * $GM_pLeaf_upBound)) ; gauss+=$leaf))
   do
        echo "----->>> testing: leaf: $leaf, gauss number: $gauss <<<-------"

   done
done
