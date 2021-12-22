#! /bin/bash

if $1 == 'set'
then
  redshift -O 4500
else
  redshift -x
fi
