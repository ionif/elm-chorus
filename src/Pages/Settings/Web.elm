module Pages.Settings.Web exposing (..)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
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
    { route : Route
    , languageDropdown : Dropdown Options
    , languageSelected : String
   }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , languageDropdown =
            Dropdown.init
                |> Dropdown.id "language"
                |> Dropdown.optionsBy .name (List.sortBy .name langList)
      , languageSelected = ""
     }, Cmd.none )

type alias Options =
    { name : String
    }

langList : List Options
langList =
  [ Options "a"
  , Options "b"
  , Options "c"
  ]

-- UPDATE


type Msg
    = ReplaceMe
    | DropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        DropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.languageDropdown
            in
            ( { model
                | languageDropdown = dropdown
                , languageSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.languageSelected
              }
            , Cmd.map DropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Web"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General options")
                , settingsDropdownBlock model.languageDropdown model.languageSelected "Language" "Preffered language, need to refresh browser to take effect"
                -- , settingsDropdownBlock "Default Player" "Which player to start with"
                -- , settingsDropdownBlock "Keyboard controls" "In Chorus, will your keyboard control Kodi, the browser or both."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "List options")
                , settingsToggleBlock "Ignore article" "Ignore articles (terms such as 'The' and 'A') when sorting lists"
                , settingsToggleBlock "Album artists only" "When listing artists should we only see artists with albums or all artists found. Warning: turning this off can impact performance with large libraries"
                , settingsToggleBlock "Focus playlist on playing" "Automatically scroll the playlist to the current playing item. This happens whenever the playing item is changed"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Appearance")
                , settingsToggleBlock "Vibrant headers" "Use colourful headers for media pages"
                , settingsToggleBlock "Disable Thumbs Up" "Remove the thumbs up button from media. Note: you may also want to remove the menu item from the Main Nav"
                , settingsToggleBlock "Show device name" "Show the Kodi device name in the header of Chorus"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Advanced options")
                , settingsInputBlock "Websockets port" "9090 is the default"
                , settingsInputBlock "Websockets host" "The hostname used for websockets connection. Set to 'auto' to use the current hostname."
                -- , settingsDropdownBlock "Poll interval" "How often do I poll for updates from Kodi (Only applies when websocket inactive)"
                -- , settingsDropdownBlock "Kodi settings level" "Advanced settings level is recommmended for those who know what they are doing."
                , settingsToggleBlock "Reverse proxy support" "Enable support of reverse proxying."
                , settingsToggleBlock "RefreshIgnore NFO" "Ignore local NFO files when manually refreshing media."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "API Keys")
                , settingsInputBlock "The Movie DB" "Set your personal API key"
                , settingsInputBlock "FanartTV" "Set your personal API key"
                , settingsInputBlock "YouTube" "Set your personal API key"
                , row [ width (px 800), Background.color Colors.headerBackground, paddingXY 20 25 ]
                    [ Input.button [ Background.color Colors.cerulean, Font.color Colors.white, paddingXY 30 8, Font.size 14, Border.rounded 2 ]
                        { onPress = Nothing
                        , label = text "SAVE"
                        }
                    ]
                , el [ height (px 100) ] (text "")
                ]
            ]
        ]
    }
