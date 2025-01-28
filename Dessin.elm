{-module de dessin qui fournit une fonction display traduisant votre stucture de données en un élément svg -}
module Dessin exposing (..)

import Svg exposing (..)

rotation pos instruction = 
		case instruction of
            Right changeAngle -> { pos | angle = pos.angle -changeAngle }
            Left changeAngle -> {pos | angle = pos.angle + changeAngle}
