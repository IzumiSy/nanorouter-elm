port module Route exposing
    ( Route(..)
    , decode
    , link
    , replace
    )

import Html exposing (Html, a, text)
import Html.Attributes exposing (href)
import Html.Events as Events
import Json.Decode as Decode


type Route
    = Top
    | PageA
    | PageB


decode : Decode.Value -> Route
decode value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault Top


link : msg -> String -> Html msg
link msg label =
    a [ href "#", onClick msg ] [ text label ]


replace : Route -> Cmd msg
replace route =
    replaceInternal (routeToString route)



-- Internals


onClick : msg -> Html.Attribute msg
onClick msg =
    Events.custom "click"
        (Decode.succeed
            { message = msg
            , stopPropagation = True
            , preventDefault = True
            }
        )


stringToRoute : String -> Decode.Decoder Route
stringToRoute value =
    case value of
        "/pageA" ->
            Decode.succeed PageA

        "/pageB" ->
            Decode.succeed PageB

        _ ->
            Decode.succeed Top


routeToString : Route -> String
routeToString route =
    case route of
        Top ->
            "/"

        PageA ->
            "/pageA"

        PageB ->
            "/pageB"


decoder : Decode.Decoder Route
decoder =
    Decode.string |> Decode.andThen stringToRoute


port replaceInternal : String -> Cmd msg
