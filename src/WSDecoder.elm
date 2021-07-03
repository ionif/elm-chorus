module WSDecoder exposing (AlbumObj, ArtistObj, Connection(..), FileObj, FileType(..), Item, ItemDetails, LeftSidebarMenuHover(..), LocalPlaylists, MovieObj, PType(..), ParamsResponse, Path, PlayerObj(..), PlaylistObj, ResultResponse(..), SongObj, SourceObj, TvshowObj, localPlaylistDecoder, localPlaylistEncoder, paramsResponseDecoder, prepareDownloadDecoder, resultResponseDecoder)

import Json.Decode as Decode exposing (Decoder, at, bool, float, int, list, maybe, string)
import Json.Decode.Pipeline exposing (custom, optional, required)
import Json.Encode as Encode
import Method exposing (Method(..), methodToStr, strToMethod)



-----------------------
-- "params" response --
-----------------------
-- Item


type alias Item =
    { id : Int
    , itype : String
    }


itemDecoder : Decoder Item
itemDecoder =
    Decode.succeed Item
        |> required "id" int
        |> required "type" string



-- Player
-- PType


type PType
    = Audio
    | Video


parsePType : String -> Result String PType
parsePType string =
    case string of
        "audio" ->
            Ok Audio

        "video" ->
            Ok Video

        _ ->
            Err ("Invalid direction: " ++ string)


fromResult : Result String a -> Decoder a
fromResult result =
    case result of
        Ok a ->
            Decode.succeed a

        Err errorMessage ->
            Decode.fail errorMessage


pTypeDecoder : Decoder PType
pTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parsePType)



-- Player Type


type PlayerType
    = Internal
    | External


parsePlayerType : String -> Result String PlayerType
parsePlayerType string =
    case string of
        "internal" ->
            Ok Internal

        "external" ->
            Ok External

        _ ->
            Err ("Invalid direction: " ++ string)


playerTypeDecoder : Decoder PlayerType
playerTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parsePlayerType)



{-
   PlayerObj =
       playerid : Int
       speed : Int
       playertype : Maybe PlayerType
       ptype : Maybe PType
-}
--variants A and B have different shape


type PlayerObj
    = PlayerA Int Int
    | PlayerB Int PlayerType PType


playerSpdDecoder : Decoder PlayerObj
playerSpdDecoder =
    Decode.succeed PlayerA
        |> required "playerid" int
        |> required "speed" int


playerwoSpdDecoder : Decoder PlayerObj
playerwoSpdDecoder =
    Decode.succeed PlayerB
        |> required "playerid" int
        |> required "playertype" playerTypeDecoder
        |> required "type" pTypeDecoder


playerDecoder : Decoder PlayerObj
playerDecoder =
    Decode.oneOf [ playerSpdDecoder, playerwoSpdDecoder ]



-- Params Response


type alias ParamsResponse =
    { item : Item
    , player : PlayerObj
    }


paramsResponseDecoder : Decoder ParamsResponse
paramsResponseDecoder =
    Decode.succeed ParamsResponse
        |> custom (at [ "params", "data", "item" ] itemDecoder)
        |> custom (at [ "params", "data", "player" ] playerDecoder)



-- end "params"
-----------------------
-- "result" response --
-----------------------


type ResultResponse
    = ResultA String
    | ResultB (List PlayerObj)
    | ResultC ItemDetails
    | ResultD (List SongObj)
    | ResultE (List ArtistObj)
    | ResultF (List AlbumObj)
    | ResultG (List MovieObj)
    | ResultH Float Int --percentage/speed
    | ResultI (List SourceObj)
    | ResultJ Bool Float --muted/volume
    | ResultK (List FileObj)



--main decoder which tries everyone else


resultResponseDecoder : Decoder ResultResponse
resultResponseDecoder =
    Decode.oneOf [ stringDecoder, listDecoder, detailDecoder, queryDecoder ]


stringDecoder : Decoder ResultResponse
stringDecoder =
    Decode.succeed ResultA
        |> required "result" string


listDecoder : Decoder ResultResponse
listDecoder =
    Decode.succeed ResultB
        |> required "result" (list playerDecoder)



-- Song/Video GetItem decoder


detailDecoder : Decoder ResultResponse
detailDecoder =
    Decode.succeed ResultC
        |> required "result" itemDetailDecoder


