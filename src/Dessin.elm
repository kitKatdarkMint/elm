module Dessin exposing (..)

import Parsing exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

type alias Pos =
    { x : Float
    , y : Float
    , angle : Float
    }

rotation : Pos -> Instruction -> Pos
rotation pos instruction = 
    case instruction of
        Right angle -> 
            { pos | angle = pos.angle - (toFloat angle) }
        
        Left angle -> 
            { pos | angle = pos.angle + (toFloat angle) }
        
        _ -> pos

calcEndpoint : Pos -> Float -> List (Pos, Pos) -> (Pos, List (Pos, Pos))
calcEndpoint start distance lignes =
    let
        angleRad = degrees start.angle
        end =
            { x = start.x + distance * cos angleRad
            , y = start.y + distance * sin angleRad
            , angle = start.angle
            }
    in
    (end, lignes ++ [(start, end)])

traceligne : Pos -> Pos -> Svg msg
traceligne debut fin =
    Svg.line
        [ x1 (String.fromFloat debut.x)
        , y1 (String.fromFloat debut.y)
        , x2 (String.fromFloat fin.x)
        , y2 (String.fromFloat fin.y)
        , stroke "black"
        , strokeWidth "2"
        ]
        []

tracelignes : List (Pos, Pos) -> List (Svg msg)
tracelignes lignes = 
    List.map (\(debut, fin) -> traceligne debut fin) lignes
