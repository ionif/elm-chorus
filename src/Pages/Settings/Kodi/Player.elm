module Pages.Settings.Kodi.Player exposing (Model, Msg, Params, page)

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
    { title = "Settings.Kodi.Player"
    , body =
        [ row [ Element.height fill, Element.width fill]
            [ column[Element.height fill, Element.width fill, scrollbarY](Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40 , Font.size 24, Font.light]
                        [ el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Videos")
                        , settingsToggleBlock "Sync playback to display" "Synchronise video and audio to the refresh rate of the monitor. VideoPlayer won't use passthrough audio in this case because resampling may be required."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Music")
                        , settingsToggleBlock "Play next song automatically" "Automatically plays the next item in the current folder, for example in \"Files\" view after a track has been played, the next track in the same folder will automatically play."
                        , settingsToggleBlock "Queue songs on selection" "When songs are selected they are queued instead of playback starting immediately."
                        , settingsToggleBlock "Crossfade between songs on the same album" "Allow crossfading to occur when both tracks are from the same album."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Discs")
                        , settingsToggleBlock "Play DVDs automaticaly" "Autorun DVD video when inserted in drive."
                        , settingsToggleBlock "Load audio CD information from online service" "Read the information belonging to an audio CD, like song title and artist, from the Internet database freedb.org."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Pictures")
                        , settingsToggleBlock "Use pan and zoom effects" "Images in a slideshow will pan and zoom while displayed."
                        , settingsToggleBlock "Randomise" "View slideshow images in a random order."
                        , settingsToggleBlock "High quality downscaling" "Enable high quality downscaling of pictures (uses more memory and has moderate performance impact)."
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Language")
                        , settingsToggleBlock "Prefer default audio streams" "If enabled, audio streams that are flagged as default (and match the preferred language) are preferred over audio streams with higher quality (number of channels, codec, ...)."
                        , settingsToggleBlock "Enable parsing for closed captions" "Enable to parse for CC in video stream. Puts slightly more load on the CPU"
                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "Accessibility")
                        , settingsToggleBlock "Prefer audio stream for the visually impaired" "Prefer the audio stream for the visually impaired to other audio streams of the same language"
                        , settingsToggleBlock "Prefer audio stream for the hearing impaired" "Prefer the audio stream for the hearing impaired to other audio streams of the same language"
                        , settingsToggleBlock "Prefer subtitles for the visually impaired" "Prefer the subtitle stream for the hearing impaired to other subtitle streams of the same language"
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
