#!/bin/bash

files=(/usr/share/cows/*);
baseCmd="fortune  | cowsay"
delay=10

menu(){
for item in "${!avatar[@]}"
do
    echo "$item -> ${avatar[$item]}"
done
}

ex(){
    while true; do
        eval "$@"
        sleep $delay
    done
}

execute(){
if [ "$1" == "random" ]; then
    echo "I execute the command using $1"
    while true; do
        #eval $baseCmd "-f"${files[$((RANDOM%${#files}))]}
        eval "$baseCmd" "-f"${files[RANDOM % ${#files[@]}]}
        sleep $delay
    done
fi
if [ $1 == "cow" ]; then
    echo "I execute the command using $1"
    ex "$baseCmd"
else
    ex "$baseCmd" "'-f$1'"
fi
}

declare -A avatar=( ["1"]="cow" ["2"]="tux" ["3"]="stegosaurus" ["4"]="sheep" ["5"]="elephant" ["6"]="random")
echo "Select your avatar:"
menu
read -r -p "" yn
case $yn in
    [1]* ) execute "${avatar[$yn]}" break;;
    [2]* ) execute "${avatar[$yn]}" break;;
    [3]* ) execute "${avatar[$yn]}" break;;
    [4]* ) execute "${avatar[$yn]}" break;;
    [5]* ) execute "${avatar[$yn]}" break;;
    [6]* ) execute "${avatar[$yn]}" break;;
    * ) echo "Please make your choice!";;
esac


