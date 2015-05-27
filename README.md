# Tony's Wikipedia Scraper/Mirror

This uses a single BASH script to download and extract content from wikipedia articles.

It starts with a single article as its "seed" page. It downloads the webpage, extracts the article text and creates a local copy with a few HTML tags added. It then extracts any links to other wiki articles within the article and adds them to its 'unarchived' list.

Once it has a base list you can run it 'pull mode' to iterate through the 'unarchived' list doing the same as above.

It should theorhetically create a local copy of wikipedia, eventually.

##Installation
	```
	git clone https://github.com/mynameistony/wikiscrape.git
	
	mv /path/to/wikiscrape/ $HOME/

	#Then initialize with "seed" page
	./wikiscrape.sh -i

	#Then run this occasionally (perhaps as a cronjob):
	./wikiscrape.sh -p

	```

	You should also configure your web server to serve the folder for a minimal web interface.

###Notes

"Pull mode" may take awhile :)

Make sure the wikiscrape folder is in your home folder, otherwise modify wikiscrape.sh to point to it's actual location

Feel free to modify it and make it better, it's still a work in progress.