port module App exposing (main)

import Browser
import Html exposing (Html, div, text)
import Json.Decode as Decode
import Pages.A as PageA
import Pages.B as PageB
import Route



-- model


type Model
    = Top
    | PageA PageA.Model
    | PageB PageB.Model


initialModel : Decode.Value -> ( Model, Cmd Msg )
initialModel flag =
    ( changeRouteTo (Route.decode flag), Cmd.none )



-- update


type Msg
    = URLChanged Decode.Value
    | ChangeURL Route.Route


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        URLChanged nextRoute ->
            ( changeRouteTo (Route.decode nextRoute), Cmd.none )

        ChangeURL route ->
            ( model, Route.replace route )


changeRouteTo : Route.Route -> Model
changeRouteTo route =
    case route of
        Route.Top ->
            Top

        Route.PageA ->
            PageA PageA.init

        Route.PageB ->
            PageB PageB.init



-- view


view : Model -> Html Msg
view model =
    case model of
        Top ->
            div []
                [ text "This is Top"
                , div [] [ Route.link (ChangeURL Route.PageA) "PageA" ]
                , div [] [ Route.link (ChangeURL Route.PageB) "PageB" ]
                ]

        PageA pageModel ->
            PageA.view pageModel

        PageB pageModel ->
            PageB.view pageModel



-- port


subscriptions : Model -> Sub Msg
subscriptions _ =
    onUrlChanged URLChanged


port onUrlChanged : (Decode.Value -> msg) -> Sub msg



-- main


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
