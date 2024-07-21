#!/bin/bash

for THISFILE in *
do
  filename=${THISFILE%\.*}
  extension=${THISFILE##*\.}
  newname=${filename//./_}
  echo "mv $THISFILE ${newname}.${extension}"
  #mv $THISFILE ${newname}.${extension}
done
