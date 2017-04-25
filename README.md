> Consulter la
> [page du projet](https://vigou3.github.io/introduction-programmation-r)
> pour de l'information plus détaillée sur le document et pour
> télécharger la plus récente version officielle.

# Introduction à la programmation en R

*Introduction à la programmation en R* est un ouvrage de référence qui
se concentre non pas tant sur sur les fonctionnalités statistiques de
R, mais plutôt sur l'apprentissage du langage de programmation, plutôt
que sur les fonctionnalités statistiques.

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

La majorité des fichiers sources sont partagés avec un
[autre projet](http://libre.act.ulaval.ca/ACT-2002/Notes\%20de\%20cours/),
aussi faut-il s'assurer que les liens vers les vidéos explicatives
pointent vers la bonne chaîne YouTube (voir le fichier `URL.in`). Par
conséquent, utiliser `make` pour compiler le document. Le fichier
`Makefile` fournit les recettes principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec
  Sweave, place les bonnes URL vers les vidéos dans le code source et
  compile le document maître avec XeLaTeX;

- `zip` crée l'archive contenant le code source des sections
  d'exemples;

- `release` crée une nouvelle version (*tag*) dans GitHub, téléverse
  les fichiers PDF et `.zip` et modifie les liens de la page web;

Question d'éviter les publications accidentelles, `make all` est
équivalent à `make pdf`.

## Historique des versions

### Cinquième édition révisée (2017)

ISBN 978-2-9811416-6-8 (inchangé)

- Le code source du projet est maintenant hébergé sur
  [GitHub](https://github.com/vigou3/introduction-programmation-r).
  Sont modifiés en conséquence: les liens vers le code source
  et vers le code des sections d'exemples; un paragraphe de
  l'introduction.

### Cinquième édition (2016)

ISBN 978-2-9811416-6-8

- Introduction d'une approche d'apprentissage par problème avec
  l'ajout de mises en situation au début de plusieurs chapitres.
  Contribution de Laurent Caron lui valant un titre d'auteur
  collaborateur.
- Traitement de l'environnement intégré RStudio tant au chapitre 1 que
  dans une nouvelle annexe.
- Ajout d'hyperliens dans la page des notices pour accéder directement
  au code source des exemples. Le document PDF se «tient» donc seul.

### Quatrième édition (2014)

ISBN 978-2-9811416-3-7

- Ajout de liens vers des vidéos explicatives dans la chaîne YouTube
  associée au document.
- Publication sous le contrat Attribution-Partage dans les mêmes
  conditions 4.0 International de Creative Commons.

### Troisième édition (2012)

ISBN 978-2-9811416-2-0

- Refonte majeure laissant tomber le langage S au profit de R. Titre
  modifié de «Introduction à la programmation en S» à «Introduction à
  la programmation en R».
- Réécriture presque complète du chapitre 1.
- Listes d'objectifs au début de chacun des chapitres.
- Nouvelles couvertures.
- Nouvelle annexe sur l'installation de packages dans R.
- Ajout d'une table des matières dans le document PDF.
- Publication sous le contrat Paternité-Partage à l’identique 2.5
  Canada de Creative Commons.

### Seconde édition révisée (2007)

ISBN 978-2-9809136-7-9.

- Corrections de quelques coquilles rapportées par Jacques Dezoppy
  <jacques.dezoppy@teledisnet.be>.
- Ajout des raccourcis `M-p` et `M-n` dans la section sur l'interaction
  avec la ligne de commande ESS.
- Encodage des fichiers `.tex` et `.Rnw` en UTF-8.

### Seconde édition (2007)

ISBN 978-2-9809136-7-9.

- Corrections de nombreuses coquilles.
- Suppression des chapitres de régression et de séries chronologiques.
  Annexes C (générateurs de nombres aléatoires) et D (planification
  d'une simulation) déplacés dans le corps du texte (nouveaux
  chapitres 8 et 9).
- Mise à jour des fichiers de script pour la version 2.4.1 de R.

### Première version officielle (2006)

ISBN 2-9809136-0-X.

- Ajout d'un quatrième de couverture.
- Diverses corrections mineures.

### Version 0.99

- Changement de licence en faveur de la GNU Free Documentation
  License (annexe E).
- Ajout de l'exercice 3.9.
- Ajout de la fonction `confint` dans le chapitre 7.
- Mention de l'argument `comment.char` de la fonction `read.table` de
  R (chapitre 7).
- Diverses corrections mineures.

### Version 0.9

- Ajout d'un index.
- Ajout de sections (et de fichiers) d'exemples pour les chapitres 7,
  8 et 9.
- Ajout d'une section sur la fonction `mapply` dans le chapitre 6.
- Diverses corrections mineures.

### Version 0.8

Première version. Neuf chapitres et quatre annexes:

   Préface
   1. Présentation du langage S
   2. Bases du langage S
   3. Opérateurs et fonctions
   4. Exemples résolus
   5. Fonctions définies par l'usager
   6. Concepts avancés
   7. Fonctions d'optimisation
   8. Le S et la régression linéaire
   9. Le S et les séries chronologiques
   A. GNU Emacs et ESS: la base
   B. Utilisation et ESS et S-Plus sous Windows
   C. Générateurs de nombres aléatoires
   D. Planification d'une simulation en S
   Réponses des exercices
   Bibliographie
