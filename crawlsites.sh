#!/bin/bash
cd /opt/nutch
echo "clearing previous crawl data."
rm -rf crawl/
echo "Creating segment list file."
mkdir crawl
# touch crawl/segmentlist
# echo 'injecting urls ...'
# bin/nutch inject crawl/crawldb urls

# # repeatedly get segments until there aren't any
# echo "Checking for segments..."
# segmentReturnValue=0
# while [ $segmentReturnValue -eq 0 ]
# do
#     bin/nutch generate crawl/crawldb crawl/segments
#     segmentList=`ls -dt crawl/segments/2* | head -1`
#     echo "Comparing $segmentList to segmentlist.txt"
#     grep -R "$segmentList" crawl/segmentlist && segmentReturnValue=-1 && echo "Items match." && break
#     echo "Not equal."

#     if [ $segmentReturnValue -ne 0 ]
#     then
#         echo "No segments found. Exiting."
#         break
#     else
#         echo "Adding $segmentList to the file."
#         echo $segmentList >> crawl/segmentlist
#         echo "STEP 1: Segments retrieved: $segmentList. Fetching."
#         bin/nutch fetch $segmentList
#         echo "STEP 2: Beginning parse of $segmentList."
#         bin/nutch parse $segmentList
#         echo "STEP 3: Updating crawldb with $segmentList."
#         bin/nutch updatedb crawl/crawldb $segmentList
#     fi
# done

# bin/nutch invertlinks crawl/linkdb -dir crawl/segments

# segmentFile=`cat crawl/segmentlist`
# for line in $segmentFile
# do
#     bin/nutch index crawl/crawldb/ -linkdb crawl/linkdb/ $line -filter -normalize -deleteGone
# done
bin/crawl -i -s urls/ crawl/ 1


exec "$@"