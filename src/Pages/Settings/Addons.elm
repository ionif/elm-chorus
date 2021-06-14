module Pages.Settings.Addons exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import Element.Border as Border
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
    { title = "Settings.Addons"
    , body =
        [ row [ Element.height fill, Element.width fill]
            [ column[Element.height fill, Element.width fill, scrollbarY](Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40 , Font.size 24, Font.light]
                        [ el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.audioencoder")
                        , settingsBlock "AAC encoder" "AAC is a set of codecs designed to provide better compression than MP3s, and are improved versions of MPEG audio."
                        , settingsBlock "WMA encoder" "Windows Media Audio, Microsoft’s lossy audio format."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.game.controller")
                        , settingsBlock "Default Controller" "The default media center controller is based on the Xbox 360 controller."
                        , settingsBlock "SENS Controller" "The SNES (akso known as Super NES or Super Nintendo) is a 16-bit console released in 1990. The controller design served as inspiration for the PlayStation, Dreamcast, Xbox and Wii Classic controllers."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.inputstream")
                        , settingsBlock "InputStream Adaptive" "InputStream client for adaptive streams"
                        , settingsBlock "RTMP Input" "The Real Time Messaging Protocol (RTMP) is a proprietary network protocol developed by Adobe Inc. to transmit audio, video and other data over the Internet from a media server to a flash player. This addon implements RTMP streaming support for Kodi and installed add-ons."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.metadata.scraper.albums")
                        , settingsBlock "Universal Album Scraper" "This scraper collects information from the following supported sites: MusicBrainz, last.fm, allmusic.com and amazon.de, while grabs artwork from: fanart.tv, last.fm and allmusic.com. It can be set field by field that from which site you want that specific information. The initial search is always done on MusicBrainz. In case allmusic and/or amazon.de links are not added on the MusicBrainz site, fields from allmusic.com and/or amazon.de cannot be fetched (very easy to add those missing links though)."
                        , settingsBlock "Generic Album Scraper" "Searches for album information and artwork across multiple websites."
                        , settingsBlock "Local Information Only" "Use local information only"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.metadata.scraper.artists")
                        , settingsBlock "Universal Artist Scraper" "This scraper collects information from the following supported sites: TheAudioDb.com, MusicBrainz, last.fm, and allmusic.com, while grabs artwork from: fanart.tv, htbackdrops.com, last.fm and allmusic.com. It can be set field by field that from which site you want that specific information. The initial search is always done on MusicBrainz. In case allmusic link is not added on the MusicBrainz site fields from allmusic.com cannot be fetched (very easy to add those missing links though)."
                        , settingsBlock "Generic Artist Scraper" "Searches for artist information and artwork across multiple websites."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.metadata.scraper.library")
                        , settingsBlock "AllMusic Scraper Library" "Download Music information form www.allmusic.com"
                        , settingsBlock "fanart.tv Scraper Libraray" "Download backdrops from www.fanart.tv.com"
                        , settingsBlock "IMDB Scraper Library" "Download Movie Information from www.imdb.com"
                        , settingsBlock "MusicBrainz Scraper Library" "Download Music Information from www.musicbrainz.org"
                        , settingsBlock "Generic Artist Scraper" "Searches for artist information and artwork across multiple websites."
                        , settingsBlock "TheAudioDb Scraper Library" "Download Music Information from www.theaudiodb.com"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.metadata.scraper.movies")
                        , settingsBlock "The Movie Database" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."
                        , settingsBlock "The Movie Database Python" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.metadata.scraper.tvshows")
                        , settingsBlock "The Movie Database" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."
                        , settingsBlock "TMDb TV Shows" "The Movie Database (TMDb) is a community built movie and TV database. Every piece of data has been added by our amazing community dating back to 2008. TMDb's strong international focus and breadth of data is largely unmatched and something we're incredibly proud of. Put simply, we live and breathe community and that's precisely what makes us different."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.peripheral")
                        , settingsBlock "Joystick Support" "This library provides joystick drivers and button maps. Multiple joystick APIs are supported, including DirectX, XInput, SDL and the Linux Joystick API."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.python.pluginsource")
                        , settingsBlock "YouTube" "YouTube is one of the biggest video-sharing websites of the world."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.addon.repository")
                        , settingsBlock "Kodi Add-on repository" "Download and install add-ons from the Official Kodi.tv add-on repository.[CR]  By using the official Repository you will be able to take advantage of our extensive file mirror service to help get you faster downloads from a region close to you.[CR]  All add-ons on this repository have under gone basic testing, if you find a broken or not working add-on please report it to Team Kodi so we can take any action needed."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.resource.images")
                        , settingsBlock "Weather Icons - Default" "Default set of Weather Icons shipped with Kodi"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.resource.language")
                        , settingsBlock "English" "English version of all texts used in Kodi"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "kodi.resource.uisounds")
                        , settingsBlock "Kodi UI Sounds" "Kodi GUI Sounds"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.ui.screensaver")
                        , settingsBlock "Black" "Black is a simple screensaver that will turn your screen black."
                        , settingsBlock "Dim" "The Dim screensaver is a simple screensaver that will dim (fade out) your screen to a setable value between 20 and 100% ."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.python.module")
                        , settingsBlock "certifi" "Certifi is a carefully curated collection of Root Certificates for validating the trustworthiness of SSL certificates while verifying the identity of TLS hosts. It has been extracted from the Requests project."
                        , settingsBlock "chardet" "The Universal Character Encoding Detector"
                        , settingsBlock "idna" "Internationalized Domain Names for Python"
                        , settingsBlock "Python Image Library" ""
                        , settingsBlock "Python Crypto Library" ""
                        , settingsBlock "requests" "Requests is an elegant and simple HTTP library for Python, built for human beings."
                        , settingsBlock "six" "Six is a Python 2 and 3 compatibility library. It provides utility functions for smoothing over the differences between the Python versions with the goal of writing Python code that is compatible on both Python versions. See the documentation for more information on what is provided."
                        , settingsBlock "urllib3" "urllib3 is a powerful, user-friendly HTTP client for Python. Much of the Python ecosystem already uses urllib3 and you should too. urllib3 brings many critical features that are missing from the Python standard libraries"

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.service")
                        , settingsBlock "Version Check" "Kodi Version Check only supports a number of platforms/distros as releases may differ between them. For more information visit the kodi.tv website."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.gui.skin")
                        , settingsBlock "Estouchy" "Skin designed to be used on touchscreen devices like tablets and smartphones"
                        , settingsBlock "Estuary" "Estuary is the default skin for Kodi 17.0 and above. It attempts to be easy for first time Kodi users to understand and use."

                        , el[ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach {top = 0, bottom = 30, left = 0, right = 0}](text "xbmc.webinterface")
                        , settingsBlock "Kodi web interface - Chorus2" "Browse and interact with your Music, Movies, TV Shows and more via a web browser. Stream music and videos on your browser. Edit and manage your Kodi media library."

                        , row[ width fill,Background.color Colors.headerBackground, paddingXY 20 25][
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


settingsBlock : String -> String -> Element msg
settingsBlock title description =
  if description == "" then
  column[ paddingEach {top = 0, bottom = 30, left = 20, right = 20}][
    row[paddingEach {top = 0, bottom = 0, left = 0, right = 0}][
      el[Font.size 14, Font.color (rgb255 3 3 3), Font.medium](text title)
    ]
  ]
  else
    column[ paddingEach {top = 0, bottom = 30, left = 20, right = 20}][
      row[paddingEach {top = 0, bottom = 20, left = 0, right = 0}][
        el[Font.size 14, Font.color (rgb255 3 3 3), Font.medium](text title)
      ],
      row[][
        el[width (px 300)](text "")
      , paragraph[width (px 400), Font.size 12, Font.color (rgb255 142 142 142)][text description]
      ]
    ]
