{-module de dessin qui fournit une fonction display traduisant votre stucture de données en un élément svg -}
module Dessin exposing (..)

import Svg exposing (..)
lignes=[]
rotation pos instruction = 
		case instruction of
	            Right changeAngle -> { pos | angle = pos.angle -changeAngle }
	            Left changeAngle -> {pos | angle = pos.angle + changeAngle}

calcEndpoint : Pos -> Float -> Pos
calcEndpoint start distance lignes=
    let
        -- Compute the endpoint
        end =
            { x = start.x + distance * cos start.angle --géométrie
            , y = start.y + distance * sin start.angle
            , angle = start.angle
            }
        
        -- Generate the line trace
        newLines =
        lignes = lignes++ [(start,end)]
    in
    (end, newLines)



--trace une ligne entre 2 positions
traceligne debut fin=
    line
        [ x1 (String.fromFloat debut.x)
        , y1 (String.fromFloat debut.y)
        , x2 (String.fromFloat fin.x)
        , y2 (String.fromFloat fin.y)
        , stroke "black"
        , strokeWidth "2"
        ]
        []  
tracelignes lines = List.map (\(debut, fin) ->traceligne debut fin) lignes


--voir le tracé

view : Svg.Svg msg
view =
    svg
        [ width "200", height "200", viewBox "0 0 200 200" ]
        (tracelignes lignes)


