<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

Un algorithme est une procédure de calcul permettant de résoudre un problème bien spécifié. En cela, l'algorithme explique comment, à partir d'entrants, obtenir l'extrant solution du problème. 

Pourquoi étudier les algorithmes? D'abord, l'algorithmique --- la science qui étudie les algorithmes et les structures de données --- est l'un des éléments fondateurs de l'informatique. C'est une discipline riche en techniques ingénieuses et en analyses mathématiques poussées. Pour un esprit cartésien, c'est pur plaisir. Ensuite, connaitre les principes de base de l'algorithmique et les algorithmes classiques permet de mieux planifier ses méthodes de résolution de problème. En effet, un bon algorithme permet de résoudre en quelques secondes un problème qui pourrait autrement prendre des années.

À titre d'exemple, dans le premier travail pratique vous deviez calculer l'écart moyen des données supérieures à 12 d'un vecteur par rapport à cette valeur. Un premier algorithme de très haut niveau permettant de résoudre ce problème serait:

1. Sélectionner les données supérieures à 12 dans le vecteur.
2. Soustraire 12 de chaque valeur retenue à la première étape.
3. Effectuer la moyenne des valeurs obtenues à la seconde étape.

La mise en œuvre en R de cet algorithme est:
```
mean(x[x > 12] - 12)
```

Nous pouvons apporter une toute petite modification à l'algorithme ci-dessus, comme suit:

1. Sélectionner les données supérieures à 12 dans le vecteur.
2. Effectuer la moyenne des valeurs obtenues à la première étape.
3. Soustraire 12 de la valeur retenue à la seconde étape.

La mise en œuvre est alors:
```
mean(x[x > 12]) - 12
```

Mathématiquement, les deux approches sont clairement équivalentes. La différence, alors? Avec la première approche, nous effectuons une soustraction pour chaque valeur supérieure à 12 que compte le vecteur. Avec la seconde approche, nous n'effectuons qu'une seule soustraction. Si le vecteur compte un million d'observations supérieures à 12, c'est un million de soustractions contre une seule. En temps de calcul, cela ne représente qu'un écart de quelques centièmes de secondes, mais ces fractions de secondes peuvent finir par faire une différence importante lorsque la taille des jeux de données augmente ou lorsque l'opération se répète de nombreuses fois.

Attardons-nous à un second exemple intéressant: l'élévation d'une valeur *b* à la puissance *n*. Un premier algorithme, écrit cette fois en *pseudo-langage*, pourrait se lire ainsi:

  Puissance(nombre réel *b*, entier *n*)
      Si n = 0, retourner 1.
	  Retourner b * Puissance(b, n - 1).
  Fin Puissance

Cet algorithme est *récursif*: la procédure `Puissance` s'appelle elle-même à répétition jusqu'à l'obtention du résultat désiré. Mathématiquement, l'algorithme revient à calculer `b^n` de la manière la plus simple et intuitive qui soit: `b * (b * (b * ... (b)))`. C'est fort bien lorsque *n* est petit, mais peut-on faire mieux pour une «grande» valeur de *n*? Imaginez que vous ne disposez que d'une calculatrice munie des opérations arithmétiques de base et du carré, et que vous devez élever un nombre à la puissance, disons, 21. Comment feriez-vous pour réduire le temps de calcul?

> Cet exemple est moins fantaisiste qu'il n'y parait. Jusqu'au milieu des années 1990, les étudiants en actuariat ne disposaient que de ce type de calculatrice pour les examens professionnels!

Vous avez pensé à un «algorithme»? Votre idée consiste fort probablement à diviser la puissance par deux autant de fois que possible et à élever au carré par la suite. Dans notre exemple, cela donne `b^21 = b * b^20 = b * (b^10)^2 =  b * ((b^5)^2)^2 = b * ((b * b^4)^2)^2 = b * ((b * (b^2)^2)^2)^2`. Ce calcul se traduit en algorithme comme suit:

  Puissance(nombre réel *b*, entier *n*)
      Si n = 0, retourner 1.
	  Si n est pair, retourner (Puissance(b, n/2))^2.
	  Si n est impair, retourner b * Puissance(b, n - 1).
  Fin Puissance

Pour élever un nombre à la puissance 21, le premier algorithme requiert 20 opérations et le second, seulement 6. Le dénombrement du nombre d'opérations requis par un algorithme est un aspect important de leur analyse. Il se fait généralement en notation *O()* qui signifie «de l'ordre de». Dans le premier algorithme de calcul de `b^n`, le nombre d'opérations est directement proportionnel à *n*, donc on dit que l'algorithme est *O(n)*. Dans le second algorithme où la puissance est divisée par deux à répétition, le nombre d'opérations est proportionnel au logarithme (en base deux) de *n*, d'où un algorithme *O(log n)*.

Kernighan et Pike (1999) font remarquer fort à propos que *si tous les programmes reposent sur des algorithmes, très peu de programmes exigent d'en concevoir de nouveaux*. Autrement dit, aussi complexe soit-il, un programme repose souvent sur quelques algorithmes fondamentaux bien connus et bien établis. À ce titre, les algorithmes de tri et de recherche jouent un rôle particulièrement important: on estime que 25 % du temps de calcul des ordinateurs est consacré au tri et à la recherche. Ce n'est pour rien que Donald Knuth consacre un volume entier de son œuvre monumentale [*The Art of Computer Programming*](https://fr.wikipedia.org/wiki/The_Art_of_Computer_Programming) à ce seul sujet!

L'étude des algorithmes s'accompagne habituellement de celle des structures de données ou, en d'autres termes, de la manière d'organiser les données dans un ordinateur. Il existe bien différentes structures de données en R (nous irons au-delà du vecteur simple dans le chapitre 5), mais leur réelle mise en œuvre demeure tout à fait transparente pour les programmeuses et les programmeurs. C'est pourquoi nous ferons l'impasse dans ce cours sur les notions de tableau (*array*), de liste chainée (*list*), d'arbre (*tree*) ou de table de hachage (*hashtable*).

Pour la théorie et les exercices sur les bases de l'algorithmique et sur les algorithmes fondamentaux de tri et de recherche, nous nous en remettons à l'excellent ouvrage [*Essential Algorithms*](https://bscs6b.files.wordpress.com/2014/09/1118612108_essential.pdf) de Rod Stephens. Rédigé dans un style clair et direct, le manuscrit va juste assez loin pour nos besoins dans les différentes notions, sans pour autant sacrifier les détails importants. Bref, un juste équilibre entre «algorithmique pour les nuls» et un livre plus théorique qui s'adresserait à des étudiants en informatique.

Bonne lecture!

> Quelques remarques pour vous aider dans votre lecture de Stephens (2013). 

1. Partout où vous lirez *array*, pensez tout simplement à un vecteur dans R.
2. Tel que mentionné au chapitre 1, l'auteur a pris le parti d'indicer les vecteurs comme dans plusieurs langages de programmation, soit de 0 à *n*-1 pour un vecteur de longueur *n*. Vous devrez adapter les algorithmes en conséquence pour la programmation en R où les vecteurs sont indicés de 1 à *n*.
3. Le livre fait ici et là référence au concept de *library*. Une bibliothèque (le nom en français) est une collection de fonctions ou de sous-programmes que l'on peut utiliser dans nos programmes. Certains langages de programmation sont constitué d'un noyau assez restreint auquel on ajoute plusieurs fonctionnalités standards (le tri ou la recherche, par exemple) par le biais de bibliothèques. C'est en partie le cas de R, mais le système de base contient déjà un grand nombre de fonctionnalités.
