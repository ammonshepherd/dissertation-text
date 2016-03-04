#!/usr/bin/env bash

if [[ $1 ]]; then
  folders=( $1 )
else
  folders=(introduction chapter1 chapter2 chapter3 chapter4 chapter5 conclusion)
fi

for folder in ${folders[@]}; do
  cd ${folder}
  echo "Making ${folder}.md file"
  pandoc --smart --extract-media=files --atx-headers --normalize --toc -f docx -t markdown_github ${folder}-citations.docx -o ${folder}.md  

  echo "Making ${folder}.html file"
  pandoc --smart --extract-media=files --ascii --html-q-tags --section-divs --normalize --toc --atx-headers -f docx -t html5 ${folder}-citations.docx -o ${folder}.html

  cd ../
   echo
   echo
done
