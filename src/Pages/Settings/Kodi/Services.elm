module Pages.Settings.Kodi.Services exposing (Model, Msg, Params, page)

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
    { title = "Settings.Kodi.Services"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsInputBlock "Device name" "The name to display for the device when using various network services."
                , settingsToggleBlock "Announce services to other systems" "Allows applications on the network to discover enabled services via Zeroconf."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Control")
                , settingsToggleBlock "Allow remote control via HTTP" "Enable remote users to control this application through the built-in web server. Never expose the web server port to the Internet."
                , settingsInputBlock "Port" "Define the web server port."
                , settingsToggleBlock "Require authentication" "Choose whether requests to the web server require a username and a password, which must be set below if enabled. It is recommended to always leave this setting enabled."
                , settingsInputBlock "Username" "Define the web server username. Must be set when authentication is enabled."
                , settingsInputBlock "Password" "Define the web server password. Must be set when authentication is enabled."
                , settingsToggleBlock "Enable SSL" "Select between web interfaces installed via the add-on manager."
                , settingsDropdownBlock "Web interface" "Select between web interfaces installed via the add-on manager."
                , settingsToggleBlock "Allow remote control from applications on this system" "Allow programs on this device to control this application via the JSON-RPC over WebSocket, JSON-RPC over TCP, or EventServer protocol, without authentication."
                , settingsToggleBlock "Allow remote control from applications on other systems" "Allow programs on the network to control this application via the JSON-RPC over WebSocket, JSON-RPC over TCP, or EventServer protocol, without authentication. It allows anyone with access to the network to completely control this application and, therefore, this device. Never expose these interfaces to the Internet."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "UPnP / DLNA")
                , settingsToggleBlock "Enable UPnP support" "Enables UPnP. This allows you to stream media in your libraries to a UPnP client and to detect remote UPnP servers."
                , settingsToggleBlock "Share my libraries" "Enables the UPnP server. This allows you to stream media in your libraries to a UPnP client."
                , settingsToggleBlock "Allow remote control via UPnP" "Enable the UPnP client. This allows you to stream media from any UPnP server with a control point and control playback from that server."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "AirPlay")
                , settingsToggleBlock "Enable AirPlay support" "If enabled, the content from other AirPlay devices or applications can be received."
                , settingsToggleBlock "Use password protection" "Enable AirPlay password protection."
                , settingsInputBlock "Password" "Sets the AirPlay password."
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
