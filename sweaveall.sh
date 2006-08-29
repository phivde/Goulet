#! /bin/bash

ROPTIONS="--no-save --no-restore --quiet"

for file in `ls *.Rnw`
do
  echo "Sweave(\"$file\")" | R $ROPTIONS
done

