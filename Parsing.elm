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
block : Parser (List Instruction) --afin d'accéder de manière recursive liste dans liste
block = 
instructionUser : Parser Instruction
{-parseur oneOf qui permet d'essayer plusieurs parseurs dans l'ordre jusqu'à ce qu'un réussisse -}
instructionUser = oneOf [succeed  Forward 
                                |."Forward" --utilisation du .| pour ecarter resultat de la suite
                        ,succeed Left 
                                |. "Left"
                        ,succeed Right 
                                |. "Right"
                        ,succeed Repeat 
                                |. "Repeat"
                                |= lazy (\_ -> block)
                        ]
-- exécuter un parser sur une chaîne de caractères donnée
runBlock :String -> Result (List DeadEnd) (List Instruction)
runBlock userString = run block userString
