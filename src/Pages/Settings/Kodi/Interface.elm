module Pages.Settings.Kodi.Interface exposing (Model, Msg, Params, page)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
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
    { title = "Settings.Kodi.Interface"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Skin")
                -- , settingsDropdownBlock "Skin" "Select the skin for the user interface. This will define the look and feel of the application."
                -- , settingsDropdownBlock "Theme" "Change the theme associated with your selected skin."
                -- , settingsDropdownBlock "Colors" "Change the colours of your selected skin."
                -- , settingsDropdownBlock "Fonts" "Choose the fonts displayed in the user interface. The font sets are configured by your skin."
                -- , settingsInputBlock "Zoom" "Resize the view of the user interface."
                -- , settingsToggleBlock "Show RSS news feeds" "Turn this off to remove the scrolling RSS news ticker."
                -- , settingsInputBlock "Edit" "Edit the RSS feeds."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Regional")
                -- , settingsDropdownBlock "Language" "Chooses the language of the user interface."
                -- , settingsDropdownBlock "Character set" "Choose which character set is used for displaying text in the user interface. This doesn't change the character set used for subtitles, for that go to Player &gt; Language."
                -- , settingsDropdownBlock "Region default format" "Select the formats for temperature, time and date. The available options depend on the selected language."
                -- , settingsDropdownBlock "Timezone country" "Select country location."
                -- , settingsDropdownBlock "Timezone" "Select your current timezone."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Screensaver")
                -- , settingsDropdownBlock "Screensaver mode" "Select the screensaver. The \"Dim\" screensaver will be forced when fullscreen video playback is paused or a dialogue box is active."
                -- , settingsInputBlock "Wait time" "Set the time to wait for any activity to occur before displaying the screensaver."
                -- , settingsToggleBlock "Use visualisation if playing audio" "If music is being played, the selected visualisation will be started instead of displaying the screensaver."
                -- , settingsToggleBlock "Use dim if paused during video playback" "Dim the display when media is paused. Not valid for the \"Dim\" screensaver mode."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Master lock")
                -- , settingsToggleBlock "Ask for master lock code on startup" "If enabled, the master lock code is required to unlock this application on startup."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Startup")
                -- , settingsDropdownBlock "Perform on startup" "Select an action Kodi will perform on startup."
                -- , settingsDropdownBlock "Startup window" "Select the media window to display on startup."
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
