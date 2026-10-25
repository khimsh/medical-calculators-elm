module InputErrorTests exposing (tests)

import Calculators.InputError as InputError exposing (InputError(..))
import Expect
import Test exposing (Test, describe, test)
import Translations exposing (englishStrings, georgianStrings)



-- TESTS


tests : Test
tests =
    describe "Input errors"
        [ test "invalid inputs reads as the English message in English" <|
            \_ ->
                InputError.text englishStrings InvalidInputs
                    |> Expect.equal englishStrings.invalidInputs
        , test "not positive reads as the English message in English" <|
            \_ ->
                InputError.text englishStrings NotPositive
                    |> Expect.equal englishStrings.zeroNotAccepted
        , test "invalid inputs follows the language" <|
            \_ ->
                InputError.text georgianStrings InvalidInputs
                    |> Expect.notEqual (InputError.text englishStrings InvalidInputs)
        , test "not positive follows the language" <|
            \_ ->
                InputError.text georgianStrings NotPositive
                    |> Expect.notEqual (InputError.text englishStrings NotPositive)
        ]
