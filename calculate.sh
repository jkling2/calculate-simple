#! /bin/bash

programname=$0

function usage {
    echo "usage: $programname -i input numbers [-s solution]"
    echo "  -i      provide input numbers separated by space"
    echo "  -s      provide desired solution"
    exit 1
}

operations=("+-*/")
ans=()
tmp=()
	
makeCombiUtil() {
	k=$2
	
	if [ $k -eq 0 ]
	then 
		ans+=(${tmp[@]})
		return
	fi
	
	local c=1
	for (( c; c<=$1; c++ ))
	do 
		tmp+=($c)
		makeCombiUtil $1 $(($k-1))
		k=$(($k+1))
		unset tmp[${#tmp[@]}-1]
	done
}

while getopts 'i:s:' flag
do
    case $flag in
        s) solution=$OPTARG;;
		i) numbers=("$OPTARG")
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                numbers+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
    esac
done

if [ -z $numbers ]
then
	usage
fi

amount_operations_needed=$((${#numbers[@]}-1))

if [ $amount_operations_needed -lt 1 ]
then
	echo "not enough numbers provided"
	usage
fi

amount_operations=$((${#operations}))

makeCombiUtil $amount_operations $amount_operations_needed

for ((step=0; step<${#ans[@]}; step+=k))
do
	operations_local=""
	for ((i=step; i<step+k; i++))
	do
		operations_local+="${operations:$((${ans[i]}-1)):1}"
	done
	
	for ((c=0; c<${#operations_local}; c++))
	do
		if [ "${operations_local:c:1}" == "/" ]
		then
			check_division=$(( ${numbers[$c]} % ${numbers[$(($c+1))]} ))
			if [ ! $check_division -eq 0 ]
			then
				continue 2
			fi
		fi
	done
	
	calc_local=()
	for ((j=0; j<${#numbers[@]}; j++))
	do
		calc_local+=(${numbers[j]})
		calc_local+=("${operations_local:j:1}")
	done
	
	local_sol=$((${calc_local[@]}))
	if [ -z "$solution" ] || [ $solution -eq $local_sol ]
	then
		echo "${calc_local[@]} = $local_sol"
		found_solution=true
	fi
done

if [ -z "$found_solution" ]
	then
		echo "solution $solution cannot be calculated from ${numbers[@]}"
fi