itemDetailDecoder : Decoder ItemDetails
itemDetailDecoder =
    Decode.succeed ItemDetails
        |> custom (at [ "item", "title" ] string)
        |> custom (at [ "item", "artist" ] (list string))
        |> custom (at [ "item", "duration" ] int)
        |> custom (at [ "item", "thumbnail" ] string)


type alias ItemDetails =
    { title : String
    , artist : List String
    , duration : Int
    , thumbnail : String
    }



--queries decoder


queryDecoder : Decoder ResultResponse
queryDecoder =
    Decode.oneOf
        [ percentDecoder
        , songQueryDecoder
        , artistQueryDecoder
        , albumQueryDecoder
        , movieQueryDecoder
        , sourceQueryDecoder
        , volumeDecoder
        , fileQueryDecoder
        ]


songQueryDecoder : Decoder ResultResponse
songQueryDecoder =
    Decode.succeed ResultD
        |> custom (at [ "result", "songs" ] (list songDecoder))


songDecoder : Decoder SongObj
songDecoder =
    Decode.succeed SongObj
        |> required "label" string
        |> required "artist" (list string)
        |> required "duration" int
        |> required "songid" int
        |> required "albumid" int
        |> required "genre" (list string)


type alias SongObj =
    { label : String
    , artist : List String
    , duration : Int
    , songid : Int
    , albumid : Int
    , genre : List String
    }


artistQueryDecoder : Decoder ResultResponse
artistQueryDecoder =
    Decode.succeed ResultE
        |> custom (at [ "result", "artists" ] (list artistDecoder))


artistDecoder : Decoder ArtistObj
artistDecoder =
    Decode.succeed ArtistObj
        |> required "label" string
        |> required "artistid" int
        |> required "thumbnail" string
        |> required "genre" (list string)


type alias ArtistObj =
    { label : String
    , artistid : Int
    , thumbnail : String
    , genre : List String
    }


albumQueryDecoder : Decoder ResultResponse
albumQueryDecoder =
    Decode.succeed ResultF
        |> custom (at [ "result", "albums" ] (list albumDecoder))


albumDecoder : Decoder AlbumObj
albumDecoder =
    Decode.succeed AlbumObj
        |> required "label" string
        |> required "albumid" int
        |> required "artist" (list string)
        |> required "thumbnail" string
        |> required "genre" (list string)
        |> required "playcount" int
        |> required "dateadded" string


type alias AlbumObj =
    { label : String
    , albumid : Int
    , artist : List String
    , thumbnail : String
    , genre : List String
    , playcount : Int
    , dateadded : String
    }

