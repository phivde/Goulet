# Collaborer au projet *Programmer avec R*

> Seuls les étudiants de l'Université Laval inscrits au cours IFT-1902
> à l'automne 2017 disposent des droits en écriture requis pour
> effectuer la procédure décrite ci-dessous.

La version de développement du projet [Programmer avec
R](https://vigou3.github.io/programmer-avec-r] est hébergée dans un
dépôt Git public de la Faculté des sciences et de génie de
l'Université Laval:

    [https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop]

Ce dépôt utilise l'interface [Atlassian Stash](https://www.atlassian.com/blog/archives/atlassian-stash-enterprise-git-repository-management).

La branche `master` du dépôt est réservée en écriture au gestionnaire
du projet.

Pour collaborer au projet, vous devez suivre la procédure suivante:

1. Cloner le dépôt avec

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop.git
```

2. Créer une branche (locale) pour une modification avec

```
git checkout -b <nom_de_branche>
```
	
3. Faire les modifications dans le fichier puis publier les
   modifications localement:
    
```
git status
git add <fichier>
git commit
```
	
4. Publier la branche avec les modifications dans le dépôt:

```
git push -u origin <nom_de_branche>
```
	
5. Accéder à l'interface graphique de Stash et y faire une *Pull
   Request* en sélectionnant l'option correspondante dans la barre
   latérale.

Pour des instructions plus détaillées, consulter
les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de
Atlassian, en particulier celui sur le processus de collaboration
[*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).
