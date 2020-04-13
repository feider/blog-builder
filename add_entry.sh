#!/bin/bash

# put editor here
ED=$EDITOR
# probably could do this with one command and parsing
year=`date +%Y`
month=`date +%m`
day=`date +%d`
entrypath="entries/"$year"/"$month"/"$day

# the filename of the new file, generated from the number of already existing entries
count=$(find $entrypath -type f | wc -l)
let filename=count+1
filename=`printf "%03d" $filename`
filname=$filename".md"

# organizational stuff
rm -rf new_entry
mkdir -p new_entry
touch new_entry/entry.md
$ED new_entry/entry.md
echo "Entry:

#####"
cat new_entry/entry.md
echo "#####
"

while true; do
    read -p "Do you really want to add the entry? y=yes, n=no, e=edit " yn
    case $yn in 
        [Yy]* ) 
            mkdir -p $entrypath
            echo "added to path "$entrypath
            echo "filename is "$filename".md"
            cp new_entry/entry.md $entrypath"/"$filename".md"
            echo "please rebuild"
            exit;;
        [Nn]* )
            echo "aborting"
            echo "aborted"
            exit;;
        [Ee]* )
            $ED new_entry/entry.md
			echo "Entry:

#####"
			cat new_entry/entry.md
			echo "#####
"
    esac
done




