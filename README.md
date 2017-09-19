# Programmer avec R

*Programmer avec R* est un ouvrage d'initiation à la programmation
informatique basé sur le langage R. Les fonctionnalités statistiques
de R n'y sont pas abordées. On se concentre plutôt sur l'apprentissage
du langage de programmation sous-jacent.

## Auteur

Vincent Goulet, professeur titulaire, École d'actuariat, Université Laval

## Modèle de développement

Le processus de rédaction et de maintenance du projet se conforme au
modèle
[*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).
Seule particularité: la branche *master* se
trouve [sur GitHub]((https://github.com/vigou3/programmer-avec-r)),
alors que la branche de développement se trouve dans
un
[dépôt public](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop) de
la Faculté des sciences et de génie de l'Université Laval.

Prière de passer par ce dépôt pour proposer des modifications;
consulter le fichier `COLLABORATION-HOWTO.md` dans le dépôt pour la
marche à suivre.

## Contenu du dépôt

Le dépôt contient tous les fichiers nécessaires pour composer le
document avec XeLaTeX, à l'exception des polices de caractères
suivantes:

> Lucida Bright OT  
> Lucida Bright Math  
> Lucida Grande Mono DK  
> Adobe Myriad Pro  
> Font Awesome

Les trois polices Lucida sont payantes et distribuées par le
[TeX Users Group](https://tug.org/lucida). La police Myriad Pro est
livrée avec Acrobat Reader. La police
[Font Awesome](http://fontawesome.io) est gratuite. Prendre soin
d'utiliser la version TrueType pour éviter que les symboles ne soient
redimensionnés à l'écran ou à l'impression.

## Composition du document

Le document utilise à profusion la programmation lettrée
avec
[Sweave](https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf).
Nous avons automatisé le processus de compilation avec l'outil Unix
standard `make`. Le fichier `Makefile` fournit les recettes
principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec
  Sweave et compile le document maître avec XeLaTeX;

- `zip` crée l'archive contenant le document et le code source des
  sections d'exemples;

- `release` crée une nouvelle version (*tag*) dans GitHub, téléverse
  les fichiers PDF et `.zip` et modifie les liens de la page web;

Question d'éviter les publications accidentelles, `make all` est
équivalent à `make pdf`.

## Historique des versions

### en développement

- Notes additionnelles sur l'utilisation de Git Bash comme ligne de
  commande Unix sous Windows, notamment à l'exercice 1.3.
- Ajout d'un encadré sur le raccourci clavier pour le sysmbole
  d'assignation dans RStudio pour les Mac munis d'un clavier
  canadien-français.
- Visuel des blocs de code modifié.

### 2017.09-1a (2017-09-13)

Correction et révision de l'édition 2017.09-1. Aucun nouveau contenu.

- L'identification des parties des fenêtres RStudio (figure A.1) et
  Emacs (figure B.1) est maintenant présente.
- Retouches (essentiellement graphiques) aux sections Anatomie d'une
  session de travail avec RStudio et avec Emacs.

### 2017.09-1 (2017-09-13)

Cette édition préliminaire contient:

- Chapitre 1 - Éléments d'informatique pour programmeurs
- Chapitre 2 - Présentation de R
- Annexe A - RStudio: une introduction
- Annexe B - GNU Emacs et ESS: la base
- Annexe C - Réponses des exercices
- Bibliographie
- Index
