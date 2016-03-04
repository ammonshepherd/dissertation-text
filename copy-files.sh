#!/usr/bin/env bash

date=`date +"%Y-%m-%d"`
folders=(introduction chapter1 chapter2 chapter3 chapter4 chapter5 conclusion)

order=0
for folder in ${folders[@]}; do
  echo Updating $folder

  # copy the Markdown file
  cp ${folder}/${folder}.md  ../dissertation/${folder}/

  # Overwrite the existing HTML file with just the YAML front matter
  # get the title and subtitle from the first line
  title=$(grep -m 1 ":" ${folder}/${folder}.html | cut -d":" -f1 | cut -d">" -f5)
  subtitle=$(grep -m 1 ":" ${folder}/${folder}.html | cut -d":" -f2 | cut -d"<" -f1)

  echo '---
layout: page
title: '${title}'
sub-title:'${subtitle}'
date: '${date}'
type: chapter
order: '${order}'
---
' > ../dissertation/${folder}.html

  # remove the first line in the HTML file and copy the rest
  # hat tip: http://unix.stackexchange.com/questions/96226/delete-first-line-of-a-file
  sed '1d' ${folder}/${folder}.html >> ../dissertation/${folder}.html

  # copy the images, if any
  rsync -aRvz --delete-after  ${folder}/files/media/* ../dissertation/
  echo
  echo

  # increment the order value
  ((order++))
done
