import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15

// Boring Notch 1:1 Apple-Grade Dynamic Island HUD
// OLED True Black (#000000), Apple SF Symbols vector glyphs,
// Dual-Pane Music Player + Calendar Strip + User Avatar Glance,
// and fluid spring physics morphing.
Item {
    id: root
    property var islandRoot

    // Active Tab: "nook" (Music + Calendar + Avatar) or "spaces" (Virtual Desktops + System Stats)
    property string activeTab: "nook"

    // Direct, reliable bindings to root data
    readonly property var media: (islandRoot && islandRoot.mediaData) ? islandRoot.mediaData : ({})
    readonly property var sys: (islandRoot && islandRoot.sysData) ? islandRoot.sysData : ({})
    readonly property bool isPlaying: islandRoot ? (islandRoot.mediaModeActive || (media && media.playing === true)) : false

    readonly property string curTitle: (media && media.title) ? media.title : "Not Playing"
    readonly property string curAlbum: (media && media.album) ? media.album : "Boring Notch"
    readonly property string curArtist: (media && media.artist) ? media.artist : "Apple Music"
    readonly property string artUrl: (media && media.art_url) ? media.art_url : ""

    readonly property bool isExpanded: islandRoot ? islandRoot.expanded : false

    // Apple Spring Morphing Dimensions
    readonly property real targetW: 640
    readonly property real targetH: 176

    property real morphHeight: isExpanded ? targetH : 0
    property real morphWidth: isExpanded ? targetW : 260

    Behavior on morphHeight {
        NumberAnimation {
            duration: root.isExpanded ? 360 : 200
            easing.type: root.isExpanded ? Easing.OutBack : Easing.OutCubic
            easing.overshoot: root.isExpanded ? 1.10 : 0.0
        }
    }

    Behavior on morphWidth {
        NumberAnimation {
            duration: root.isExpanded ? 360 : 220
            easing.type: root.isExpanded ? Easing.OutBack : Easing.OutCubic
            easing.overshoot: root.isExpanded ? 1.10 : 0.0
        }
    }

    implicitWidth: 640
    implicitHeight: morphHeight
    width: 640
    height: morphHeight
    clip: true

    // Master Notch Body:
    // Pure OLED Black, continuous 24px Apple squircle corners,
    // 1px sub-pixel hairline border (rgba(255,255,255,0.15))
    Rectangle {
        id: notchBody
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.morphWidth
        height: Math.max(1, root.morphHeight)
        radius: 24
        color: "#000000"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.15)
        clip: true
    }

    // ─── INTERNAL CONTENT: SCALED & FADED BY SPRING MORPH ──────────
    Column {
        id: mainColumn
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 14
        spacing: 12

        opacity: (root.morphHeight > 60) ? 1.0 : 0.0
        scale: (root.morphHeight > 60) ? 1.0 : 0.94

        Behavior on opacity {
            NumberAnimation { duration: root.isExpanded ? 220 : 100; easing.type: Easing.OutQuad }
        }
        Behavior on scale {
            NumberAnimation {
                duration: root.isExpanded ? 320 : 160
                easing.type: root.isExpanded ? Easing.OutBack : Easing.OutQuad
                easing.overshoot: root.isExpanded ? 1.08 : 0.0
            }
        }

        // ─── TOP BAR: TABS [ Nook / Spaces ] + CAMERA SENSOR + CONTROLS ───
        Item {
            width: parent.width
            height: 24

            // Top Left: Tabs [ Nook ] [ Spaces ]
            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                // Tab: Nook
                Rectangle {
                    width: 76
                    height: 24
                    radius: 12
                    color: root.activeTab === "nook" ? Qt.rgba(1, 1, 1, 0.18) : "transparent"
                    border.width: root.activeTab === "nook" ? 1 : 0
                    border.color: Qt.rgba(1, 1, 1, 0.22)

                    Row {
                        anchors.centerIn: parent
                        spacing: 5

                        MacIcon {
                            name: "cloud.fill"
                            size: 12
                            color: root.activeTab === "nook" ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.50)
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Nook"
                            color: root.activeTab === "nook" ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.50)
                            font.pixelSize: 11
                            font.weight: root.activeTab === "nook" ? Font.DemiBold : Font.Medium
                            font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.activeTab = "nook"
                    }
                }

                // Tab: Spaces
                Rectangle {
                    width: 84
                    height: 24
                    radius: 12
                    color: root.activeTab === "spaces" ? Qt.rgba(1, 1, 1, 0.18) : "transparent"
                    border.width: root.activeTab === "spaces" ? 1 : 0
                    border.color: Qt.rgba(1, 1, 1, 0.22)

                    Row {
                        anchors.centerIn: parent
                        spacing: 5

                        MacIcon {
                            name: "tray.fill"
                            size: 12
                            color: root.activeTab === "spaces" ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.50)
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Spaces"
                            color: root.activeTab === "spaces" ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.50)
                            font.pixelSize: 11
                            font.weight: root.activeTab === "spaces" ? Font.DemiBold : Font.Medium
                            font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.activeTab = "spaces"
                    }
                }
            }

            // Top Center: MacBook Physical Camera Notch Lens Dot
            Rectangle {
                anchors.centerIn: parent
                width: 12
                height: 12
                radius: 6
                color: "#08080C"
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.14)

                Rectangle {
                    anchors.centerIn: parent
                    width: 5
                    height: 5
                    radius: 2.5
                    color: "#0D2538"
                }
            }

            // Top Right: Settings Gear & Close Buttons
            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                // Settings Gear Icon
                Item {
                    width: 22
                    height: 22
                    anchors.verticalCenter: parent.verticalCenter

                    MacIcon {
                        anchors.centerIn: parent
                        name: "gearshape.fill"
                        size: 14
                        color: gearArea.containsMouse ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.55)
                    }

                    MouseArea {
                        id: gearArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: {
                            if (islandRoot) islandRoot.activateSystemMonitor()
                        }
                    }
                }

                // Close Button
                Rectangle {
                    width: 20
                    height: 20
                    radius: 10
                    color: closeArea.containsMouse ? Qt.rgba(1, 1, 1, 0.25) : Qt.rgba(1, 1, 1, 0.12)
                    anchors.verticalCenter: parent.verticalCenter

                    MacIcon {
                        anchors.centerIn: parent
                        name: "xmark"
                        size: 10
                        color: "#FFFFFF"
                    }

                    MouseArea {
                        id: closeArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onEntered: if (islandRoot) islandRoot.cancelCollapse()
                        onClicked: {
                            if (islandRoot) {
                                islandRoot.cancelCollapse()
                                islandRoot.expanded = false
                            }
                        }
                    }
                }
            }
        }

        // ─── TAB 1 CONTENT: THE 3-COLUMN NOOK LAYOUT ───────────────────
        Row {
            id: nookContentRow
            visible: root.activeTab === "nook"
            width: parent.width
            spacing: 14

            // ─── COLUMN 1: APPLE MUSIC PLAYER (~235px) ───
            Row {
                width: 235
                spacing: 12
                anchors.verticalCenter: parent.verticalCenter

                // Squircle Album Art with Red Apple Music Badge
                Item {
                    width: 68
                    height: 68
                    anchors.verticalCenter: parent.verticalCenter

                    // Atmospheric Ambient Glow behind artwork
                    Rectangle {
                        anchors.centerIn: parent
                        width: 64
                        height: 64
                        radius: 14
                        color: "#FC3C44"
                        opacity: root.isPlaying ? 0.40 : 0.0
                        scale: 1.25

                        Behavior on opacity {
                            NumberAnimation { duration: 300 }
                        }
                    }

                    Rectangle {
                        id: albumArtFrame
                        anchors.fill: parent
                        radius: 13
                        color: "#18181C"
                        border.width: 1
                        border.color: Qt.rgba(1, 1, 1, 0.14)
                        clip: true

                        Image {
                            id: coverImg
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            source: root.artUrl
                            visible: status === Image.Ready && source !== ""
                        }

                        // Fallback Gradient if artUrl not present
                        Rectangle {
                            anchors.fill: parent
                            visible: !coverImg.visible
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#4A1525" }
                                GradientStop { position: 1.0; color: "#140D18" }
                            }
                            MacIcon {
                                anchors.centerIn: parent
                                name: "applemusic"
                                size: 28
                                color: "#FFFFFF"
                            }
                        }
                    }

                    // Mini Red Apple Music Icon Badge at bottom right corner
                    Rectangle {
                        width: 20
                        height: 20
                        radius: 10
                        color: "#FC3C44" // Apple Music Red
                        border.width: 1.5
                        border.color: "#000000"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: -3
                        z: 10

                        MacIcon {
                            anchors.centerIn: parent
                            name: "applemusic"
                            size: 11
                            color: "#FFFFFF"
                        }
                    }
                }

                // Metadata & Playback Controls
                Column {
                    width: parent.width - 68 - 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3

                    Text {
                        width: parent.width
                        text: root.curTitle
                        color: "#FFFFFF"
                        font.pixelSize: 13
                        font.weight: Font.Bold
                        font.letterSpacing: -0.2
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                    }

                    Text {
                        width: parent.width
                        text: root.curAlbum
                        color: Qt.rgba(1, 1, 1, 0.60)
                        font.pixelSize: 11
                        font.weight: Font.Medium
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                    }

                    Text {
                        width: parent.width
                        text: root.curArtist
                        color: Qt.rgba(1, 1, 1, 0.45)
                        font.pixelSize: 10
                        font.weight: Font.Normal
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                    }

                    // Mini Track Seek Bar
                    Rectangle {
                        width: parent.width - 4
                        height: 3
                        radius: 1.5
                        color: Qt.rgba(1, 1, 1, 0.18)

                        Rectangle {
                            width: parent.width * (root.isPlaying ? 0.55 : 0.0)
                            height: parent.height
                            radius: 1.5
                            color: "#FFFFFF"
                        }
                    }

                    // Playback Controls Row: ⏮  ⏸/▶  ⏭  ♥
                    Row {
                        spacing: 12
                        topPadding: 3

                        Item {
                            width: 16
                            height: 16
                            anchors.verticalCenter: parent.verticalCenter

                            MacIcon {
                                anchors.centerIn: parent
                                name: "backward.fill"
                                size: 13
                                color: prevM.containsMouse ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.70)
                            }

                            MouseArea {
                                id: prevM
                                anchors.fill: parent
                                anchors.margins: -4
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked: if (islandRoot) islandRoot.mediaPrevious()
                            }
                        }

                        // Play/Pause Circle Button
                        Rectangle {
                            width: 24
                            height: 24
                            radius: 12
                            color: playM.containsMouse ? Qt.rgba(1, 1, 1, 0.25) : Qt.rgba(1, 1, 1, 0.14)
                            anchors.verticalCenter: parent.verticalCenter

                            MacIcon {
                                anchors.centerIn: parent
                                name: root.isPlaying ? "pause.fill" : "play.fill"
                                size: 13
                                color: "#FFFFFF"
                            }

                            MouseArea {
                                id: playM
                                anchors.fill: parent
                                anchors.margins: -4
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked: if (islandRoot) islandRoot.mediaPlayPause()
                            }
                        }

                        Item {
                            width: 16
                            height: 16
                            anchors.verticalCenter: parent.verticalCenter

                            MacIcon {
                                anchors.centerIn: parent
                                name: "forward.fill"
                                size: 13
                                color: nextM.containsMouse ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.70)
                            }

                            MouseArea {
                                id: nextM
                                anchors.fill: parent
                                anchors.margins: -4
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked: if (islandRoot) islandRoot.mediaNext()
                            }
                        }

                        Item {
                            width: 14
                            height: 14
                            anchors.verticalCenter: parent.verticalCenter

                            MacIcon {
                                anchors.centerIn: parent
                                name: "heart.fill"
                                size: 11
                                color: "#FF375F"
                            }
                        }
                    }
                }
            }

            // Vertical Divider 1
            Rectangle {
                width: 1
                height: 68
                color: Qt.rgba(1, 1, 1, 0.10)
                anchors.verticalCenter: parent.verticalCenter
            }

            // ─── COLUMN 2: CALENDAR & AGENDA GLANCE (~235px) ───
            Column {
                width: 235
                anchors.verticalCenter: parent.verticalCenter
                spacing: 7

                readonly property var now: new Date()
                readonly property var monthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                readonly property var dayLetters: ["S", "M", "T", "W", "T", "F", "S"]
                readonly property string curMonth: monthNames[now.getMonth()]
                readonly property int curDate: now.getDate()
                readonly property int curDayIdx: now.getDay()

                // Top Row: Month Label + 7-Day Strip
                Row {
                    spacing: 8
                    width: parent.width

                    Text {
                        text: parent.parent.curMonth
                        color: "#FFFFFF"
                        font.pixelSize: 15
                        font.weight: Font.Bold
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // 7-Day Strip
                    Row {
                        spacing: 4
                        anchors.verticalCenter: parent.verticalCenter

                        Repeater {
                            model: 7

                            Item {
                                readonly property int offset: index - 3
                                readonly property var targetDate: new Date(parent.parent.parent.now.getTime() + offset * 86400000)
                                readonly property bool isToday: offset === 0
                                readonly property string dLetter: parent.parent.parent.dayLetters[targetDate.getDay()]
                                readonly property string dNum: (targetDate.getDate() < 10 ? "0" : "") + targetDate.getDate()

                                width: isToday ? 28 : 20
                                height: 32

                                // Capsule highlight for today
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 7
                                    visible: isToday
                                    color: "#007AFF" // Apple Blue
                                }

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 1

                                    Text {
                                        text: isToday ? (targetDate.toLocaleDateString(Qt.locale(), "ddd").toUpperCase().slice(0, 3)) : dLetter
                                        color: isToday ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.40)
                                        font.pixelSize: isToday ? 7 : 8
                                        font.weight: isToday ? Font.Bold : Font.Normal
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                                    }

                                    Text {
                                        text: dNum
                                        color: isToday ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.70)
                                        font.pixelSize: isToday ? 11 : 9
                                        font.weight: isToday ? Font.Bold : Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                                    }
                                }
                            }
                        }
                    }
                }

                // Bottom Row: Calendar Icon + Agenda Summary
                Row {
                    spacing: 6
                    width: parent.width

                    MacIcon {
                        name: "calendar.fill"
                        size: 12
                        color: "#007AFF"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "Nothing for today"
                        color: Qt.rgba(1, 1, 1, 0.60)
                        font.pixelSize: 11
                        font.weight: Font.Normal
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Vertical Divider 2
            Rectangle {
                width: 1
                height: 68
                color: Qt.rgba(1, 1, 1, 0.10)
                anchors.verticalCenter: parent.verticalCenter
            }

            // ─── COLUMN 3: CIRCULAR PROFILE AVATAR GLANCE (~85px) ───
            Row {
                width: parent.width - 235 - 235 - 28 - 2
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Item {
                    width: 52
                    height: 52
                    anchors.verticalCenter: parent.verticalCenter

                    // Circular User Avatar
                    Rectangle {
                        anchors.fill: parent
                        radius: 26
                        color: "#18181C"
                        border.width: 1
                        border.color: Qt.rgba(1, 1, 1, 0.16)
                        clip: true

                        Image {
                            id: userAvatarImg
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            source: "file:///var/lib/AccountsService/icons/arya"
                            visible: status === Image.Ready
                        }

                        // Fallback Gradient Avatar if icon not found
                        Rectangle {
                            anchors.fill: parent
                            visible: !userAvatarImg.visible
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#242A38" }
                                GradientStop { position: 1.0; color: "#0B0E14" }
                            }
                            MacIcon {
                                anchors.centerIn: parent
                                name: "cloud.fill"
                                size: 22
                                color: "#32ADE6"
                            }
                        }
                    }

                    // Mini Status Badge (Active Desktop)
                    Rectangle {
                        width: 16
                        height: 16
                        radius: 8
                        color: "#007AFF" // Apple Blue
                        border.width: 1.5
                        border.color: "#000000"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: -2
                        z: 10

                        Text {
                            anchors.centerIn: parent
                            text: (root.sys && root.sys.current_desktop)
                                ? String(root.sys.current_desktop)
                                : "1"
                            color: "#FFFFFF"
                            font.pixelSize: 9
                            font.weight: Font.Bold
                        }
                    }
                }
            }
        }

        // ─── TAB 2 CONTENT: SPACES & SYSTEM STATS VIEW ─────────────────
        Column {
            id: spacesContentColumn
            visible: root.activeTab === "spaces"
            width: parent.width
            spacing: 8

            // Spaces / Virtual Desktop Switcher Bar
            Row {
                width: parent.width
                spacing: 8

                readonly property int currentDesk: (root.sys && root.sys.current_desktop)
                    ? Number(root.sys.current_desktop)
                    : 1
                readonly property int totalDesks: (root.sys && root.sys.desktop_count)
                    ? Number(root.sys.desktop_count)
                    : 4

                Repeater {
                    model: Math.max(2, Math.min(8, parent.totalDesks))

                    Rectangle {
                        readonly property int deskNum: index + 1
                        readonly property bool isActive: deskNum === parent.currentDesk

                        width: (parent.width - (parent.spacing * 3)) / 4
                        height: 42
                        radius: 10
                        color: isActive ? Qt.rgba(0, 0.48, 1, 0.22) : (deskHover.containsMouse ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.06))
                        border.width: 1
                        border.color: isActive ? "#007AFF" : Qt.rgba(1, 1, 1, 0.12)

                        Row {
                            anchors.centerIn: parent
                            spacing: 6

                            MacIcon {
                                name: "tray.fill"
                                size: 13
                                color: isActive ? "#007AFF" : Qt.rgba(1, 1, 1, 0.50)
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "Space " + deskNum
                                color: isActive ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.70)
                                font.pixelSize: 11
                                font.weight: isActive ? Font.Bold : Font.Medium
                                font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: deskHover
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: {
                                if (islandRoot) islandRoot.switchDesktop(deskNum)
                            }
                        }
                    }
                }
            }

            // Quick Telemetry Bento Grid
            Row {
                width: parent.width
                spacing: 8

                // CPU Card
                Rectangle {
                    width: (parent.width - 16) / 3
                    height: 36
                    radius: 8
                    color: Qt.rgba(1, 1, 1, 0.06)
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.10)

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: "#30D158"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "CPU " + ((root.sys && root.sys.cpu) ? Math.round(root.sys.cpu) + "%" : "0%")
                            color: "#FFFFFF"
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                        }
                    }
                }

                // RAM Card
                Rectangle {
                    width: (parent.width - 16) / 3
                    height: 36
                    radius: 8
                    color: Qt.rgba(1, 1, 1, 0.06)
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.10)

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: "#0A84FF"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "RAM " + ((root.sys && root.sys.ram) ? Math.round(root.sys.ram) + "%" : "0%")
                            color: "#FFFFFF"
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                        }
                    }
                }

                // Task Manager Shortcut
                Rectangle {
                    width: (parent.width - 16) / 3
                    height: 36
                    radius: 8
                    color: statHover.containsMouse ? Qt.rgba(1, 1, 1, 0.14) : Qt.rgba(1, 1, 1, 0.06)
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.10)

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        MacIcon {
                            name: "gearshape.fill"
                            size: 12
                            color: "#FF9F0A"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "Activity Monitor"
                            color: "#FFFFFF"
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, sans-serif"
                        }
                    }

                    MouseArea {
                        id: statHover
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: if (islandRoot) islandRoot.activateSystemMonitor()
                    }
                }
            }
        }
    }
}
