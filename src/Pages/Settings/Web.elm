module Pages.Settings.Web exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route }, Cmd.none )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Web"
    , body =
        [
          row[]
          [ column[](Components.VerticalNavSettings.view
              model.route)
          , column[][
          el[width (fillPortion 1), Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingXY 5 1](text "General options")
          ]
          ]
        ]
    }
