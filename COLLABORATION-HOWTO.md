<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Programmer avec R*

> Seuls les étudiants de l'Université Laval inscrits au cours IFT-1902 à l'automne 2017 disposent des droits en écriture requis pour effectuer la procédure décrite ci-dessous.

La version de développement du projet [Programmer avec R](https://vigou3.github.io/programmer-avec-r) est hébergée dans un dépôt Git public de la [Faculté des sciences et de génie](https://fsg.ulaval.ca) de l'[Université Laval](https://ulaval.ca):

    [https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop]

Ce dépôt utilise l'interface [Atlassian BitBucket Server](https://www.atlassian.com/software/bitbucket/server).

La branche `master` du dépôt est réservée en écriture au gestionnaire du projet.

Pour collaborer au projet, vous devez suivre la procédure suivante:

1. Si c'est la première fois que vous travaillez sur le code source, clonez le dépôt avec

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop.git
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, mettez à jour votre copie locale du dépôt avec

```
git pull
```

2. Créez une branche (locale) pour vos modifications avec

```
git checkout -b <nom_de_branche>
```
	
3. Effectuez les modifications dans le fichier puis publiez les modifications dans votre dépôt local:
    
```
git status
git add <fichier>
git commit
```
	
4. Publiez la branche avec les modifications dans le dépôt BitBucket:

```
git push -u origin <nom_de_branche>
```
	
5. Accédez à l'interface graphique de BitBucket à l'adresse [https://projets.fsg.ulaval.ca/git/login] et connectez-vous avec votre IDUL/NIP. Ensuite, faites une demande de tirage (*pull request*) en sélectionnant l'option correspondante dans la barre latérale.

Pour des instructions plus détaillées, consultez les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de Atlassian, en particulier celui sur le processus de collaboration [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).
