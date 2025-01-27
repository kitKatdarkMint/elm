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
instructionUser : Parser Instruction
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