settingsDecoder : Decoder SettingsObj
settingsDecoder =
    Decode.succeed SettingsObj
      |> required "gamesgeneral.enableautosave" bool
      |> required "gamesgeneral.enablerewind" bool
      |> required "lookandfeel.skin" addon
      |> required "lookandfeel.skinsettings" action
      |> required "lookandfeel.skintheme" string
      |> required "lookandfeel.skincolors" string
      |> required "lookandfeel.font" string
      |> required "lookandfeel.skinzoom" int
      |> required "lookandfeel.enablerssfeeds" bool
      |> required "lookandfeel.rssedit" string
      |> required "locale.language" addon
      |> required "locale.charset" string
      |> required "locale.keyboardlayouts" (list string)
      |> required "locale.country" string
      |> required "locale.timezonecountry" string
      |> required "locale.timezone" string
      |> required "screensaver.mode" addon
      |> required "screensaver.settings" action
      |> required "screensaver.preview" action
      |> required "screensaver.time" int
      |> required "screensaver.usemusicvisinstead" bool
      |> required "screensaver.usedimonpause" bool
      |> required "masterlock.lockcode" action
      |> required "masterlock.startuplock" bool
      |> required "lookandfeel.startupaction" int
      |> required "lookandfeel.startupwindow" int
      |> required "source.videos" action
      |> required "source.music" action
      |> required "source.pictures" action
      |> required "videolibrary.updateonstartup" bool
      |> required "videolibrary.backgroundupdate" bool
      |> required "musiclibrary.updateonstartup" bool
      |> required "musiclibrary.backgroundupdate" bool
      |> required "filelists.showparentdiritems" bool
      |> required "filelists.ignorethewhensorting" bool
      |> required "filelists.showextention" bool
      |> required "filelists.showaddsourcebuttons" bool
      |> required "myvideos.selectaction" int
      |> required "myvideos.stackvideos" bool
      |> required "myvideos.replacelabels" bool
      |> required "videolibrary.showunwatchedplots" (list int)
      |> required "videolibrary.groupmoviesets" bool
      |> required "videolibrary.groupsingleitemsets" bool
      |> required "videolibrary.moviesetsfolder" path
      |> required "videolibrary.musicvideosallperformers" bool
      |> required "videolibrary.artworklevel" int
      |> required "myvideos.extractthumb" bool
      |> required "musiclibrary.showcompilationartists" bool
      |> required "musiclibrary.showdiscs" bool
      |> required "musiclibrary.useartistsortnames" bool
      |> required "musiclibrary.artistsfolder" path
      |> required "musiclibrary.albumsscraper" addon
      |> required "musiclibrary.artistsscraper" addon
      |> required "musiclibrary.overridetags" bool
      |> required "musiclibrary.artworklevel" int
      |> required "musiclibrary.preferonlinealbumart" bool
      |> required "musicfiles.selectaction" bool
      |> required "musicfiles.usetags" bool
      |> required "pictures.usetags" bool
      |> required "pictures.generatethumbs" bool
      |> required "pictures.showvideos" bool
      |> required "videoplayer.autoplaynextitem" (list int)
      |> required "videoplayer.seeksteps" (list int)
      |> required "videoplayer.seekdelay" int
      |> required "videoplayer.adjustrefreshrate" int
      |> required "videoplayer.usedisplaysclock" bool
      |> required "musicplayer.autoplaynextitem" bool
      |> required "musicplayer.queuebydefault" bool
      |> required "musicplayer.seeksteps" (list int)
      |> required "musicplayer.seekdelay" int
      |> required "musicplayer.crossfade" int
      |> required "musicplayer.crossfadealbumtracks" bool
      |> required "musicplayer.visualisation" addon
      |> required "dvds.autorun" bool
      |> required "dvds.playerregion" int
      |> required "bluray.playerregion" int
      |> required "disc.playback" int
      |> required "audiocds.autoaction" int
      |> required "audiocds.usecddb" bool
      |> required "slideshow.staytime" int
      |> required "slideshow.displayeffects" bool
      |> required "slideshow.shuffle" bool
      |> required "slideshow.highqualitydownscaling" bool
      |> required "locale.audiolanguage" string
      |> required "videoplayer.preferdefaultflag" bool
      |> required "locale.subtitlelanguage" string
      |> required "subtitles.parsecaptions" bool
      |> required "subtitles.font" string
      |> required "subtitles.charset" string
      |> required "subtitles.languages" (list string)
      |> required "subtitles.tv" addon
      |> required "subtitles.movie" addon
      |> required "accessibility.audiovisual" bool
      |> required "accessibility.audiohearing" bool
      |> required "accessibility.subhearing" bool
      |> required "pvrmanager.preselectplayingchannel" bool
      |> required "pvrmanager.syncchannelgroups" bool
      |> required "pvrmanager.channelmanager" action
      |> required "pvrmanager.groupmanager" action
      |> required "pvrmanager.channelscan" action
      |> required "pvrmanager.resetdb" action
      |> required "pvrmenu.searchicons" action
      |> required "epg.selectaction" int
      |> required "epg.resetepg" action
      |> required "pvrplayback.switchtofullscreenchanneltypes" int
      |> required "pvrplayback.confirmchannelswitch" bool
      |> required "pvrplayback.fps" int
      |> required "pvrplayback.enableradiords" bool
      |> required "pvrplayback.trafficadvisory" bool
      |> required "pvrrecord.instantrecordaction" int
      |> required "pvrrecord.instantrecordtime" int
      |> required "pvrreminders.autoclosedelay" int
      |> required "pvrreminders.autorecord" bool
      |> required "pvrreminders.autoswitch" bool
      |> required "pvrclient.menuhook" action
      |> required "service.devicename" string
      |> required "services.zeroconf" bool
      |> required "services.webserver" bool
      |> required "services.webserverport" int
      |> required "services.webserverauthentication" bool
      |> required "services.webserverusername" string
      |> required "services.webserverpassword" string
      |> required "services.webserverssl" bool
      |> required "services.webskin" addon
      |> required "services.esenabled" bool
      |> required "services.esallinterfaces" bool
      |> required "services.upnp" bool
      |> required "services.upnpserver" bool
      |> required "services.upnprenderer" bool
      |> required "services.airplay" bool
      |> required "services.useairplaypassword" bool
      |> required "services.airplaypassword" string
      |> required "weather.addon" addon
      |> required "weather.addonsettings" action
      |> required "videoscreen.monitor" string
      |> required "videoscreen.screen" int
      |> required "videoscreen.resolution" int
      |> required "videoscreen.blankdisplays" bool
      |> required "audiooutput.audiodevice" string
      |> required "audiooutput.channels" int
      |> required "audiooutput.volumesteps" int
      |> required "audiooutput.guisoundmode" int
      |> required "lookandfeel.soundskin" addon
      |> required "input.peripherals" action
      |> required "input.peripherallibraries" action
      |> required "input.controllerconfig" action
      |> required "network.usehttpproxy" bool
      |> required "network.usehttpproxytype" int
      |> required "network.usehttpproxyserver" string
      |> required "network.usehttpproxyport" int
      |> required "network.usehttpproxyusername" string
      |> required "network.usehttpproxypassword" string
      |> required "network.bandwidth" int
      |> required "powermanagement.displayoff" int
      |> required "powermanagement.wakeonaccess" bool
      |> required "general.addonupdates" int
      |> required "general.addonnotifications" bool
      |> required "addons.unknownsources" bool
      |> required "addons.updatemode" int
      |> required "debug.showloginfo" bool
      |> required "debug.extralogging" bool
      |> required "debug.setextraloglevel" (list int)
      |> required "debug.screenshotpath" path
      |> required "eventlog.enabled" bool
      |> required "eventlog.enablenotifications" bool
      |> required "eventlog.show" action

