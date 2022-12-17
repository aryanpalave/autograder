#!/bin/bash

echo "Autograding CSE 391 Homework"
if [ $# -eq 0 ]
then        
	echo "Usage: ./autograder.sh MAXPOINTS"        
else
        echo "Grading with a max score of $1"
	echo
        cd students          
        for file in $(ls); do
                filename=$file
		cd $file
		echo "Processing $filename ..."
                if  [ -f "task1.sh" ]; then
                	filename=$file
                        bash task1.sh > output.txt
                        diffcount=$(diff -w ../../expected.txt output.txt | grep -Ec "<|>")
                        if [ $diffcount -eq 0 ]; then
                                echo "$filename has correct output"
                        else
                                echo "$filename has incorrect output (${diffcount} lines do not match)"
                        fi
                        let points="$1 - ($diffcount * 5)"
                        if [ $points -lt 0 ]; then
                                points=0
                        fi 
                        echo "$filename has earned a score of $points / 50"        
                else
			
			echo "$filename did not turn in the assignment"
			echo "$filename has earned a score of 0 / 50"
                fi
		cd ..
		echo
        done
fi
