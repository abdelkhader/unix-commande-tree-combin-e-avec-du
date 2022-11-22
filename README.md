# unix-commande-tree-combin-e-avec-du
Nous souhaitons combiner les bénéfices des commandes « tree » (qui affiche une arborescence
sous forme d'arbre) et « du » en une seule afin d'obtenir comme résultat :

etudiant@25B:~/cc_unix/ex_II/script$ ./dutree.sh  ~/cc_unix --size(1)

/home/etudiant/cc_unix/ (20K)|-- ex_I (4,0K)|-- ex_II (8,0K)|-- script (4,0K)|-- ex_III (4,0K)

Pour exécuter le fichier, il faut la permisson d'exécution du fichier dutree.sh

Par défaut, on a deux paramètres:le chemin  et la profondeur voulue.
-si aucun paramètre n'a été donné le programme affiche le home et ses sous-repertoires
-si le chemin seulement a été donné, il affiche à partir de chemin et ses sous-repertoires
-si les paramètres donnés affiche en respectant la profondeur voulue.