type alias Addon = {

}

type alias Action = {

}

type alias Path = {

}


type alias SettingsObj =
    { gamesgeneral.enableautosave : Bool
    , gamesgeneral.enablerewind : Bool
    , lookandfeel.skin : Addon
    , lookandfeel.skinsettings : Action
    , lookandfeel.skintheme : String
    , lookandfeel.skincolors : String
    , lookandfeel.font : String
    , lookandfeel.skinzoom : Int
    , lookandfeel.enablerssfeeds : Bool
    , lookandfeel.rssedit : String
    , locale.language : Addon
    , locale.charset : String
    , locale.keyboardlayouts : List String
    , locale.country : String
    , locale.timezonecountry : String
    , locale.timezone : String
    , screensaver.mode : Addon
    , screensaver.settings : Action
    , screensaver.preview : Action
    , screensaver.time : Int
    , screensaver.usemusicvisinstead : Bool
    , screensaver.usedimonpause : Bool
    , masterlock.lockcode : Action
    , masterlock.startuplock : Bool
    , lookandfeel.startupaction : Int
    , lookandfeel.startupwindow : Int
    , source.videos : Action
    , source.music : Action
    , source.pictures : Action
    , videolibrary.updateonstartup : Bool
    , videolibrary.backgroundupdate : Bool
    , musiclibrary.updateonstartup : Bool
    , musiclibrary.backgroundupdate : Bool
    , filelists.showparentdiritems : Bool
    , filelists.ignorethewhensorting : Bool
    , filelists.showextention : Bool
    , filelists.showaddsourcebuttons : Bool
    , myvideos.selectaction : Int
    , myvideos.stackvideos : Bool
    , myvideos.replacelabels : Bool
    , videolibrary.showunwatchedplots : List Int
    , videolibrary.groupmoviesets : Bool
    , videolibrary.groupsingleitemsets : Bool
    , videolibrary.moviesetsfolder : Path
    , videolibrary.musicvideosallperformers : Bool
    , videolibrary.artworklevel : Int
    , myvideos.extractthumb : Bool
    , musiclibrary.showcompilationartists : Bool
    , musiclibrary.showdiscs : Bool
    , musiclibrary.useartistsortnames : Bool
    , musiclibrary.artistsfolder : Path
    , musiclibrary.albumsscraper : Addon
    , musiclibrary.artistsscraper : Addon
    , musiclibrary.overridetags : Bool
    , musiclibrary.artworklevel : Int
    , musiclibrary.preferonlinealbumart : Bool
    , musicfiles.selectaction : Bool
    , musicfiles.usetags : Bool
    , pictures.usetags : Bool
    , pictures.generatethumbs : Bool
    , pictures.showvideos : Bool
    , videoplayer.autoplaynextitem : List Int
    , videoplayer.seeksteps : List Int
    , videoplayer.seekdelay : Int
    , videoplayer.adjustrefreshrate : Int
    , videoplayer.usedisplaysclock : Bool
    , musicplayer.autoplaynextitem : Bool
    , musicplayer.queuebydefault : Bool
    , musicplayer.seeksteps : List Int
    , musicplayer.seekdelay : Int
    , musicplayer.crossfade : Int
    , musicplayer.crossfadealbumtracks : Bool
    , musicplayer.visualisation : Addon
    , dvds.autorun : Bool
    , dvds.playerregion : Int
    , bluray.playerregion : Int
    , disc.playback : Int
    , audiocds.autoaction : Int
    , audiocds.usecddb : Bool
    , slideshow.staytime : Int
    , slideshow.displayeffects : Bool
    , slideshow.shuffle : Bool
    , slideshow.highqualitydownscaling : Bool
    , locale.audiolanguage : String
    , videoplayer.preferdefaultflag : Bool
    , locale.subtitlelanguage : String
    , subtitles.parsecaptions : Bool
    , subtitles.font : String
    , subtitles.charset : String
    , subtitles.languages : List String
    , subtitles.tv : Addon
    , subtitles.movie : Addon
    , accessibility.audiovisual : Bool
    , accessibility.audiohearing : Bool
    , accessibility.subhearing : Bool
    , pvrmanager.preselectplayingchannel : Bool
    , pvrmanager.syncchannelgroups : Bool
    , pvrmanager.channelmanager : Action
    , pvrmanager.groupmanager : Action
    , pvrmanager.channelscan : Action
    , pvrmanager.resetdb : Action
    , pvrmenu.searchicons : Action
    , epg.selectaction : Int
    , epg.resetepg : Action
    , pvrplayback.switchtofullscreenchanneltypes : Int
    , pvrplayback.confirmchannelswitch : Bool
    , pvrplayback.fps : Int
    , pvrplayback.enableradiords : Bool
    , pvrplayback.trafficadvisory : Bool
    , pvrrecord.instantrecordaction : Int
    , pvrrecord.instantrecordtime : Int
    , pvrreminders.autoclosedelay : Int
    , pvrreminders.autorecord : Bool
    , pvrreminders.autoswitch : Bool
    , pvrclient.menuhook : Action
    , service.devicename : String
    , services.zeroconf : Bool
    , services.webserver : Bool
    , services.webserverport : Int
    , services.webserverauthentication : Bool
    , services.webserverusername : String
    , services.webserverpassword : String
    , services.webserverssl : Bool
    , services.webskin : Addon
    , services.esenabled : Bool
    , services.esallinterfaces : Bool
    , services.upnp : Bool
    , services.upnpserver : Bool
    , services.upnprenderer : Bool
    , services.airplay : Bool
    , services.useairplaypassword : Bool
    , services.airplaypassword : String
    , weather.addon : Addon
    , weather.addonsettings : Action
    , videoscreen.monitor : String
    , videoscreen.screen : Int
    , videoscreen.resolution : Int
    , videoscreen.blankdisplays : Bool
    , audiooutput.audiodevice : String
    , audiooutput.channels : Int
    , audiooutput.volumesteps : Int
    , audiooutput.guisoundmode : Int
    , lookandfeel.soundskin : Addon
    , input.peripherals : Action
    , input.peripherallibraries : Action
    , input.controllerconfig : Action
    , network.usehttpproxy : Bool
    , network.usehttpproxytype : Int
    , network.usehttpproxyserver : String
    , network.usehttpproxyport : Int
    , network.usehttpproxyusername : String
    , network.usehttpproxypassword : String
    , network.bandwidth : Int
    , powermanagement.displayoff : Int
    , powermanagement.wakeonaccess : Bool
    , general.addonupdates : Int
    , general.addonnotifications : Bool
    , addons.unknownsources : Bool
    , addons.updatemode : Int
    , debug.showloginfo : Bool
    , debug.extralogging : Bool
    , debug.setextraloglevel : List Int
    , debug.screenshotpath : Path
    , eventlog.enabled : Bool
    , eventlog.enablenotifications : Bool
    , eventlog.show : Action
    }


