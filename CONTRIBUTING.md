<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Programmer avec R*

> Seuls les étudiants de l'Université Laval inscrits au cours IFT-1902 disposent des droits en écriture requis pour effectuer la procédure décrite ci-dessous.

> Ce guide est également disponible en [vidéo](https://youtu.be/nag48IGh8eo).

La version de développement du projet [Programmer avec R](https://vigou3.gitlab.io/programmer-avec-r) est hébergée dans un [dépôt Git public](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop) de la Faculté des sciences et de génie de l'Université Laval.

Le dépôt utilise l'interface [Atlassian BitBucket Server](https://www.atlassian.com/software/bitbucket/server).

La branche `master` du dépôt est réservée en écriture au gestionnaire du projet.

Pour collaborer au projet, vous devez publier vos modifications dans une nouvelle branche et effectuer une demande de tirage (*pull request*) vers la branche `master`. La procédure à suivre à partir d'une interface en ligne de commande (Git Bash sous Windows ou Terminal sous macOS) est la suivante.

1. Si  vous travaillez sur le code source pour la première fois, déplacez-vous avec la commande `cd` dans le répertoire dans lequel vous voulez enregistrer le code source du projet (le répertoire `programmer-avec-r-develop` sera créé automatiquement), clonez le dépôt et déplacez-vous ensuite dans le dossier du code source:

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop.git
cd programmer-avec-r-develop
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, déplacez-vous avec la commande `cd` dans le répertoire du code source, puis mettez à jour votre copie locale du dépôt depuis la branche `master`:

```
git checkout master
git pull
```

2. Créez une branche (locale) pour vos modifications:

```
git checkout -b <nom_de_branche>
```
	
3. Effectuez maintenant vos modifications. Il y a un fichier par chapitre et son nom, avec une extension `.tex` ou `.Rnw`, a un lien évident avec le titre du chapitre. Ne faites des modifications que dans un seul fichier à la fois! Une fois les modifications terminées, publiez le fichier modifié dans votre dépôt local avec un commentaire utile sur la nature des modifications:
    
```
git status
git add <fichier>
git commit -m "<commentaire>"
```

> À ce stade, Git vous demandera peut-être de vous authentifier. Utilisez votre IDUL et votre NIP.

4. Publiez ensuite la branche avec les modifications dans le dépôt BitBucket:

```
git push -u origin <nom_de_branche>
```
	
5. Finalement, connectez-vous à l'interface graphique de BitBucket à l'adresse <https://projets.fsg.ulaval.ca/git/login> avec votre IDUL/NIP et faites une demande de tirage (*pull request*) vers la branche `master` en sélectionnant l'option correspondante dans la barre latérale.

6. Si vous avez d'autres modifications à proposer, reprenez la procédure depuis le début en utilisant une **branche différente**. Autrement, vos modifications seront combinées en une seule requête et il devient difficile de les sélectionner séparément.

Pour des instructions plus détaillées, consultez les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de Atlassian, en particulier celui sur le processus de collaboration [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).

# Contributions fréquemment refusées

Les corrections mentionnées ci-dessous ont été refusées à répétition dans le passé. Elle ne peuvent donner droit à un point boni dans le cours IFT-1902 Informatique pour actuaires.

- S'agissant du caractère typographique, «espace» est un mot féminin. L'expression «suivi d'une espace» est donc correctement orthographiée.

- Le document est rédigé au moins en partie selon les règles de la [nouvelle orthographe](https://www.orthographe-recommandee.info), en particulier pour ce qui a trait à l'[accent circonflexe](https://www.orthographe-recommandee.info/regles4.htm). Alors «connait», «reconnait», «apparait» sont toutes des graphies correctes.

- Les sections 12.2 à 12.4 sont tirées du livre [Pro Git](https://git-scm.com/book/fr/v2). Proposez vos éventuelles corrections ou améliorations dans le [projet d'origine](https://github.com/progit/progit2-fr).
