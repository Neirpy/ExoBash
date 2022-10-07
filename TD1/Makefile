run:
	./script.sh

scores:
	cat -n score.txt

reset-scores:
	>score.txt

score-by:
	read -r joueur
	recherche=cat-n score.txt| grep "${joueur}"
	if [-z "$recherche"];
	then
		echo "Ce joueur n'existe pas"
	else
		echo ${recherche}
	fi