#/bin/bash
num1=$1
num2=$2
sum=0
answer=1
if [ $# -ne 2 ]
then
	echo "Χρειάζονται 2 ορίσματα"
	exit 1
fi


while [ $answer -ne 6 ]
do
read -p "Δώσε όνομα καταλόγου: " cat
while [ ! -d $cat ]
do

        echo "To $cat δεν είναι κατάλογος."
        read -p "Δώστε όνομα καταλόγου: " cat
done
read -p "Αν θες να τερματίσει το πρόγραμμα πάτα 6: " answer
    #menu
	echo "1.Εμφανίστε τα αρχεία του καταλόγου $cat με permissions τον αριθμό $num1 θεωρώντας τον ως οκταδικό ισοδύναμο."
        find ./$cat -perm $num1 
        echo " "
	echo "2.Εμφανίστε τα αρχεία του καταλόγου $cat που άλλαξαν περιεχόμενα κατά τις $num2 τελευταίες μέρες."
        find $cat -type f -mtime -$num2 
         echo " "
	echo "3.Εμφανίστε τους υποκαταλόγους του καταλόγου $cat που προσπελάστηκαν κατά τις $num2 τελευταίες μέρες."
        find $cat -type d -atime -$num2 
        echo " "
	echo "4.Εμφανίστε τα αρχεία του καταλόγου $cat στα οποία έχουν δικαίωμα ανάγνωσης όλοι οι χρήστες."
        ls -l $cat | grep "^-r[-,w][-,x]r[-,w][-,x]r[-,w][-,x]" 
        echo " " 
	echo "5.Εμφανίστε τους υποκαταλόγους του καταλόγου $cat στους οποίους έχουν δικαίωμα αλλαγών εκτός από τον ιδιοκτήτη και άλλοι χρήστες του συστήματος."
        ls -l $cat | grep "^d[-,r]w[-,x][-,r]w[-,x][-,r]w[-,x]" 
        echo " " 
        
        sum=`expr $sum + 1`
        echo "Αριθμός καταλόγου: $sum."
done 