movieQueryDecoder : Decoder ResultResponse
movieQueryDecoder =
    Decode.succeed ResultG
        |> custom (at [ "result", "movies" ] (list movieDecoder))


movieDecoder : Decoder MovieObj
movieDecoder =
    Decode.succeed MovieObj
        |> required "label" string
        |> required "movieid" int
        |> required "thumbnail" string
        |> required "file" string


type alias MovieObj =
    { label : String
    , movieid : Int
    , thumbnail : String
    , file : String
    }


type alias TvshowObj =
    { label : String
    , tvshowid : Int
    , thumbnail : String
    }


percentDecoder : Decoder ResultResponse
percentDecoder =
    Decode.succeed ResultH
        |> custom (at [ "result", "percentage" ] float)
        |> custom (at [ "result", "speed" ] int)


sourceQueryDecoder : Decoder ResultResponse
sourceQueryDecoder =
    Decode.succeed ResultI
        |> custom (at [ "result", "sources" ] (list sourceDecoder))


sourceDecoder : Decoder SourceObj
sourceDecoder =
    Decode.succeed SourceObj
        |> required "label" string
        |> required "file" string


type alias SourceObj =
    { label : String
    , file : String
    }


volumeDecoder : Decoder ResultResponse
volumeDecoder =
    Decode.succeed ResultJ
        |> custom (at [ "result", "muted" ] bool)
        |> custom (at [ "result", "volume" ] float)


