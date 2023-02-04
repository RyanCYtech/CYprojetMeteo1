CY-METEO est un programme conçu pour produire des graphiques à partir de mesures météorologiques, telles que la température, la pression, le vent, la hauteur, l'humidité, dans les régions françaises du monde. Il a été créé en C et en shell script. Ce que nous avons utilisé pour faire des graphiques est GNUPLOT.

Le programme attend une commande de l'utilisateur pour commencer à filtrer les données d'un fichier météorologique. En utilisant des fonctions C, il trie ensuite les données de manières spécifiques pour permettre à gnuplot de produire les graphiques. Les données peuvent être filtrées en fonction du temps et des régions, et l'ordre des tri peut être inversé. Trois modes de tri sont également disponibles.

Pour utiliser CY-METEO, téléchargez nos fichiers depuis ce dépôt sur votre ordinateur et placez-les dans un répertoire de votre choix. Dans votre terminal, entrez ce répertoire. Mettez votre fichier de données dans ./C/data/ (ou utilisez celui que nous fournissons sur ce dépôt, meteo_short.csv). Utilisez la commande "bash script.sh" avec les options de votre choix pour commencer à créer des graphiques ! Attention : certaines options doivent être utilisées. Si vous avez des questions sur la façon d'utiliser CY-METEO, utilisez la commande suivante : "bash script.sh --help".

Si vous avez choisi plusieurs options, vous pourrez voir les graphiques un par un. Pour passer au suivant, fermez simplement la fenêtre gnuplot actuelle. Tapez "make clean" dans votre terminal pour supprimer tous nos fichiers exécutables / objets si vous ne les voulez pas.

Amusez-vous bien !

La liste des options est disponible dans la description précédente. Veuillez noter que :

L'utilisation de -f est obligatoire pour permettre au programme d'obtenir le chemin du fichier de données.
L'utilisation d'au moins une option entre -t -p -w -h -m est obligatoire.
Un mode doit toujours être spécifié avec -t et -p.
Vous ne pouvez pas utiliser deux modes de la même option dans une commande.
L'utilisation de deux options ou plus pour l'emplacement n'est pas possible (-F -G -A -S -Q -O).
Le fichier d'entrée est un fichier de données météorologiques CSV avec un séparateur ";
