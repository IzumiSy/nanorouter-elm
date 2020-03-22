module Pages.B exposing (Model, init, view)

import Html exposing (Html, div, text)



-- model


type alias Model =
    String


init : Model
init =
    "This is Page B"



-- view


view : Model -> Html msg
view model =
    div [] [ text model ]
