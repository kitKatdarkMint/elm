{- module de parsing qui fournit une fonction read prenant en entrée une chaîne de caractères et retournant une structure de données que vous aurez définie pour représenter les programmes TcTurtle.
Vous aurez besoin des fonctions succeed, token, int, spaces, lazy, run du package Parser -}
module Parsing exposing(..)
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
    , item = instruction}
    
instructionUser : Parser Instruction
{-parseur oneOf qui permet d'essayer plusieurs parseurs dans l'ordre jusqu'à ce qu'un réussisse -}
instructionUser = oneOf [succeed  Forward 
                                |."Forward" --utilisation du .| pour ecarter resultat de la suite
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Left 
                                |. "Left"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Right 
                                |. "Right"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                        ,succeed Repeat 
                                |. "Repeat"
                                |. spaces --ignore les espaces
                                |= int --recuperation de l'entier
                                |. spaces --si il y a à nouveau espace entre crochet et entier
                                |= lazy (\_ -> blockInst)  --on renvoie la fonction block ici
                        ]
-- exécuter un parser sur une chaîne de caractères donnée
runBlock :String -> Result (List DeadEnd) (List Instruction) --List DeadEnd correspond liste d'erreurs
runBlock userString = run blockInst userString
