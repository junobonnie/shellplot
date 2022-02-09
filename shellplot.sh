#!/bin/bash

# log function
log() {
        input=$1
        log_result=0
        while :
        do
                input=$(($input/2))
                if [ $input -eq 0 ]; then
                        break
                fi
                log_result=$(($log_result+1))
        done
}
# log function

# develop info
echo "                                                                                                          "
echo "          S H E L L P L O T                                                               "
echo "          Version 1.1    last modified 2022-02-09                 "
echo "                                                                                                          "
echo "          Copyright (C) 2022~                                                             "
echo "          Developed by Replica                                                    "
echo "                                                                                                          "
echo "          My Github Page:     http://github.com/junobonnie"
echo "                                                                                                          "

#get value list
list=${1//,/}

#set y-axis mode (norm or log)
mode=${2:-'norm'}

#find max value
MAX=0
for value in $list
do
        if [ $MAX -ge $value ]; then
                MAX=$MAX
        else
                MAX=$value
        fi
done

if [ $mode == 'log' ]; then
        log $MAX
        MAX=$log_result
fi
#find max value

#draw graph
for height in {50..0}
do
        if [ $(($height%2)) -eq 0 ]; then
                printf "\033[41m%02d\033[0m " $height
        else
                printf "\033[44m%02d\033[0m " $height
        fi
        for value in $list
        do
                if [ $mode == 'log' ]; then
                        log $value
                        value=$log_result
                fi
                if [ $(($value*50/$MAX)) -ge $height ]; then
                        printf "# "
                elif [ $(($value*50/$MAX+1)) -ge $height -a $(($value*50%$MAX*10/$MAX)) -ne 0 ]; then
                        printf "%d " $(($value*50%$MAX*10/$MAX))
                else
                        printf "  "
                fi
        done
        printf "\n"
done
#draw graph

#draw x-axis
if [ $mode == 'log' ]; then
        printf "\033[92mlog\033[0m"
else
        printf "   "
fi
width=0
for value in $list
do
        if [ $(($width%2)) -eq 0 ]; then
                printf "\033[41m%02d\033[0m" $width
        else
                printf "\033[44m%02d\033[0m" $width
        fi
        width=$(($width+1))
done
printf "\n"
#draw x-axis
