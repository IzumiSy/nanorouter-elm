port module App exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Route


type alias Model =
    { route : Route.Route
    , count : Int
    }


initialModel : Decode.Value -> ( Model, Cmd Msg )
initialModel flag =
    ( { route = Route.decode flag, count = 0 }, Cmd.none )


type Msg
    = Increment
    | Decrement
    | URLChanged Decode.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        URLChanged value ->
            ( { model | route = Route.decode value }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Decrement ] [ text "-1" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    onUrlChanged URLChanged


port onUrlChanged : (Decode.Value -> msg) -> Sub msg


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
