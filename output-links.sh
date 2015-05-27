#!/bin/bash
archived=$(cat archived | sort | uniq | wc -l)
unarchived=$(cat unarchived | sort | uniq | wc -l)

echo "<p><b>$archived</b> <a href=/archived>archived</a> | <b>$unarchived</b> <a href=/unarchived>waiting to be archived</a>"
for link in $(ls wiki)
do
	echo "<p><a href=/wiki/$link>$link</a></p>"
done
