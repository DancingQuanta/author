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

# Ghostscript functions

pdfjoin() {
# pdfjoin first second > output
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -q -sOUTPUTFILE=/dev/stdout $@
	# gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOUTPUTFILE=${BASH_ARGV[0]} $(
	# for i in $(seq $(expr $# - 1) -1 1) 
	# do  
		# echo -n "${BASH_ARGV[$i]} " 
	# done)
}

pdfextr() {
  # this function uses 3 arguments:
  #     $1 is the first page of the range to extract
  #     $2 is the last page of the range to extract
  #     $3 is the input file
  #     output file will be named "inputfile_pXX-pYY.pdf"
  gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
   -dFirstPage=${1} \
   -dLastPage=${2} \
   -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
   ${3}
}
