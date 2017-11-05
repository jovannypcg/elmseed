module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODEL


type alias Model =
    { jokes : List String }


init : ( Model, Cmd Msg )
init =
    ( Model [], Cmd.none )



-- UPDATE


type Msg
    = FindJoke
    | NewJoke (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FindJoke ->
            ( model, getRandomJoke )

        NewJoke (Ok joke) ->
            ( { model | jokes = joke :: model.jokes }, Cmd.none )

        _ ->
            Model [] ! []



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header
        , jokeSection model.jokes
        ]


header : Html Msg
header =
    div [ class "navbar-fixed scrollspy" ]
        [ nav [ class "orange darken-4" ]
            [ div [ class "nav-wrapper container" ]
                [ a [ href "#", class "brand-logo" ] [ text "Randomizer" ]
                , ul [ id "nav-mobile", class "right hide-on-med-and-down" ]
                    [ li [] [ a [ onClick FindJoke ] [ text "Joke" ] ]
                    ]
                ]
            ]
        ]


{-| Displays text in form of a card by Materialize.
-}
toCard : String -> Html Msg
toCard content =
    div [ class "row container" ]
        [ div [ class "col s8 offset-s2" ]
            [ div [ class "card blue-grey darken-1" ]
                [ div [ class "card-content white-text center" ]
                    [ p [] [ text content ] ]
                ]
            ]
        ]


{-| Provides section to show jokes saved in model.
-}
jokeSection : List String -> Html Msg
jokeSection jokes =
    section [] [ div [] (List.map toCard <| jokes) ]



-- REQUESTS


{-| Request a random joke from the Chuck Norris Database.
-}
getRandomJoke : Cmd Msg
getRandomJoke =
    let
        url =
            "https://api.icndb.com/jokes/random"

        request =
            Http.get url decodeJoke
    in
    Http.send NewJoke request


{-| Given a response from the Chuck Norris Database, for instance:
{ "value": { "id": 527, "joke": "No one has ever lived to tell about it." } }

This function retrieves the value of "joke" attribute.

-}
decodeJoke : Decode.Decoder String
decodeJoke =
    Decode.at [ "value", "joke" ] Decode.string
