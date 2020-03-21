port module Route exposing (Route, decode, replace)

import Json.Decode as Decode


type Route
    = Hello
    | World
    | Top


decode : Decode.Value -> Route
decode value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault Top



-- Internals


stringToRoute : String -> Decode.Decoder Route
stringToRoute value =
    case value of
        "hello" ->
            Decode.succeed Hello

        "world" ->
            Decode.succeed World

        _ ->
            Decode.succeed Top


decoder : Decode.Decoder Route
decoder =
    Decode.string |> Decode.andThen stringToRoute


port replace : String -> Cmd msg
