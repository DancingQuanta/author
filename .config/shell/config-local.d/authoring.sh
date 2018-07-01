#!/usr/bin/env sh
## DancingQuanta/author-config - https://github.com/DancingQuanta/author-config
## authoring.sh
## Shell aliases and functions for text editing and authoring.

# Aliases

alias spell='aspell --lang=en_GB --mode=tex check'

# Functions

# Grep in txt files
gtxt() {
  grep "$1" -r --include="*.txt" .
}

# Search in markdown files
gmd() {
  grep "$1" -r --include="*.md" .
}

# Search in rst files
grst() {
  grep "$1" -r --include="*.rst" .
}

# Grep for unicode
guni() {
  grep '[^\x00-\x7F]' -r --color='auto' -P -n --include="*.md" .
}

# Grep in mm files
gmm() {
  grep "$1" -r --include="*.mm" .
}


gpdf() {
  find . -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep --with-filename --label="{}" --color "'"$@"'"' \;
}

pdfdia() {
find . -name '*.pdf' | while read -r f
	do
	#ERR=
	if $((pdftotext "$f" - > /dev/null) 2>&1) &> /dev/null; then
		echo "$f" was ok;
	else
		mv "$f" "$f.broken";
		echo "$f is broken";   
	fi;
	done
}

# Search and replace in any files, except hidden directories
sr() {
  echo "Replacing $1 with $2"
  find . -type f -not -path '*/\.*' -exec \
    sed -i 's/'$1'/'$2'/g' {} +
}

# Search and replace in markdown files
srmd() {
  echo "Replacing $1 with $2"
  find . -type f -name "*.md" -exec \
    sed -i 's/'$1'/'$2'/g' {} +
}

# List most recently changed markdown files
rmd() {
  find . -type f -name "*.md" -printf '%TY-%Tm-%Td %TT %p\n' | sort -r
}
