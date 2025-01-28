{-module de dessin qui fournit une fonction display traduisant votre stucture de données en un élément svg -}
module Dessin exposing (..)

import Svg exposing (..)

rotation pos instruction = 
		case instruction of
	            Right changeAngle -> { pos | angle = pos.angle -changeAngle }
	            Left changeAngle -> {pos | angle = pos.angle + changeAngle}

calcEndpoint : Pos -> Float -> Pos
calcEndpoint start distance =
    let
        -- Compute the endpoint
        end =
            { x = start.x + distance * cos start.angle
            , y = start.y + distance * sin start.angle
            , angle = start.angle
            }
        
        -- Generate the line trace
        trace = line start end
    in
    end 