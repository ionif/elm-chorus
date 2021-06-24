module Pages.Settings.Kodi.System exposing (Model, Msg, Params, page)

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
    { title = "Settings.Kodi.System"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Display")
                -- , settingsDropdownBlock "Monitor" ""
                -- , settingsDropdownBlock "Display mode" "Changes the way this application is displayed on the selected screen. Either in a window or fullscreen."
                -- , settingsDropdownBlock "Resolution" "Changes the resolution that the user interface is displayed in."
                -- , settingsToggleBlock "Blanck other displays" "In a multi-screen configuration, the screens not displaying this application are blacked out."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Audio")
                -- , settingsDropdownBlock "Audio output device" "Select the device to be used for playback of audio that has been decoded such as mp3."
                -- , settingsDropdownBlock "Number of channels" ""
                -- , settingsInputBlock "Volume control steps" "Set the number of volume control steps."
                -- , settingsDropdownBlock "Play GUI sounds" "Configure how interface sounds are handled, such as menu navigation and important notifications."
                -- , settingsInputBlock "GUI sounds" "Select or disable the sounds used in the user interface."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Internet access")
                -- , settingsToggleBlock "User proxy server" "If your Internet connection uses a proxy server, configure it here."
                -- , settingsDropdownBlock "Proxy type" "Configure which proxy type is used."
                -- , settingsInputBlock "Server" "Configure the proxy server address."
                -- , settingsInputBlock "Port" "Configure the proxy server port"
                -- , settingsInputBlock "Username" "Configure the proxy server username."
                -- , settingsInputBlock "Password" "Configure the proxy server passoword."
                -- , settingsInputBlock "Internet connection bandwidth limitation" "If your Internet connection has limited bandwidth available, use this setting to keep bandwidth usage by this application within defined limits."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Power saving")
                -- , settingsInputBlock "Put display to sleep when idle" "Turn off display when idle. Useful for TVs that turn off when there is no display signal detected"
                -- , settingsToggleBlock "Try to wakeup remote servers on access" "Automatically send Wake-on-LAN to server(s) right before trying to access shared files or services."
                -- , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Add-ons")
                -- , settingsDropdownBlock "Updates" "Change how auto updating of add-ons are handled."
                -- , settingsToggleBlock "Show notifications" "Show notification when an add-ons have been updated."
                -- , settingsToggleBlock "Unknown sources" "Allow installation of add-ons unknown sources."
                -- , settingsDropdownBlock "Update official add-ons from" "By default, add-ons from official repositories will be prevented from being auto-updated from private repositories. For cases such as updating from an add-ons beta repository this option can be switched to [Any repositories] (bear in mind this is a less secure option and enabling it could cause incompatibility and crashes)."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Logging")
                , settingsToggleBlock "Enable debug logging" "Turn debug logging on or off. Useful for troubleshooting."
                , settingsToggleBlock "Enable component-specific logging" "Enable verbose messages from additional libraries to be included in the debug log."
                , settingsInputBlock "Screenshot folder" "Select the folder where screenshots should be saved in."
                , settingsToggleBlock "Enable event logging" "Event logging allows to keep track of what has happened."
                , settingsToggleBlock "Enable notification event logging" "Notification event describe regular processes and actions performed by the system or the user."
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
