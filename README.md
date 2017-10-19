<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Programmer avec R

*Programmer avec R* est un ouvrage d'initiation à la programmation informatique basé sur le langage R. Les fonctionnalités statistiques de R n'y sont pas abordées. On se concentre plutôt sur l'apprentissage du langage de programmation sous-jacent.

## Auteur

Vincent Goulet, professeur titulaire, École d'actuariat, Université Laval

## Modèle de développement

Le processus de rédaction et de maintenance du projet se conforme au modèle [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow). Seule particularité: la branche *master* se trouve [sur GitHub]((https://github.com/vigou3/programmer-avec-r)), alors que la branche de développement se trouve dans un [dépôt public](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop) de la Faculté des sciences et de génie de l'Université Laval.

Prière de passer par ce dépôt pour proposer des modifications; consulter le fichier `COLLABORATION-HOWTO.md` dans le dépôt pour la marche à suivre.

## Contenu du dépôt

Le dépôt contient tous les fichiers nécessaires pour composer le document avec XeLaTeX, à l'exception des polices de caractères suivantes:

> Lucida Bright OT  
> Lucida Bright Math  
> Lucida Grande Mono DK  
> Adobe Myriad Pro  
> Font Awesome

Les trois polices Lucida sont payantes et distribuées par le [TeX Users Group](https://tug.org/lucida). Le personnel et les étudiants de l'Université Laval peuvent en obtenir gratuitement une copie en écrivant à <mailto:lucida@bibl.ulaval.ca>. La police Myriad Pro est livrée avec Acrobat Reader. La police [Font Awesome](http://fontawesome.io) est gratuite. Prendre soin d'utiliser la version TrueType pour éviter que les symboles ne soient redimensionnés à l'écran ou à l'impression.

## Composition du document

Le document utilise à profusion la programmation lettrée avec [Sweave](https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf). Nous avons automatisé le processus de compilation avec l'outil Unix standard `make`. Le fichier `Makefile` fournit les recettes principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec Sweave et compile le document maître avec XeLaTeX;

- `zip` crée l'archive contenant le document et le code source des sections d'exemples;

- `release` crée une nouvelle version (*tag*) dans GitHub, téléverse les fichiers PDF et `.zip` et modifie les liens de la page web;

Question d'éviter les publications accidentelles, `make all` est équivalent à `make pdf`.

## Historique des versions

### (en développement)

#### Nouveautés

- Nouvel exercice 5.2.
- Détails additionnels dans la solution de l'exercice 5.4 (anciennement 5.3).

#### Autres modifications

- Adresse URL vers la vidéo «Matrices et tableaux» modifiée pour mener à une nouvelle version.

### 2017.10-1 (2017-10-16)

#### Nouveautés

- Chapitre 5 - Structure de données
- Les fichiers de sortie `.Rout` de tous les fichiers d'accompagnement sont dorénavant livrés avec le document. Chaque fichier `.Rout` contient les résultats de l'évaluation de toutes les expressions du fichier `.R` correspondant.
- Le fichier `algorithmique.R` contenant les solutions en R de certains exercices de Stephens (2013) est inclus dans la distribution.

### 2017.09-3b (2017-09-28)

Améliorations au chapitre 3. Pas de nouveau chapitre.

- Ajouts dans le chapitre 3 sur la conversion forcée d'un mode vers un autre dans la création des vecteurs et dans les opérations arithmétiques et logiques (sections 3.3.2, 3.4.1, 3.4.3 et les blocs correspondant dans `bases.R`).
- Réorganisation du matériel des sections 3.5.2 et 3.5.3 dans des listes pour en faciliter la lecture.
- Dans les règles d'appel d'une fonction (section 3.5.3), ajout d'une phrase pour expliciter le cas où certains arguments sont nommés et d'autres, non.

### 2017.09-3a (2017-09-27)

Révisions apportées au chapitre 4. Pas de nouveau chapitre.

- Les réponses des exercices du chapitre 4 manquent dans la version précédente. Corrigé.
- Mention et utilisation des fonctions `formals` et `body` dans le texte du chapitre 4.
- Précisions additionnelles sur la fonction de répartition empirique dans l'énoncé de l'exercice 4.1.
- Détails additionnels sur l'évaluation paresseuse.
- Retrait de l'exercice 4.2 et ajout d'un nouvel exercice 4.5 sur l'évaluation paresseuse.

### 2017.09-3 (2017-09-26)

#### Nouveautés

- Chapitre 4 - Détails d'implémentation du langage R

#### Autres modifications

- Les opérateurs du tableau 3.1 sont maintenant référencés dans l'index.
- Détails additionnels dans la solution de l'exercice 3.1f).
- Détails additionnels sur les expressions logiques dans `bases.R`.

### 2017.09-2 (2017-09-20)

#### Nouveautés

- Chapitre 3 - Bases du langage R

#### Autres modifications

- Visuel des blocs de code modifié.
- Nom du fichier d'accompagnement contenant le code des sections
  d'exemples maintenant mentionné au début de la section.
- Notes additionnelles sur l'utilisation de Git Bash comme ligne de commande Unix sous Windows, notamment à l'exercice 1.3.
- Ajout d'un encadré sur le raccourci clavier pour le sysmbole d'assignation dans RStudio pour les Mac munis d'un clavier canadien-français.
- Ajout à l'annexe A d'un lien vers la vidéo de configuration du raccourci pour le symbole d'affectation dans RStudio sur les Mac munis d'un clavier canadien-français.

### 2017.09-1a (2017-09-13)

Correction et révision de l'édition 2017.09-1. Aucun nouveau contenu.

- L'identification des parties des fenêtres RStudio (figure A.1) et Emacs (figure B.1) est maintenant présente.
- Retouches (essentiellement graphiques) aux sections Anatomie d'une session de travail avec RStudio et avec Emacs.

### 2017.09-1 (2017-09-13)

Cette édition préliminaire contient:

- Chapitre 1 - Éléments d'informatique pour programmeurs
- Chapitre 2 - Présentation de R
- Annexe A - RStudio: une introduction
- Annexe B - GNU Emacs et ESS: la base
- Annexe C - Réponses des exercices
- Bibliographie
- Index
