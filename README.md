# Projet ELM - 3TC 2 2025

_Groupe de projet : Charles BOUQUET, Kathleen SOMERS, Paul-Henri LUCOTTE_

## Execution du programme
Clôner le répertoire Github sur votre machine personne en exécutant la ligne suivante sur votre terminal : `git clone https://github.com/kitKatdarkMint/elm.git`
Vous pouvez également cliquer sur le lien suivant pour tester notre application web : [Logo TC turtle](https://github.com/kitKatdarkMint/elm/blob/main/index.html)
## Structure de notre projet ELM
* Dessin.elm -> Module de dessin qui traduit notre structure personnalisée `List (Instruction)`
* Parsing.elm -> Module utilisant le package `Parser`
* Main.elm -> Programme principal décrivant l'affichage de la page et applique l'architecture ELM avec les trois fonctions suivantes : `Model`,`Update` et `View`.

#### Packages utilisés :
* **http** : elm install elm/http

* **Browser** :elm install elm/browser

* **Svg**: elm install elm/svg

* **Parser**:elm install elm/parser
  
## Lancer le programme:
Pour pouvoir tester le programme, il suffit d'ouvrir l'intex.html dans un navigateur.
Si vous souhaitez recompiler le programme il faut ouvrir une console, aller dans le répertoire src et écrire elm make Main.elm
Attention: si vous recompilez l'index, le style ne sera plus appliqué, il vous faudra alors aller dans la balise style et mettre src="style.css" et supprimer ce qu'il y a derrière

## Comparaison elm et JavaScript
