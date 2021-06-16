module Pages.Settings.Kodi.Pvr exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Pages.Settings.Addons exposing (settingsToggleBlock)
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
    { title = "Settings.Kodi.Pvr"
    , body =
        [ row [ Element.height fill, Element.width fill]
            [ column[Element.height fill, Element.width fill, scrollbarY](Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40 , Font.size 24, Font.light]
                        [ el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "General")
                        , settingsToggleBlock "Preselect playing channels in lists" "Preselect the playing channel in windows and dialogs containing channel lists. If enabled and there is a playing channel, the playing channel will be selected when opening a window or dialog containing a channel list. If disabled, the channel previously selected in a window or dialog will be selected when opening a window containing a channel list. "
                        , settingsToggleBlock "Syncronize channel groups with backend(s)" "Import channel groups from the PVR backend (if supported). Will delete user created groups if they're not found on the backend."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Guide")
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Playback")
                        , settingsToggleBlock "Confirm channel switches by pressing \"OK\"" "When flipping through channels using channel up/down buttons, channel switches must be confirmed using the OK button."
                        , settingsToggleBlock "Enable RDS for radio channels" "RDS data can be used if present."
                        , settingsToggleBlock "Message traffic advisory" "RDS informs you about traffic advisory messages."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Recording")
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Reminders")
                        , settingsToggleBlock "Schedule recording when auto-closing the reminder popup" "If enabled, a recording for the programme to remind will be scheduled when auto-closing the reminder popup, if supported by the PVR add-on and backend."
                        , settingsToggleBlock "Switch to channel when auto-closing the reminder popup" "If enabled, switch to the channel with the programme to remind when auto-closing the reminder popup."
                        , row[ width (px 800),Background.color Colors.headerBackground, paddingXY 20 25][
                            Input.button[Background.color Colors.cerulean, Font.color Colors.white,paddingXY 30 8, Font.size 14, Border.rounded 2]{
                              onPress = Nothing,
                              label = text "SAVE"
                              }
                            ]
                        , el[height (px 100)](text "")
                        ]
            ]
        ]
    }
