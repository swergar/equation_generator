

cd $(dirname $0)

N=0
NEWLINE=0
MAX=300

echo > questions.txt
echo > answers.txt

is_newline_or_end() {

  N=$(echo $N + 1 | bc )
  if [ $N -gt $MAX ] ; then
    echo DONE, exit.
	exit 0
  fi

  NEWLINE=$(echo $NEWLINE + 1 | bc )
  if [ $NEWLINE -gt 2 ] ; then
	echo | tee -a questions.txt
	echo | tee -a questions.txt
	echo >> answers.txt
	NEWLINE=0
  fi

}

rand_gen() {

	X=$(echo $RANDOM| cut -c 2-3)
    case $X in
       (*[!0-9]*|'') X=10
    esac

	B=$(echo $RANDOM| cut -c 2)
    case $B in
       (*[!0-9]*|'') B=1
    esac

	P=$(echo $RANDOM| cut -c 2)
    case $P in
       (*[!0-9]*|'') P=1
    esac

	Q=$(echo $RANDOM| cut -c 2)
    case $Q in
       (*[!0-9]*|'') Q=1
    esac

	A=$(echo $RANDOM| cut -c 2)
    case $A in
       (*[!0-9]*|'') A=1
    esac

    Y=$(echo "$P + $Q + $A + 1" | bc)
	X=$(echo "$X + $B + 1" | bc)
	Z=$(echo $X % $Y | bc)
	Q=$(echo $X % $Y)
    R=$(echo $X / $Y | bc)

}


while :; do 

  rand_gen
  if [ "$Z" -eq 0 ] ; then 
	echo -ne "#$N: $X ÷ $Y = _____   \t" |  tee -a questions.txt
	echo -ne "#$N: $X ÷ $Y = $R \t" >> answers.txt
	is_newline_or_end
  fi

  rand_gen
  if [ "$Z" -eq 0 ] ; then 
    echo -ne "#$N: $X ÷ ____ = $R   \t" |  tee -a questions.txt
    echo -ne "#$N: $X ÷ $Y = $R \t" >> answers.txt
	is_newline_or_end
  fi

  rand_gen
  if [ "$Z" -eq 0 ] ; then 
    echo -ne "#$N: $R x $Y = ____   \t" |  tee -a questions.txt
    echo -ne "#$N: $R x $Y = $X \t" >> answers.txt
	is_newline_or_end
  fi

  rand_gen
  if [ "$Z" -eq 0 ] ; then 
    echo -ne "#$N: $R x ____ = $X   \t" |  tee -a questions.txt
    echo -ne "#$N: $R x $Y = $X \t" >> answers.txt
	is_newline_or_end
  fi

done 



