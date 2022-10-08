#!/usr/bin/env bash

battery=$(sudo tlp-stat -b | tac | grep -m 1 "Charge" |  tr -d -c "[:digit:],.")

prefix=
if (( $(echo "$battery < 15.0" | bc -l) )); then
  prefix=""
elif (( $(echo "$battery < 33.3" | bc -l) )); then
  prefix=""
elif (( $(echo "$battery < 50.0" | bc -l) )); then
  prefix=""
elif (( $(echo "$battery < 75.0" | bc -l) )); then
  prefix=""
else
  prefix=""
fi

echo "$prefix $battery%"

