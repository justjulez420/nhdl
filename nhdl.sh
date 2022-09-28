#!/bin/bash

mkdir images
mkdir doujins

#Downloading HTML
id=$1
curl "https://nhentai.to/g/$id" -o cache.html

#Extracting  Information
page_count=$(grep num_pages cache.html | grep -Eo '[0-9]{1,}')
cdn_id=$(grep galleries cache.html | grep -io 'src=['"'"'"][^"'"'"']*['"'"'"]' | grep -o '".*"' | sed 's/"//g' | grep -Eo '[0-9]{1,}' | grep -m1 "")
cdn_adr=$(grep galleries cache.html | grep -io 'src=['"'"'"][^"'"'"']*['"'"'"]' | grep -o '".*"' | sed 's/"//g'| grep -m1 "" | grep -Eo "(http|https)://[a-zA-Z./?=_%:-]*")
cdn=$(grep galleries cache.html | grep -io 'src=['"'"'"][^"'"'"']*['"'"'"]' | grep -o '".*"' | sed 's/"//g' | sort -u -V | sed 's/https://' | sed 's/t//')
title=$(grep title cache.html | grep -m1 "" | sed 's\<title>\\' | sed 's/»[^$.]*//g' | sed 's/ //g' | tr -d '(){}[]/\|')

#Downloading Pages
echo "Downloading $page_count pages..."
mkdir images/$id
num=0
for link in $cdn
do
	    num=$((num+1))
	    ext=$(echo $link | sed 's/^[^.]*.//' | sed 's/^[^.]*.//' | sed 's/^[^.]*.//')
	    echo "Downloading page $num of $page_count - https:$link"
	    curl "https:$link" -o "images/$id/$id-$num.$ext"
    done

#Converting Images to PDF
cd images/$id
find $id* -print0 | sort -z -V | xargs -0r img2pdf --pagesize A4 -o "$id.pdf"
cd ../..
mv "images/$id/$id.pdf" "doujins/$title.pdf"

#Cleaning up
rm -r images
rm cache.html
