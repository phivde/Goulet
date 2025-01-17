<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Programmer avec R

[*Programmer avec R*](https://vigou3.gitlab.io/programmer-avec-r) est un ouvrage d'initiation à la programmation informatique basé sur le langage R. Les fonctionnalités statistiques de R n'y sont pas abordées. On se concentre plutôt sur l'apprentissage du langage de programmation sous-jacent.

L'ouvrage repose sur une philosophie d'apprentissage du langage R par l'exposition à un maximum de code et par la pratique de la programmation. C'est pourquoi les chapitres sont rédigés de manière synthétique et qu'ils comportent peu d'exemples au fil du texte. 

En revanche, le lecteur est appelé à lire et à exécuter le code informatique se trouvant dans les sections d'exemples à la fin de chacun des chapitres. Ce code et les commentaires qui l'accompagnent reviennent sur l'essentiel des concepts du chapitre et les complémentent souvent.

Question de développer, chez le lecteur, une culture de l'informatique et une connaissance des outils de développement informatique essentiels, *Programmer avec R* traite également de l'histoire des langages de programmation; des principes de base des systèmes d'exploitation et des systèmes de gestion de fichiers; des bonnes pratiques en matière de travail collaboratif; des outils d'analyse et de contrôle de texte `grep`, `sed` et `awk`.

## Auteur

Vincent Goulet, professeur titulaire, École d'actuariat, Université Laval

## Licence

«Programmer avec R» est mis à disposition sous licence [Attribution-Partage dans les mêmes conditions 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/deed.fr) de Creative Commons.

Consulter le fichier `LICENSE` pour la licence complète.

## Modèle de développement

Le processus de rédaction et de maintenance du projet suit le modèle [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow ). Seule particularité: la branche *master* se trouve dans le dépôt [`programmer-avec-r`](https://gitlab.com/vigou3/programmer-avec-r) dans GitLab, alors que la branche de développement se trouve dans le dépôt [`programmer-avec-r-devel`](https://projets.fsg.ulaval.ca/git/scm/vg/programmer-avec-r-devel) dans le serveur BitBucket de la Faculté des sciences et de génie de l'Université Laval.

Prière de passer par le dépôt `programmer-avec-r-devel` pour proposer des modifications; consulter le fichier `CONTRIBUTING.md` pour la marche à suivre.

## Composition du document

La production du document repose sur la programmation lettrée avec LaTeX et [Sweave](https://stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf). Consulter les diapositives de ma conférence [«Gérer ses documents efficacement avec la programmation lettrée»](https://gitlab.com/vigou3/raquebec-programmation-lettree/-/releases) pour en savoir un peu plus long sur ma stratégie d'intégration du texte du document et du code informatique des fichiers de script.

La composition du document, c'est-à-dire la transformation du code source vers le format PDF, requiert les outils ci-dessous.

### LaTeX

LaTeX est l'un des systèmes de mise en page les plus utilisés dans le monde, particulièrement dans la production de documents scientifiques intégrant de multiples équations mathématiques, des graphiques, du code informatique, etc.

La composition d'un document requiert d'abord une distribution du système LaTeX. Je recommande la distribution [TeX Live](https://tug.org/texlive) administrée par le [TeX Users Group](https://tug.org/). 

- [Vidéo expliquant l'installation sur Windows](https://youtu.be/7MfodhaghUk)
- [Vidéo expliquant l'installation sur macOS](https://youtu.be/kA53EQ3Q47w)

Ensuite, des connaissances de base sur le fonctionnement de LaTeX sont nécessaires. Consultez [*Rédaction avec LaTeX*](https://vigou3.github.io/formation-latex-ul/), la formation LaTeX de  l'Université Laval (c'est une suggestion biaisée, j'en suis l'auteur). 

>  *Rédaction avec LaTeX* est distribué avec TeX Live. 

Le moteur XeLaTeX est utilisé pour composer le document. 

### Polices de caractères

La compilation du document requiert les polices de caractères suivantes:

- [Lucida Bright OT, Lucida Math OT et Lucida Mono DK](https://tug.org/store/lucida/). Ces polices de très grande qualité sont payantes. La Bibliothèque de l'Université Laval détient une licence d'utilisation des polices Lucida. Les étudiants et le personnel de l'Université peuvent s'en procurer une copie gratuitement en écrivant à <lucida@bibl.ulaval.ca>.
- [Fira Sans](https://www.fontsquirrel.com/fonts/fira-sans) (les versions OpenType de Mozilla) en graisses *Book*, *Semi Bold*, *Book Italic* et *Semi Bold Italic*.
- [Font Awesome](https://fontawesome.com/). Cette police fournit une multitude d'icônes et de symboles. Depuis juillet 2019, le document utilise la version 5.x de la police. Celle-ci est normalement installée avec TeX Live.

### Bases de données bibliographiques

Les bases de données bibliographiques (fichiers ` .bib`) ne font pas partie du code source du projet. Vous pouvez toutefois les récupérer en clonant mon [dépôt Git de bibliographie)[https://gitlab.com/vigou3/bibliography).

### Outils Unix additionnels (Windows)

La composition du document de référence est rendue plus facile par l'utilisation de l'outil Unix standard `make` qui n'est pas livré avec Windows. 

Il y a différentes manières d'installer des outils Unix sous Windows. Je recommande l'environnement de compilation [MSYS2](https://www.msys2.org/). (Vous devez savoir si vous disposez d'[une version 32 ou 64 bits de Windows](https://support.microsoft.com/fr-ca/help/15056/windows-7-32-64-bit-faq) et choisir la distribution de MSYS2 en conséquence.)

- [Télécharger MSYS2](https://www.msys2.org/) (Windows seulement)

Une fois l'installation de MSYS2 complétée (bien lire les instructions sur la page du projet), démarrez l'invite de commande MSYS et entrez

    pacman -S make

pour installer le paquetage contenant `make`.

### Outils Unix additionnels (macOS)

Les outils Unix de compilation ne sont pas livrés avec macOS, mais leur installation est très simple. Ils sont livrés avec XCode. Pour pouvoir les utiliser depuis la ligne de commande, il faut installer les *Command Line Tools*. Entrez simplement à l'invite de commande du Terminal

    xcode-select --install

puis suivez les instructions.

### Lancement de la composition

J'ai automatisé le processus de compilation avec l'outil Unix standard `make`. Le fichier `Makefile` fournit les recettes principales suivantes:

- `pdf` crée les fichiers `.tex` à partir des fichiers `.Rnw` avec Sweave et compile le document maitre avec XeLaTeX;

- `zip` crée l'archive contenant notamment le document et les fichiers de script;

- `release` crée une nouvelle version (*tag*) dans GitLab, téléverse le fichier `.zip` et modifie les liens de la page web.

Question d'éviter les publications accidentelles, `make all` est équivalent à `make pdf`.
