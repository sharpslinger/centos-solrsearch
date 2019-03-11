#!/bin/bash
cd /opt/nutch
echo "clearing previous crawl data."
rm -rf crawl/
echo "Creating segment list file."
mkdir crawl
numPasses=3
echo "Crawling.  Number of passes: ${numPasses}"
bin/crawl -i -s urls/ crawl/ ${numPasses}