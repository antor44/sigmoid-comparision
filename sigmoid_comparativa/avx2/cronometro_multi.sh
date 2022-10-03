#!/bin/bash


	HORAA=$(date +%H)
	MINUTA=$(date +%M)
	HORAA="10#"$HORAA"" #avoid octal value
	MINUTA="10#"$MINUTA""
	HORAA=$((HORAA*1))
	MINUTA=$((MINUTA*1))
    	SEGA=$(date +%S)
	SEGA="10#"$SEGA""
	SEGA=$((SEGA*1))
	TOMA=$((HORAA*60+MINUTA))500000

date

for (( c=1; c<=3; c++ ))
do

./a.out>>output.txt&

done

./a.out>>output.txt

echo
date

	CUC=0
	ACU=0

	HORAB=$(date +%H)
	MINUTB=$(date +%M)
	HORAB="10#"$HORAB"" #avoid octal value
	MINUTB="10#"$MINUTB""
	HORAB=$((HORAB*1))
	MINUTB=$((MINUTB*1))
	SEGB=$(date +%S)
	SEGB="10#"$SEGB""
	SEGB=$((SEGB*1))
	if [ $SEGB -lt $SEGA ]; then
		SEGB=$((SEGB+60))
		MINUTB=$((MINUTB-1))

	fi
	TIME=$((CUC+HORAB*60+MINUTB-TOMA))
	if [ $TIME -lt 0 ]; then
		CUC=1440
		TIME=$((TIME+CUC))
	elif [ $TIME -gt 1440 ]; then
		CUC=0
		ACU=$((ACU+1))
	fi

echo
echo "tiempo [minutos:segundos]= $((TIME+ACU*1440)):$((SEGB-SEGA))"
