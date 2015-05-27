#!/bin/bash

############################
# Wikipedia Scraper/Mirror #
############################

#Initialize by running:
# wikiscrape -i
#Or
# wikiscrape [NAME_OF_ARTICLE]

#Then run: 
# wikiscrape -p 
#to pull wikipedia articles from the unarchived links that get collect

#Create local in users home folder
#Initialize empty files
SCRAPE_DIR="$HOME/wikiscrape/"
mkdir -p $SCRAPE_DIR/wiki
touch $SCRAPE_DIR/archived
touch $SCRAPE_DIR/unarchived

#Move into working folder
cd $SCRAPE_DIR

#Function to download and extract an article, and add any found articles
#to the unarchived list
function getLinks(){

	#Check for only one URL being providied
	if [ $# -ne 1 ]
		then
		echo "[$0]>[getLinks] Expects 1 url, got $#"
		exit 1
	else
		#Check if the article we're trying to get has already been archived...
		exists=$(cat archived | grep $1 | wc -l)

		#If it has not been archived...or if there are no sexists :P
		if [ $exists == 0 ]
			then

			echo "[$0]> Retrieving: $1" >> /dev/stderr
			ART_DIR=$SCRAPE_DIR/wiki/$1
			mkdir -p $ART_DIR
			touch $ART_DIR/index.html
			touch $ART_DIR/links

			thisPage=$(curl -s -A Mozilla  http://en.wikipedia.org/wiki/$1 | hxselect p)
			newLinks=$(echo $thisPage | grep " <a href=\"[-A-Za-z0-9 _/]*\" " -o | grep "/wiki/[-A-Za-z0-9_]*" -o | sed s/"^\/wiki\/"//g)
			
			echo "[$0]> [$1]> Found $numLinks links" >> /dev/stderr

			echo "Retrieved: $(date)" > $ART_DIR/index.html
			echo "<form action=/report.php method=post>" >> $ART_DIR/index.html
			echo "<input name=\"report\" type=\"submit\" value=\"Report Error\">" >> $ART_DIR/index.html
			echo "</form>" >> $ART_DIR/index.html
			echo $thisPage >> $ART_DIR/index.html

			for link in $(echo $newLinks)
			do
				if [ "$link" != "$1" ]
					then
					echo "Adding $link to unarchived file" >> /dev/stderr
					echo "$link" >> unarchived

					echo "Adding $link to $1's link file" >> /dev/stderr
					echo "$link" >> $ART_DIR/links
				else
					echo "$link does not need to be archived" >> /dev/stderr
				fi
			done

			numLinks="$(cat $ART_DIR/links | wc -l)"
			echo "[$0]> [$1]> Found $numLinks links"

			#Mark this article as archived
			echo $1 >> archived

		#otherwise...
		else
			#Don't do anything
			echo "[$0] $1 exists, and was not archived" >> /dev/stderr
		fi
	fi
}

#Archive articles from the unarchived file
function pullUnarchived(){

	#For each link in the unrchived file
	links=$(cat unarchived)
	for link in $(echo $links)
	do
		#Archive them
		getLinks $link
	done
	
	echo "Cleaning up"
	cat unarchived | sort | uniq > unarchived.tmp
	cat unarchived.tmp > unarchived

	cat archived | sort | uniq > archived.tmp
	cat archived.tmp > archived	
	echo "$(wc -l unarchived) new links found"
	echo "$(wc -l archived) archived"
}

#Simple flow control
if [ "$1" == "-p" ]
	then
		echo "Pulling unarchived"
		pullUnarchived
elif [ "$1" == "-i" ]
 	then
 	echo "Starting automatic pull with \"Seed\""
	getLinks "Seed"
	pullUnarchived

elif [ "$1" == "-s" ]
	then
	echo "Seeding from $2"
	getLinks "$2"
	pullUnarchived
else
	echo "Invalid usage!"
	echo "Usage: $0 [OPTIONS] [SEED]"
	echo -e "Examples:\n"
	echo "Initialize with default seed"
	echo -e "\t$0 -i\n"
	echo "Initialize with [SEED]"
	echo -e "\t$0 -s [SEED]\n"
	echo "Begin archiving articles"
	echo -e "\t$0 -p\n"
fi