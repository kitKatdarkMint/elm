module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput,onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { content : String
  }


init : Model
init =
  { content = "" }



-- UPDATE


type Msg
  = Change String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
  div 
  [style "text-align" "center"]
    [ h1 [] [ text "Type your code below : " ]
    ,input 
      [ placeholder "example : [Repeat 10 [Forward 1, ]]"
      , value model.content
      , onInput Change
      , style "width" "300px"
      ,style "padding" "10px"
      , style "margin" "10px 0" ] []
    ,button 
    [style "cursor" "pointer"]
    [text "Draw"]
    ,div 
      [style "text-align" "center" 
      ,style "border" "1px solid black"
      , style "background-color" "white"
      ,style "height" "500px"
      , style "width" "500px"
      , style "margin" "20px auto" ]
      []
    ]