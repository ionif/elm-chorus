module Pages.Settings.Kodi.Pvr exposing (Model, Msg, Params, page)

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
    { title = "Settings.Kodi.Pvr"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsToggleBlock "Preselect playing channels in lists" "Preselect the playing channel in windows and dialogs containing channel lists. If enabled and there is a playing channel, the playing channel will be selected when opening a window or dialog containing a channel list. If disabled, the channel previously selected in a window or dialog will be selected when opening a window containing a channel list. "
                , settingsToggleBlock "Syncronize channel groups with backend(s)" "Import channel groups from the PVR backend (if supported). Will delete user created groups if they're not found on the backend."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Guide")
                -- , settingsDropdownBlock "Default select action" "Select what will happen when an item is selected in the guide: [Show context menu] Will trigger the context menu from where you can choose further actions; [Switch to channel] Will instantly tune to the related channel; [Show information] Will display a detailed information with plot and further options; [Record] Will create a recording timer for the selected item. [\"Smart select\"] The action is choosen dynamically, depending on whether the event is in the past, now or in the future."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Playback")
                -- , settingsDropdownBlock "Switch to full screen" "Switch to full screen display when starting playback of channels."
                -- , settingsToggleBlock "Confirm channel switches by pressing \"OK\"" "When flipping through channels using channel up/down buttons, channel switches must be confirmed using the OK button."
                -- , settingsDropdownBlock "Fallback framerate" "If enabled, this framerate is used for streams we were not able to detect fps."
                -- , settingsToggleBlock "Enable RDS for radio channels" "RDS data can be used if present."
                -- , settingsToggleBlock "Message traffic advisory" "RDS informs you about traffic advisory messages."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Recording")
                -- , settingsDropdownBlock "Instant recording action" "Action to perform when pressing the record button. [Record current show] will record the current show from \"now\" to the end of the show. If no TV guide data is currently available a fixed length recording starting \"now\", with the value set for \"Instant recording duration\" will be scheduled. [Record for a fixed period of time] will schedule a fixed length recording starting \"now\", with the value set for \"Instant recording duration\". [Ask what to do] will open a dialogue containing different recording actions to choose from, like \"Record current show\", \"Record next show\" and some fixed duration recordings."
                , settingsInputBlock "Instant recording duration" "Duration of instant recordings when pressing the record button. This value will be taken into account if \"Instant recording action\" is set to \"Record for a fixed period of time\""
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Reminders")
                , settingsInputBlock "Automatically close remander popup after" "Choose a time in seconds after which PVR reminder popups will be automatically cloised."
                , settingsToggleBlock "Schedule recording when auto-closing the reminder popup" "If enabled, a recording for the programme to remind will be scheduled when auto-closing the reminder popup, if supported by the PVR add-on and backend."
                , settingsToggleBlock "Switch to channel when auto-closing the reminder popup" "If enabled, switch to the channel with the programme to remind when auto-closing the reminder popup."
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
