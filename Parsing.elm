module Parsing exposing (..)

import Parser exposing (..)


--creation d'un type personnalisé Instruction
type Instruction
    = Forward Int
    | Left Int
    | Right Int
    | Repeat Int (List Instruction)

    
blockInst : Parser (List Instruction) --afin d'accéder de manière recursive bloc d'instructions dans un autre bloc d'instructions
blockInst = sequence --fonction de Parser qui recoit une liste d'instructions dans un ordre donné
    {start = "["
    , separator = ","
    , end = "]"
    , spaces = spaces --ignore les espaces 
    , item = instructionUser
    , trailing = Parser.Optional}
    
instructionUser : Parser Instruction
{-parseur oneOf qui permet d'essayer plusieurs parseurs dans l'ordre jusqu'à ce qu'un réussisse -}
instructionUser = oneOf [succeed  Forward 
                                |. keyword "Forward" --utilisation du .| pour ecarter resultat de la suite
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Left 
                                |. keyword "Left"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Right 
                                |. keyword "Right"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Repeat 
                                |. keyword "Repeat"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                                |. spaces --si il y a à nouveau espace entre crochet et entier
                                |= lazy (\_ -> blockInst)  --on renvoie la fonction block ici
                        ]
-- exécuter un parser sur une chaîne de caractères donnée
runBlock :String -> Result (List DeadEnd) (List Instruction) --List DeadEnd correspond liste d'erreurs
runBlock userString = run blockInst userString
