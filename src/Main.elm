module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Svg.Attributes exposing (width, height, viewBox)
import Svg exposing (..)
-- importation des autres scripts
import Parsing exposing (..)
import Dessin exposing (..)


-- MAIN
main =
    Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
    { content : String
    , lines : List (Dessin.Pos, Dessin.Pos)
    , error : Maybe String --gestion et affichage des erreurs sur la page
    }

init : Model
init =
    { content = ""
    , lines = []
    , error = Nothing
    }

-- UPDATE
type Msg
    = Change String
    | Draw --bouton draw

update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }
        
        Draw ->
            case Parsing.runBlock model.content of
                Ok instructions ->
                    let
                        initialPos =
                            { x = 100, y = 100, angle = 0 }

                        (_, lines) =
                            executeInstructions initialPos instructions []
                    in
                    { model | lines = lines, error = Nothing }

                Err _ ->
                    { model | error = Just "Parsing Error: Invalid input format." }

executeInstructions : Dessin.Pos -> List Instruction -> List (Dessin.Pos, Dessin.Pos) 
    -> (Dessin.Pos, List (Dessin.Pos, Dessin.Pos))
executeInstructions start instructions lines =
    List.foldl --applique les instructions
    --curent pos et currentLines sont respectivements la position actuelle et la liste de toutes les lignes à tracer jusqu'à maintenant
        (\instruction (currentPos, currentLines) ->
            case instruction of --on identifie l'instruction et on execute la fonction appropriée
                Forward distance ->
                    Dessin.calcEndpoint currentPos (toFloat distance) currentLines

                Left angle ->
                    (Dessin.rotation currentPos (Left angle), currentLines)

                Right angle ->
                    (Dessin.rotation currentPos (Right angle), currentLines)

                Repeat count subInstructions ->  --count: nombre de fois que l'on execute les instruction imbriquées (subInstructions)
                    List.foldl --recursivité ici, on réappelle executeInstructions
                        (\_ (pos, lns) -> executeInstructions pos subInstructions lns) --on ignore la valeur qu'il y a dans la list.range
                        --pos est la position et lns la liste des lignes actuelles
                        (currentPos, currentLines)
                        (List.range 1 count) --on crée une liste de 1 à count dans laquelle on met le résultat de foldr, pour tracer les lignes après (donc on execute les instructions imbriquées "count" fois)
        )
        (start, lines)
        instructions

-- VIEW
view : Model -> Html Msg
view model =
    div
        [ class "page" ]
        [ h1 [] [ Html.text "Type your code below : " ]
        , div [ class "field field_v1" ]
            [ input
                [ placeholder "example : [Repeat 10 [Forward 1, Left  1 ]]"
                , value model.content
                , onInput Change
                , class "field__input"
                ]
                []
            ]
        , button --bouton Draw
            [ Html.Attributes.style "cursor" "pointer"
            , onClick Draw
            ]
            [ Html.text "Draw" ]
        , div 
            [ class "canvas" ]
            [ Svg.svg
                [ Svg.Attributes.width "400"
                , Svg.Attributes.height "400"
                , Svg.Attributes.viewBox "0 0 400 400"
                ]
                (Dessin.tracelignes model.lines)
            ]
        , case model.error of
            Just errorMsg ->
                div [ Html.Attributes.style "color" "red" ] [ Html.text errorMsg ]
            Nothing ->
                Html.text ""
        ]
