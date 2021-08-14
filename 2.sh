#!/bin/bash

# Lonely Integer - Bash!
# https://www.hackerrank.com/challenges/lonely-integer-2/problem

read n
read line

seta=()
printf -v num '%d\n' $n 2>/dev/null

echo $line | tr -s ' ' '\n' | while read __in; do
        let found=0

        for ((i = 0; i < ${#seta[@]}; i++)) 
        do
                if [ ${seta[$i]} == $__in ]; then
                        unset seta[$i]

                        # Delete fully
                        setb=()
                        for j in ${!seta[@]}; do
                            setb+=(${seta[$j]})
                        done
                        seta=(${setb[@]})
                        unset setb

                        let found=1
                        break
                fi
        done

        if [ $found -eq 0 ]; then
                seta[${#seta[@]}]=$__in
        fi      

        # let num=$num-1 doesn't work
        printf -v num '%d\n' $((num - 1)) 2>/dev/null

        if [ $num -eq 0 ]; then
                echo ${seta[@]}
                break
        fi
done
