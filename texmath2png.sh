#!/bin/bash

###################################################################
#	By
#			 ___                  _  __    _ _
#			|   \ ___ _  _ __ _  | |/ /___| | |___ _ _
#			| |) / _ \ || / _` | | ' </ -_) | / -_) '_|
#			|___/\___/\_,_\__, | |_|\_\___|_|_\___|_|
#			              |___/
#			
#		If you use my work, please give credit. Cheers!
###################################################################

# variables and defaults
temp_tex=/tmp/texmath.tex
temp_png=/tmp/texmath.png
density=2000

# help display
usage(){
cat <<USAGE
usage: math2png [-i input] [-o output]
USAGE
}

# argument parser
while [ "$1" != "" ]; do
    case $1 in 
        -i | --input )
            shift
            input="$1"
            ;;
        -o | --output )
            shift
            output="$1"
            ;;
        -d | --density )
            shift
            density="$1"
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

#here-doc to simplify math tex input
(
cat <<HERE
\documentclass{minimal}
\usepackage{xcolor}
\begin{document}
$(cat $input)
\end{document}
HERE
) > $temp_tex

# converting the tex to png
latex2png -d $density -c $temp_tex

# removing the background from the png
convert $temp_png -transparent white $output
