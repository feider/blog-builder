#!/bin/bash

website_prefix=$1
echo "generating blog for "$1
all_entries=`find ./entries -type f | sort -r`
rm -rf generated
mkdir -p generated
rm -rf $website_prefix
ffull="generated/index.html"
echo "
<!DOCTYPE html>
<html lang=\"en\">

<head>
    <meta charset=\"utf-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>
		blahg
    </title>
</head>
<body>" > $ffull

title_old=""
for f in $all_entries
do  
    fnew=${f: 10: -2}"html"
    permalink=$website_prefix"/"$fnew
    fgen="generated/"$fnew
    pthgen="generated/"${f: 10: -6}
	y=${f: 10: -13}
	m=${f: 15: -10}
	d=${f: 18: -7}
	title=$d"."$m"."$y
    mkdir -p $pthgen
    entry=`pandoc $f`
	entry=${entry/"#cb"/"<br>"}
	entryfull="
<p>
<a href=\""$permalink"\">[l]</a>
"${entry: 3: -4}"
</p>"
	
  	#generate single page entry
    echo "
<!DOCTYPE html>
<html lang=\"en\">

<head>
    <meta charset=\"utf-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>
        blahg entry
    </title>
</head>

<body>
<h2>"$title"</h2>
"$entryfull"
</body>
</html>" > $fgen
	
	#generate index page
	# If we have a new day, set a title
	if [[ $title != $title_old ]]
	then
		echo "old title: "$title_old
		echo "new title: "$title
		title_old=$title
		echo "<h2>"$title"</h2>" >> $ffull
	fi
	echo "<div>
"$entryfull"
</div>" >> $ffull
done

echo "</body></html>" >> $ffull
