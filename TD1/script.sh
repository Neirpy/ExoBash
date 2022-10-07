#!/bin/bash
touch score.txt

score=0
find=0

monRandom=${RANDOM:0:2}
echo $monRandom

echo "Le juste nombre sans Vincent Lagaffe"

while [ ${find} -ne 1 ]
do
    echo "Choississez un nombre entre 0 et 99 :"
    read -r nombre
    echo "Vous avez choisi" $nombre

    if [ ${monRandom} -eq ${nombre} ]; 
        then 
            echo "Vous avez trouvé le bon nombre, c'était :" $monRandom
            ((score=score+1))
            echo "Vous avez mis : " $score " coup pour trouver le nombre" 
            ((find=find+1))

    elif [ ${monRandom} -gt ${nombre}  ]; 
        then 
            echo "Le nombre a trouvé est supérieur à :" $nombre
            ((score=score+1))
            echo "Score :"$score

    elif [ ${monRandom} -lt ${nombre} ]; 
        then 
            echo "Le nombre a trouvé est inférieur à :" $nombre
            ((score=score+1))
            echo "Score :"$score
    fi
done

echo "Entrez votre nom :" 
read -r nom

classement=$(tail -n1 score.txt)
lastScore=$(cat -n score.txt | tail -n1 | awk '{print $7}')
scoreExist=$(grep "Score : $score" score.txt)
echo "Le dernier score est de $lastScore"


if [ -z "$classement" ];
then
    echo "Nom : $nom Score : $score" >> score.txt
    echo "Vous êtes : 1er"

elif [ ${score} -ge ${lastScore} ];
    then    
        placement=$(cat -n score.txt| tail -n1 | awk '{print $1}')
        echo "Nom : $nom Score : $score" >> score.txt
        echo "Vous êtes $placement ème"
elif [[ -z "$scoreExist" ]] && [[ ${score} -lt ${lastScore} ]];
    then
        scoreSearch=$score
        placement=$(cat -n score.txt | grep "Score : $scoreSearch" | tail -n1 | awk '{print $1}')
           while [ -z "$placement" ]
            do
                ((scoreSearch=scoreSearch-1))
                placement=$(cat -n score.txt | grep "Score : $scoreSearch" | tail -n1 | awk '{print $1}')
            done
        ((placement=placement+1))
        sed -i ${placement}i"Nom : $nom Score : $score" score.txt
        echo "Vous êtes $placement ème"
else
    placement=$(cat -n score.txt | grep "Score : $score" | tail -n1 | awk '{print $1}')
    ((placement=placement+1))
    sed -i ${placement}i"Nom : $nom Score : $score" score.txt
    echo "Vous êtes $placement ème"
fi



#cat -n score.txt | grep "$nom"