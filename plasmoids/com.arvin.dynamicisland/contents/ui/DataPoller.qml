import QtQuick 2.15
import org.kde.plasma.private.mpris as Mpris
import org.kde.plasma.plasma5support as P5Support
import "../code/format.js" as Format

// Robust Cache & MPRIS Ingestion Engine for Dynamic Island
// Uses P5Support.DataSource (executable) to safely read JSON files on Qt 6 / Wayland
// with zero XMLHttpRequest security blocks or file:// restriction failures.
Item {
    id: poller

    property var islandRoot
    property var mprisModel
    property string homeDirectory: ""

    readonly property string sysJsonFile: homeDirectory + "/.cache/dynamic-island-sys.json"
    readonly property string mediaJsonFile: homeDirectory + "/.cache/dynamic-island-media.json"
    readonly property string installJsonFile: homeDirectory + "/.cache/dynamic-island-install.json"
    readonly property string llmJsonFile: homeDirectory + "/.cache/dynamic-island-llm.json"

    P5Support.DataSource {
        id: fileSource
        engine: "executable"
        connectedSources: []
        function fetch(cmd) {
            connectSource(cmd)
        }
        onNewData: function(sourceName, data) {
            disconnectSource(sourceName)
            if (!data || !data["stdout"]) return
            var raw = String(data["stdout"]).trim()
            if (!raw) return
            try {
                var o = JSON.parse(raw)
                if (sourceName.indexOf("sys.json") !== -1) {
                    if (islandRoot) islandRoot.sysData = o
                } else if (sourceName.indexOf("media.json") !== -1) {
                    poller.processMediaJson(o)
                } else if (sourceName.indexOf("install.json") !== -1) {
                    if (islandRoot) {
                        islandRoot.installData = o
                        if (islandRoot.userSticky === "install" && !islandRoot.installModeActive)
                            islandRoot.userSticky = ""
                    }
                } else if (sourceName.indexOf("llm.json") !== -1) {
                    if (islandRoot) {
                        islandRoot.llmData = o
                        poller.updatePillLlmDisplay(o)
                        if (islandRoot.userSticky === "llm" && !islandRoot.llmModeActive)
                            islandRoot.userSticky = ""
                    }
                }
            } catch(e) {}
        }
    }

    function processMediaJson(o) {
        if (!islandRoot) return
        var live = mprisModel ? mprisModel.currentPlayer : null
        if (live && live.playbackStatus !== Mpris.PlaybackStatus.Playing && o)
            o = Object.assign({}, o, { playing: false })
        islandRoot.mediaData = o
        if (o && o.playing && o.title && islandRoot.activePlayer === "" && !live)
            islandRoot.mediaText = o.title + (o.artist ? (" - " + o.artist) : "")
        if (!o || !o.playing) {
            if (islandRoot.activePlayer === "" && islandRoot.mediaText !== "")
                islandRoot.mediaText = ""
            if (islandRoot.userSticky === "media")
                islandRoot.userSticky = ""
        }
    }

    function updatePillLlmDisplay(o) {
        if (!islandRoot) return
        if (!o) {
            islandRoot.pillLlmModel = ""
            islandRoot.pillLlmPhase = "idle"
            islandRoot.pillLlmTps = 0
            return
        }
        var model = String(o.model || "")
        var phase = String(o.phase || "idle")
        var tps = Number(o.tokens_per_second || 0)
        islandRoot.pillLlmModel = model

        if (phase === "idle") {
            islandRoot.pillLlmPhase = "idle"
            islandRoot.pillLlmTps = 0
            return
        }

        islandRoot.pillLlmPhase = "processing"
        if (tps > 0) {
            if (islandRoot.pillLlmTps <= 0 || Math.abs(tps - islandRoot.pillLlmTps) >= 1.5)
                islandRoot.pillLlmTps = Math.round(tps * 10) / 10
        } else {
            islandRoot.pillLlmTps = 0
        }
    }

    function syncMprisPlayer() {
        if (!islandRoot) return
        var player = mprisModel ? mprisModel.currentPlayer : null
        if (!player) {
            if (islandRoot.activePlayer !== "") {
                islandRoot.activePlayer = ""
                islandRoot.playerIdentity = ""
                islandRoot.playerPid = 0
                islandRoot.mediaText = ""
            }
            return
        }

        if (player.playbackStatus !== Mpris.PlaybackStatus.Playing) {
            if (islandRoot.activePlayer !== "" || islandRoot.mediaText !== "") {
                islandRoot.activePlayer = ""
                islandRoot.playerIdentity = ""
                islandRoot.playerPid = 0
                islandRoot.mediaText = ""
            }
            if (islandRoot.mediaData && islandRoot.mediaData.playing === true)
                islandRoot.mediaData = Object.assign({}, islandRoot.mediaData, { playing: false })
            if (islandRoot.userSticky === "media")
                islandRoot.userSticky = ""
            return
        }

        var artist = player.artist || ""
        var title = player.track || ""
        if (!title) return

        islandRoot.activePlayer = player.desktopEntry || player.identity || "media"
        islandRoot.playerIdentity = player.identity || ""
        islandRoot.playerPid = player.kdePid || 0
        var mediaInfo = artist ? (artist + " - " + title) : title
        var formattedInfo = Format.formatMediaText(mediaInfo)
        if (formattedInfo !== islandRoot.mediaText)
            islandRoot.mediaText = formattedInfo
    }

    function readJsonCaches() {
        if (!islandRoot) return
        fileSource.fetch("cat \"" + sysJsonFile + "\" 2>/dev/null")
        fileSource.fetch("cat \"" + mediaJsonFile + "\" 2>/dev/null")
        fileSource.fetch("cat \"" + installJsonFile + "\" 2>/dev/null")
        fileSource.fetch("cat \"" + llmJsonFile + "\" 2>/dev/null")
    }

    // Poller timer for system JSON caches
    Timer {
        id: filePoller
        interval: 350
        running: true
        repeat: true
        onTriggered: poller.readJsonCaches()
    }

    // Backup poll for MPRIS
    Timer {
        interval: 300
        running: true
        repeat: true
        onTriggered: poller.syncMprisPlayer()
    }

    Connections {
        target: poller.mprisModel
        function onCurrentPlayerChanged() {
            poller.syncMprisPlayer()
        }
    }

    Connections {
        target: poller.mprisModel ? poller.mprisModel.currentPlayer : null
        enabled: poller.mprisModel !== null && poller.mprisModel.currentPlayer !== null
        function onTrackChanged() { poller.syncMprisPlayer() }
        function onArtistChanged() { poller.syncMprisPlayer() }
        function onPlaybackStatusChanged() { poller.syncMprisPlayer() }
        function onIdentityChanged() { poller.syncMprisPlayer() }
        function onDesktopEntryChanged() { poller.syncMprisPlayer() }
    }
}
