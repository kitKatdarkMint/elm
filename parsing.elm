{- module de parsing qui fournit une fonction read prenant en entrée une chaîne de caractères et retournant une structure de données que vous aurez définie pour représenter les programmes TcTurtle.
Vous aurez besoin des fonctions succeed, token, int, spaces, lazy, run du package Parser -}
import Parser exposing (Parser, (|.), (|=), succeed, symbol, float, spaces)
