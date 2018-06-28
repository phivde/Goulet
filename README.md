<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Programmer avec R

[*Programmer avec R*](https://vigou3.gitlab.io/programmer-avec-r) est un ouvrage d'initiation à la programmation informatique basé sur le langage R. Les fonctionnalités statistiques de R n'y sont pas abordées. On se concentre plutôt sur l'apprentissage du langage de programmation sous-jacent.

## Auteur

Vincent Goulet, professeur titulaire, École d'actuariat, Université Laval

## Modèle de développement

Le processus de rédaction et de maintenance du projet se conforme au modèle [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow). Seule particularité: la branche *master* se trouve [sur GitLab]((https://gitlab.com/vigou3/programmer-avec-r)), alors que la branche de développement se trouve dans un [dépôt public](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-develop) de la Faculté des sciences et de génie de l'Université Laval.

Prière de passer par ce dépôt pour proposer des modifications; consulter le fichier `COLLABORATION-HOWTO.md` dans le dépôt pour la marche à suivre.

## Composition du document

La production du document repose sur la programmation lettrée avec LaTeX et
[Sweave](https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf). La composition du document, c'est-à-dire la transformation du code source vers le format PDF, requiert les outils suivants.

### LaTeX

LaTeX est l'un des systèmes de mise en page les plus utilisés dans le monde, particulièrement dans la production de documents scientifiques intégrant de multiples équations mathématiques, des graphiques, du code informatique, etc.

La composition d'un document requiert d'abord une distribution du système LaTeX. Nous recommandons la distribution [TeX Live](https://tug.org/texlive) administrée par le [TeX Users Group](https://tug.org/). 

- [Vidéo expliquant l'installation sur Windows](https://youtu.be/7MfodhaghUk)
- [Vidéo expliquant l'installation sur macOS](https://youtu.be/kA53EQ3Q47w)

Ensuite, des connaissances de base sur le fonctionnement de LaTeX sont nécessaires. Consulter [*Rédaction avec LaTeX*](https://vigou3.github.io/formation-latex-ul/), la formation LaTeX de l'Université Laval. 

>  *Rédaction avec LaTeX* est distribué avec TeX Live. 

Le moteur XeLaTeX est utilisé pour composer le document. 

### Polices de caractères

La compilation du document requiert les polices de caractères suivantes:

- [Lucida Bright OT, Lucida Math OT et Lucida Mono DK](https://tug.org/store/lucida/). Ces polices de très grande qualité sont payantes. La Bibliothèque de l'Université Laval détient une licence d'utilisation de cette police. Les étudiants et le personnel de l'Université peuvent s'en procurer une copie gratuitement en écrivant à [mailto:lucida@bibl.ulaval.ca].
- [Myriad Pro](https://fontsup.com/fr/family/myriad+pro.html) en versions *Regular*, *Bold*, *Italic* et *Bold Italic*. Cette police est normalement livrée avec Acrobat Reader.
- [Font Awesome](http://fontawesome.io/). Cette police fournit une multitude d'icônes et de symboles. Télécharger la plus récente version de la distribution et installer la police `fontawesome-webfont.ttf` du dossier `fonts`.

### Outils Unix additionnels

La composition du document de référence est rendue plus facile par l'utilisation de l'outil Unix standard `make`. Celui-ci n'est livré ni avec Windows, ni avec macOS.

#### Installation des outils sous Windows

Il y a différentes manières d'installer des outils Unix sous Windows. Nous recommandons l'environnement de compilation [MSYS2](http://www.msys2.org/).

- [Télécharger MSYS2](http://www.msys2.org/) (Windows seulement)

> Vous devez savoir si vous disposez d'[une version 32 ou 64 bits de Windows](https://support.microsoft.com/fr-ca/help/15056/windows-7-32-64-bit-faq) et choisir la distribution de MSYS2 en conséquence. 

Une fois l'installation de MSYS2 complétée (bien lire les instructions sur la page du projet), démarrer l'invite de commande MSYS et entrer

    pacman -S make

pour installer le paquetage additionnel.

#### Installation des outils sous macOS

Les outils Unix de compilation sont livrés avec XCode sous macOS. Pour pouvoir les utiliser depuis la ligne de commande, il faut installer les *Command Line Tools*. Entrer simplement à l'invite de commande du Terminal

    xcode-select --install

puis suivre les instructions.

### Lancement de la composition

Nous avons automatisé le processus de compilation avec l'outil Unix standard `make`. Le fichier `Makefile` fournit les recettes principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec Sweave et compile le document maître avec XeLaTeX;

- `zip` crée l'archive contenant le document et le code source des sections d'exemples;

- `release` crée une nouvelle version (*tag*) dans GitLab, téléverse le fichier `.zip` et modifie les liens de la page web;

Question d'éviter les publications accidentelles, `make all` est équivalent à `make pdf`.

## Historique des versions

### 2018.06 (2018-06-27)

Recompilation de la version 2017.12-1c avec les nouveaux liens vers le dépôt GitLab.

### 2017.12-1c (2017-12-17)

- Fin de la section 8.4 retravaillée afin, notamment, d'insérer un lien vers la vidéo sur le [travail collaboratif](https://youtu.be/bdIjgjg6zoc).
- Dans le fichier `algorithmique.R`, suppression d'un appel à une fonction 'rss' qui n'existe pas dans le fichier.

### 2017.12-1b (2017-12-09)

- Ajout des fichiers `collaboration.R` et `debogage.R` manquants dans la version précédente.

### 2017.12-1a (2017-12-08)

- Erreur d'assemblage dans la version précédente: il manque le chapitre 10!

### 2017.12-1 (2017-12-08)

#### Nouveautés

- Chapitre 9 - Analyse et contrôle de texte. Ce chapitre reprend, tout en l'améliorant, le matériel sur les expressions régulières publié dans le site de cours. Il comprend également une section sur les opérateurs Unix de transfert de données et de redirection.
- Chapitre 10 - Débogage
- Annexe C avec le texte intégral des sections du livre Pro Git à l'étude pour le chapitre 8.
- Fichier d'exemples `collaboration.R` pour le chapitre 8.
- Encadré à la fin du chapitre 8 sur la configuration de l'éditeur de texte pour Git.
- Nouvel exercice 8.2 demandant d'effectuer la configuration de l'encadré ci-dessus.
- Exercice 9.7 qui ne se trouvait pas dans la liste d'exercices publiée dans le site de cours.
- Astuce sur les préférences de l'application Terminal à la section 1.7.2.
- Exemples pour les commandes `cd`, `pwd` et `ls` à la section 1.7.3.
- Astuce sur le véritable nom de certains répertoires à la section 1.7.3.
- Solution pour l'exercice 1.3.

#### Autres modifications

- À la section 1.5.2, correction du vocabulaire: le symbole | est un opérateur de *transfert de données* et non de redirection.
- Utilisation systématique du symbole $ pour l'invite de commande du système d'exploitation.
- Nouvelles entrées d'index.

### 2017.11-2 (2017-11-23)

#### Nouveautés

- Chapitre 8 - Travail collaboratif
- Exemples d'utilisation de `mapply` et de `tapply` dans `application.R`.
- Texte additionnel dans la section sur la fonction `outer` dans `application.R`.
- Référence à Oualline (1997) à la fin de la section 1.1.
- Explication du raccourci `_` pour insérer le symbole d'affectation dans le mode ESS de Emacs à la section B.5.6.

#### Autres modifications

- Des notes de développement avaient été oubliées au début du chapitre 6. Note à moi-même: les faire en commentaires la prochaine fois.
- Lien vers la nouvelle version (du 2017-11-15) de la vidéo sur la fonction `apply`.
- Libellé de la section 6.6.4 changé pour «Fonction d'application pour groupes de données».
- Plus de place faite au «je» dans le texte (plutôt qu'au «nous»).

### 2017.11-1 (2017-11-07)

#### Nouveautés

- Chapitre 6 - Structures de contrôle et fonctions d'application
- Chapitre 7 - Fonctions internes et extensions

#### Autres modifications

- Exemples du chapitre 5: ajout sur les opérations arithmétiques avec les matrices dans le fichier `donnees.R`.
- L'annexe C apparaissait en double dans la table des matières.

### 2017.10-1a (2017-10-22)

#### Nouveautés

- Précisions sur l'endroit où sont créés les fichiers d'importation et d'exportation dans le fichier d'exemples `donnees.R`.
- Nouvel exercice 5.2.
- Détails additionnels dans la solution de l'exercice 5.4 (anciennement 5.3).
- Mention de `getwd` et `setwd` à la section 2.7 ainsi que dans le fichier d'exemples `presentation.R`.

#### Autres modifications

- Adresse URL vers la vidéo «Matrices et tableaux» modifiée pour mener à une nouvelle version.
- Correction de coquilles grâce aux contributions des étudiantes et étudiants.

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
