#!/bin/bash

set -e
set -x

./jq_all_the_things.sh

diffs=`git status --porcelain | wc -l`

if ! [ $diffs -eq 1 ]; then
	echo "Please make sure you run ./jq_all_the_things.sh before commiting."
	exit 1
fi

for dir in */machinetag.json
do
  echo -n "${dir}: "
  jsonschema -i ${dir} schema.json
  echo ''
done

