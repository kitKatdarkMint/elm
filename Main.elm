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
  [class "page"]
    [ h1 [] [ text "Type your code below : " ]
    ,div [ class "field field_v1" ]
      [input 
      [ placeholder "example : [Repeat 10 [Forward 1, ]]"
      , value model.content
      , onInput Change
      , class "field__input" ] 
      []
      ]
    ,button 
    [style "cursor" "pointer"]
    [text "Draw"]
    ,div 
      [class "canvas"] 
      []
   ]