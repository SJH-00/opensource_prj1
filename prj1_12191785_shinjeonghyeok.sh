#! /bin/bash
echo --------------------------
echo "User Name: $(whoami)"
echo "Student Number: 12191785"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific
'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item’"
echo "3. Get the average 'rating’ of the movie identified by
specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item"
echo "5. Get the data about users from 'u.user’"
echo "6. Modify the format of 'release date' in 'u.item’"
echo "7. Get the data of movies rated by a specific 'user id'
from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with
'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo --------------------------

stop="N"
until [ $stop = "Y" ]
do
	read -p "Enter your choice [ 1-9 ] " choice
	case $choice in
		1)
			read -p "Please enter 'movie id'(1~1682) :" m_id
			cat $1 | awk -F\| -v mid=$m_id '$1==mid {print $0}'
			echo
			;;
		2)
			read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) :" ans
			if [ $ans="y" ]
			then
				cat $1 | awk -F\| '$7=="1" {print $1, $2}' | head -n 10
			fi
			echo
			;;
		3)
			read -p "Please enter 'movie id'(1~1682) :" m_id	
			result=$(cat $2 | awk -v mid=$m_id '$2==mid {sum+=$3; cnt+=1} END {print sum/cnt}')
			echo "average rating of $m_id: $(echo $result | awk '{printf "%.5f", $1}')"
			echo 
			;;
		4)
			read -p "Do you want to delete the 'IMDb URL'from 'u.item'?(y/n) :" ans
			if [ $ans='y' ]
			then
				cat $1 | sed 's/|http[^|]*|/||/g' | head -n 10
			fi
			echo
			;;
		5)
			read -p "Do you want to get the data about users from 'u.user'?(y/n) :" ans
			if [ $ans='y' ]
			then
				cat $3 | sed -E 's/([0-9]+)\|([^|]*)\|([^|]*)\|([^|]*)(.*)/user \1 is \2 years old \3 \4/' | head -n 10
			fi
			echo
			;;
		6)
			read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n) :" ans
			if [ $ans='y' ]
			then
				cat $1 | sed -E -e 's/\|([0-9]{2})\-([^-]*)\-([0-9]{4})\|/|\3\2\1|/' -e 's/Jan/01/' -e 's/Feb/02/' -e 's/Mar/03/' -e 's/Apr/04/' -e 's/May/05/' -e 's/Jun/06/' -e 's/Jul/07/' -e 's/Aug/08/' -e 's/Sep/09/' -e 's/Oct/10/' -e 's/Nov/11/' -e 's/Dec/12/'| tail -n 10
			fi
			echo
			;;
		7)
			read -p "Please enter the 'user id' (1~943) :" ans
			touch file1
			touch file2
			cat $2 | awk -v uid=$ans '$1==uid {print $2}' | sort -g > file1
			cat file1 | awk '{if(NR==1) {printf "%d", $1} else {printf "|%d", $1}}'
			echo
			echo
			cat $1 | awk -F\| '{print $1, $2}' > file2
			
			awk 'FNR==NR {a[$1] = $0; next} $1 in a {print a[$1]}' file2 file1 | sed -E 's/([0-9]+)(\s)(.*)/\1|\3/' | head -n 10
			echo
			;;
		8)
			read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n) :" ans
			
			;;
		9)
			echo "Bye!"
			stop="Y"
			;;
	esac
done
