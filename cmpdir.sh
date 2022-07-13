#! /bin/bash
kat1=$1 #1ος κατάλογος
kat2=$2 #2ος κατάλογος
kat3=$3 #3ος κατάλογος για μεταφορά κοινών αρχείων

if [ ! -d $kat1 ] || [ ! -d $kat2 ] || [ ! -d $kat3 ]
then
 echo "Όλα τα ορίσματα πρέπει να είναι κατάλογοι."
 exit 1
fi
list1=` find $kat1 -maxdepth 1 -type f -exec basename {} \; `
list2=` find $kat2 -maxdepth 1 -type f -exec basename {} \; `
sum=0
for file1 in $list1
do
	size1=`stat -c %s $kat1/${file1}`
	found=0
	for file2 in $list2
	do
		size2=`stat -c %s $kat2/${file2}`
		if [ $file1 == $file2 ] && [ $size1 -eq $size2 ]
		then
			found=1
			break
		fi

	done
	if [ $found == 0 ]
	then
		echo "Το αρχείο $file1 του καταλόγου $kat1 δεν υπάρχει στον κατάλογο $kat2"
		((sum +=$size1))
	fi

done

sum=0
for file2 in $list2
do
        size2=`stat -c %s $kat2/${file2}`
        found=0
        for file1 in $list1
        do
                size1=`stat -c %s $kat1/${file1}`
                if [ $file2 == $file1 ] && [ $size2 -eq $size1 ]
                then
                        found=1
                        break
                fi

        done
        if [ $found == 0 ]
        then
                echo "Το αρχείο $file2 του καταλόγου $kat2 δεν υπάρχει στον κατάλογο $kat1."
                ((sum +=$size2))
        fi

done
sum=0
for file1 in $list1
do
	size1=`stat -c %s $kat1/${file1}`
        found=0
        for file2 in $list2
        do
                size2=`stat -c %s $kat2/${file2}`
                if [ $file1 == $file2 ] && [ $size1 -eq $size2 ]
                then
                          echo "Το αρχείο $file1 του καταλόγου $kat1 υπάρχει στoν κατάλογο $kat2 και έχει μέγεθος $size1"
			  ((sum +=$size1))
			  mv $kat1/${file1} $kat3
                           echo "Το αρχείο $file1 μεταφέρθηκε στον κατάλογο $kat3"
			  mv $kat2/${file2} $kat3
			    echo "Το αρχείο $file2 μεταφέρθηκε στον κατάλογο $kat3"
			  ln $kat3/$file1 $kat1/${file1}link
			  ln $kat3/$file2 $kat2/${file2}link

                          break
                  fi
          done
 done
