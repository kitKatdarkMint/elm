# elm

note brouillon pour executer code :
## Crée un fichier index.html que vous pouvez ouvrir dans un navigateur.
elm make src/Main.elm

## Crée un fichier js optimisé pour l'appeler depuis un fichier HTML.
elm make src/Main.elm --optimize --output=elm.js

#### à installer sur machine perso :
elm install elm/http
elm install elm/json
