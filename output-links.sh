#!/bin/bash
archived=$(cat archived | sort | uniq | wc -l)
unarchived=$(cat unarchived | sort | uniq | wc -l)

echo "<p><b>$archived</b> archived | <b>$unarchived</b> waiting to be archived"
for link in $(ls wiki)
do
	echo "<p><a href=/wiki/$link>$link</a></p>"
done