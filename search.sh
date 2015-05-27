#!/bin/bash

for query in $@
do
	echo "<p>"
	echo "Strong Matches:"
	for found in $(ls wiki | tr "[:upper:]" "[:lower:]" | grep "$query")
	do
		echo "<li><a href=/wiki/$found>$found</a></li>"
	done
	echo "</p>"

	echo "<p>"
	echo "Weak Matches:"
	for link in $(find | grep "links")
	do
		num=$(cat "$link"  | tr "[:upper:]" "[:lower:]" | grep "$query" | wc -l)

		if [ $num -gt 0 ]
			then
			name=$(echo $link | sed s/"^.\/wiki\/"//g | sed s/"\/links$"//g)
			echo "<li><a href=/wiki/$name>$name</a></li>"
		fi
	done
	echo "</p>"
done


