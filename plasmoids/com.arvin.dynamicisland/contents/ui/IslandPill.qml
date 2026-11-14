import QtQuick 2.15
import QtQuick.Layouts 1.15

// Apple macOS Dynamic Island - Compact Pill Representation
// 100% OLED True Black (#000000), Apple spring physics morphing,
// sub-pixel specular highlight, squircle album art, and live equalizer.
Item {
    id: mainContainer

    property var islandRoot

    readonly property bool isExpanded: islandRoot ? islandRoot.expanded : false

    Layout.fillWidth: false
    Layout.fillHeight: false
    Layout.preferredWidth: islandRoot ? islandRoot.animatedWidth : 200
    Layout.preferredHeight: islandRoot ? islandRoot.fixedHeight : 44
    Layout.minimumWidth: islandRoot ? islandRoot.minWidth : 120
    Layout.maximumWidth: islandRoot ? islandRoot.maxWidth : 650
    Layout.minimumHeight: islandRoot ? islandRoot.fixedHeight : 44
    Layout.maximumHeight: islandRoot ? islandRoot.fixedHeight : 44
    width: islandRoot ? islandRoot.animatedWidth : 200
    height: islandRoot ? islandRoot.fixedHeight : 44

    // Master Pill Surface (OLED True Black with Apple Sub-Pixel Hairline)
    Rectangle {
        id: background
        anchors.fill: parent
        radius: height / 2
        color: "#000000"
        border.width: 1
        border.color: (hovered || mainContainer.isExpanded) ? Qt.rgba(1, 1, 1, 0.25) : Qt.rgba(1, 1, 1, 0.14)
        clip: true

        scale: (hovered || mainContainer.isExpanded) ? 1.02 : 1.0

        Behavior on scale {
            SpringAnimation {
                spring: 4.5
                damping: 0.32
                mass: 0.85
                epsilon: 0.005
            }
        }

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        // Top-edge Apple specular gloss highlight
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.height / 2
            anchors.rightMargin: parent.height / 2
            height: 1
            color: Qt.rgba(1, 1, 1, 0.20)
        }

        property bool hovered: false

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                background.hovered = true
                if (islandRoot) islandRoot.openExpanded()
            }
            onExited: {
                background.hovered = false
                if (islandRoot) islandRoot.scheduleCollapse()
            }

            onClicked: {
                if (!islandRoot) return
                if (islandRoot.priorityMode === "media")
                    islandRoot.activateMediaPlayer()
                else if (islandRoot.priorityMode === "install")
                    islandRoot.activateInstallTerminal()
                else
                    islandRoot.activateSystemMonitor()
            }
        }
    }

    // ─── COMPACT CONTENT CONTAINER ──────────────────────────────────
    Item {
        id: compactContent
        anchors.fill: parent

        // Left Zone: Mini Music Album Art / Desktop Badge
        Item {
            id: leftZone
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            z: 10

            // If Media Active: Mini Apple Music Cover Squircle
            Rectangle {
                id: mediaPillBadge
                anchors.fill: parent
                radius: 6
                visible: islandRoot ? islandRoot.mediaModeActive : false
                color: "#1C1C1E"
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.14)
                clip: true

                Image {
                    id: pillAlbumArt
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: (islandRoot && islandRoot.mediaData && islandRoot.mediaData.art_url) ? islandRoot.mediaData.art_url : ""
                    visible: status === Image.Ready && source !== ""
                }

                // Fallback Apple Music Note Icon if artUrl not ready
                MacIcon {
                    anchors.centerIn: parent
                    name: "applemusic"
                    size: 13
                    color: "#FF375F"
                    visible: !pillAlbumArt.visible
                }
            }

            // If Idle / System Active: Mini Desktop Badge [ 1 ]
            Rectangle {
                anchors.fill: parent
                radius: 12
                visible: islandRoot ? (!islandRoot.mediaModeActive && !islandRoot.installModeActive) : true
                color: Qt.rgba(1, 1, 1, 0.08)
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.12)

                Text {
                    anchors.centerIn: parent
                    text: (islandRoot && islandRoot.sysData && islandRoot.sysData.current_desktop)
                        ? String(islandRoot.sysData.current_desktop)
                        : "1"
                    color: "#32ADE6" // Apple Cyan
                    font.pixelSize: 11
                    font.weight: Font.Bold
                }
            }
        }

        // Center Zone: Dynamic Scrolling/Marquee Label with Apple Typography
        Item {
            id: textWrapper
            anchors.left: leftZone.right
            anchors.right: rightZone.left
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            clip: true
            z: 5

            Text {
                id: textDisplay
                text: islandRoot ? islandRoot.visibleDisplayText : ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                maximumLineCount: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right

                font.family: islandRoot ? islandRoot.uiFont : "-apple-system, BlinkMacSystemFont, 'SF Pro Display', sans-serif"
                font.pixelSize: 13
                font.weight: Font.DemiBold
                font.letterSpacing: -0.2
                color: "#FFFFFF"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
                antialiasing: true

                Behavior on opacity {
                    NumberAnimation { duration: 180; easing.type: Easing.OutQuad }
                }

                onTextChanged: {
                    opacity = 0.0
                    fadeInTimer.restart()
                }

                Timer {
                    id: fadeInTimer
                    interval: 20
                    repeat: false
                    onTriggered: textDisplay.opacity = 1.0
                }
            }
        }

        // Right Zone: Equalizer Waveform OR CPU Telemetry
        Item {
            id: rightZone
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: islandRoot && islandRoot.mediaModeActive ? 20 : 36
            height: 20
            z: 10

            // Live Audio Equalizer Waveform
            MediaVisualizer {
                anchors.centerIn: parent
                active: islandRoot ? islandRoot.mediaModeActive : false
                barColor: "#FF375F" // Apple Music Pink
            }

            // Live CPU mini badge (when not playing media)
            Text {
                anchors.centerIn: parent
                visible: islandRoot ? !islandRoot.mediaModeActive : true
                text: (islandRoot && islandRoot.sysData && islandRoot.sysData.cpu !== undefined)
                    ? (Math.round(islandRoot.sysData.cpu) + "%")
                    : ""
                color: Qt.rgba(1, 1, 1, 0.45)
                font.pixelSize: 10
                font.weight: Font.Medium
                font.family: islandRoot ? islandRoot.uiFont : "sans-serif"
            }
        }

        // Bottom Inset Install Progress Pill
        InstallProgress {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 4
            z: 12
            active: islandRoot ? (islandRoot.isInstalling || islandRoot.isUninstalling) : false
            removing: islandRoot ? islandRoot.isUninstalling : false
        }
    }
}
