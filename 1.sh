#!/bin/bash
# Functions and Fractals - Recursive Trees - Bash
# https://www.hackerrank.com/challenges/fractal-trees-all/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

mi()
{
	## Too slow
	#[[ $1 -lt 2 ]] && echo $2
	#
	#mi $(($1/2)) $(($2+1))

	if [ $1 -lt 2 ]; then
		echo 0
	elif [[ $1 -ge 2 && $1 -lt 4 ]]; then
		echo 1
	elif [[ $1 -ge 4 && $1 -lt 8 ]]; then 
		echo 2
	elif [[ $1 -ge 8 && $1 -lt 16 ]]; then
		echo 3
	elif [[ $1 -ge 16 && $1 -lt 32 ]]; then
		echo 4
	else
		echo 5
	fi
}

print_1row()
{
	let r_cur=$1
	let n=$(mi $r_cur)
	let r_pre=$((2**$n))
	let r_half=$(((2**$n+2**($n+1))/2))
	let tmp=0

	set1=()

	for ((i = 1; i < $n; i++))
	do
		tmp=$((tmp+2**(i-1)))
	done

	if [ $r_cur -lt $r_half ]; then
		let c_start=$((tmp+18+r_cur-r_pre))
		let width_of_y=$((2**n-1))
		let width_between_y=$((2**n-1))
		let steps_in_y=$((width_of_y-(r_cur-r_pre)*2))
		let steps_between_y=$((width_between_y+(r_cur-r_pre)*2))
		let n_col=$((2**(6-n)))

		if [ $((c_start+width_between_y+width_of_y*2)) -gt 100 ]; then
			let width_between_y=0
			let steps_between_y=0
		fi

		#echo $steps_in_y " _ " $steps_between_y " _ " $r_cur

		for ((i=0; i < n_col; i++))
		do
			let tmp=$((c_start+i+(i/2)*(steps_in_y+steps_between_y)+(i%2)*steps_in_y))
			set1+=($tmp)
		done 
	else
		let c_start=$((tmp+18+r_half-r_pre))
		let width_between_1=$((2**(n+1)-1))
		let n_col=$((2**(5-n)))

		if [ $((c_start+width_between_y+width_of_y*2)) -gt 100 ]; then
			let width_between_1=0
		fi

		#echo $width_between_1 " _ " $r_cur

		for ((i=0; i < n_col; i++))
		do
			let tmp=$((c_start+i*width_between_1+i))
			set1+=($tmp)
		done
	fi

	output=""

	for ((j = 0; j < 100; j++))
	do 
		c="_"

		for i in "${set1[@]}"
		do
			if [ $i -eq $j ]; then
				c="1"
				break
			fi
		done

		output+=$c

	done

	echo $output
}

print_tree()
{
	[[ $1 -gt 5 ]] && return

	let rstart=2**$((6-${1}))

	for i in {1..63}
	do
		if [ $i -lt $rstart ]; then
			printf '_%.0s' {1..100}
			echo
		else
			print_1row $i
		fi
	done
}

read n
print_tree $n

