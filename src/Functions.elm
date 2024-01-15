module Functions exposing (..)


strToFloat : String -> Float
strToFloat string =
    Maybe.withDefault 0 (String.toFloat string)


floatToStr : Float -> String
floatToStr float =
    String.fromFloat float
