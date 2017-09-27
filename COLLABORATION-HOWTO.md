<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Programmer avec R*

> Seuls les étudiants de l'Université Laval inscrits au cours IFT-1902 à l'automne 2017 disposent des droits en écriture requis pour effectuer la procédure décrite ci-dessous.

La version de développement du projet [Programmer avec R](https://vigou3.github.io/programmer-avec-r) est hébergée dans un [dépôt Git public](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop) de la Faculté des sciences et de génie de l'Université Laval.

Ce dépôt utilise l'interface [Atlassian BitBucket Server](https://www.atlassian.com/software/bitbucket/server).

La branche `master` du dépôt est réservée en écriture au gestionnaire du projet.

Pour collaborer au projet, vous devez suivre la procédure suivante à partir d'une invite de commande (Git Bash sous Windows ou Terminal sous macOS):

1. Si  vous travaillez sur le code source pour la première fois, déplacez-vous (avec la commande `cd` à la ligne de commande) dans le répertoire dans lequel vous voulez enregistrer le code source du projet (le répertoire `programmer-avec-r-develop` sera créé automatiquement), puis clonez le dépôt:

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop.git
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, mettez à jour votre copie locale du dépôt:

```
git pull
```

2. Créez une branche (locale) pour vos modifications:

```
git checkout -b <nom_de_branche>
```
	
3. Effectuez maintenant vos modifications. Il y a un fichier par chapitre et son nom, avec une extension `.tex` ou `.Rnw`, a un lien évident avec le titre du chapitre. On ne fait des modifications que dans un seul fichier à la fois! Une fois les modifications terminées, publiez le fichier modifié dans votre dépôt local avec un commentaire utile, mais bref, sur la nature des modifications:
    
```
git status
git add <fichier>
git commit -m "<commentaire>"
```
	
4. Publiez ensuite la branche avec les modifications dans le dépôt BitBucket:

```
git push -u origin <nom_de_branche>
```
	
5. Finalement, connectez-vous à l'interface graphique de BitBucket à l'adresse <https://projets.fsg.ulaval.ca/> avec votre IDUL/NIP et faites une demande de tirage (*pull request*) en sélectionnant l'option correspondante dans la barre latérale.

Pour des instructions plus détaillées, consultez les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de Atlassian, en particulier celui sur le processus de collaboration [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).