fileQueryDecoder : Decoder ResultResponse
fileQueryDecoder =
    Decode.succeed ResultK
        |> custom (at [ "result", "files" ] (list fileDecoder))


type alias FileObj =
    { label : String
    , file : String
    , filetype : FileType
    }


fileDecoder : Decoder FileObj
fileDecoder =
    Decode.succeed FileObj
        |> required "label" string
        |> required "file" string
        |> required "filetype" fileTypeDecoder



-- file Type


type FileType
    = Directory
    | File


parseFileType : String -> Result String FileType
parseFileType string =
    case string of
        "directory" ->
            Ok Directory

        "file" ->
            Ok File

        _ ->
            Err ("Invalid filetype: " ++ string)


fileTypeDecoder : Decoder FileType
fileTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parseFileType)



-- LeftSidebar Icon Hover type


type LeftSidebarMenuHover
    = NoneHover
    | Music
    | Movies
    | TVShow
    | Playlist
    | Browser
    | ThumbsUp
    | Addons
    | Settings
    | Help



--kodi ws connection


type Connection
    = Connected
    | Disconnected
    | NotAsked



--local playlist encode/decode


type alias LocalPlaylists =
    { localPlaylists : List PlaylistObj }


localPlaylistDecoder : Decoder LocalPlaylists
localPlaylistDecoder =
    Decode.succeed LocalPlaylists
        |> required "localPlaylists" (list playlistObjDecoder)


localPlaylistEncoder : LocalPlaylists -> String
localPlaylistEncoder localPlaylist =
    Encode.encode 0 <|
        Encode.object
            [ ( "localPlaylists", Encode.list playlistObjEncoder localPlaylist.localPlaylists )
            ]


type alias PlaylistObj =
    { name : String
    , songs : List Int --store songids
    }


playlistObjDecoder : Decoder PlaylistObj
playlistObjDecoder =
    Decode.succeed PlaylistObj
        |> required "name" string
        |> required "songs" (list int)


playlistObjEncoder : PlaylistObj -> Encode.Value
playlistObjEncoder playlistObj =
    Encode.object
        [ ( "name", Encode.string playlistObj.name )
        , ( "songs", Encode.list Encode.int (List.map (\song -> song) playlistObj.songs) )
        ]



-- Files.PrepareDownload decoder


prepareDownloadDecoder : Decoder Path
prepareDownloadDecoder =
    Decode.succeed Path
        |> custom (at [ "result", "details", "path" ] string)


type alias Path =
    { path : String }



{- introspectDecoder : Decoder ResultResponse
   introspectDecoder =
           Decode.succeed ResultC
               |> required "methods" (firstFieldAs introspectObjDecoder)

   introspectObjDecoder : Decoder IntrospectObj
   introspectObjDecoder =
       Decode.succeed IntrospectObj
           |> required "params" (list paramsIntrospectDecoder)
           --|> required "returns" returnsIntrospectDecoder

   paramsIntrospectDecoder : Decoder ParamsItem
   paramsIntrospectDecoder =
       Decode.succeed ParamsItem
           |> required "name" string

   type alias ParamsItem =
       { name : String }

   type alias IntrospectObj =
       { description : String
       , params : List String
       , returns : String
       }

   firstFieldAs : Decoder a -> Decoder a
   firstFieldAs decoder =
     Decode.keyValuePairs decoder
       |> Decode.andThen (\pairs ->
         case pairs of
           [] -> Decode.fail "Empty Object"
           (_, value) :: _ ->  Decode.succeed value
       )
-}
-- end "result"
{- resultsDecoder : Decoder (List Result)
   resultsDecoder =
     Decode.oneOf
       [ Decode.list resultDecoder
       , Decode.map (\result -> [result]) resultDecoder
       ]
-}
