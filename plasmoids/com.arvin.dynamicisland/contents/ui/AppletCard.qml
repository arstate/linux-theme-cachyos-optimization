import QtQuick 2.15

// Apple Glass Morphism Card Component for Dynamic Island
Item {
    id: root
    property var islandRoot
    property string modeId: "system"
    property string title: ""
    property bool alwaysShow: false
    property bool active: false
    property color cardColor: "#141417"
    property Component contentComponent

    readonly property bool prioritized: islandRoot && islandRoot.priorityMode === modeId
    readonly property bool dimmed: modeId !== "system" && !active

    visible: true
    implicitHeight: card.implicitHeight
    height: implicitHeight
    width: parent ? parent.width : 400
    clip: true

    Rectangle {
        id: card
        width: parent.width
        implicitHeight: row.implicitHeight + 16
        height: implicitHeight
        radius: 16
        color: mouseArea.containsMouse ? "#1C1C22" : (root.prioritized ? "#191920" : "#131317")
        border.width: 1
        border.color: root.prioritized ? Qt.rgba(0.04, 0.52, 1.0, 0.35) : (mouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(1, 1, 1, 0.08))
        opacity: root.dimmed ? 0.72 : 1.0

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }

        Row {
            id: row
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            spacing: 10
            width: parent.width - 20

            // Apple Category Accent Indicator
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 6
                height: 6
                radius: 3
                color: ModeColors.accentColor(root.modeId)
                opacity: root.active || root.modeId === "system" || root.modeId === "spaces" ? 1.0 : 0.4
            }

            Column {
                width: parent.width - 20
                spacing: 4

                Row {
                    spacing: 6
                    width: parent.width

                    Text {
                        text: root.title
                        color: Qt.rgba(1, 1, 1, 0.50)
                        font.pixelSize: 10
                        font.weight: Font.DemiBold
                        font.letterSpacing: 0.8
                        font.capitalization: Font.AllUppercase
                        font.family: islandRoot ? islandRoot.uiFont : "-apple-system, sans-serif"
                    }

                    Item { Layout.fillWidth: true; width: 1 }

                    // Priority Pin Toggle (Subtle Apple Pill)
                    Rectangle {
                        visible: root.prioritized
                        width: 42
                        height: 14
                        radius: 7
                        color: Qt.rgba(0.04, 0.52, 1.0, 0.20)
                        border.width: 1
                        border.color: "#0A84FF"

                        Text {
                            anchors.centerIn: parent
                            text: "PINNED"
                            color: "#0A84FF"
                            font.pixelSize: 8
                            font.weight: Font.Bold
                            font.letterSpacing: 0.5
                        }
                    }
                }

                Loader {
                    width: parent.width
                    sourceComponent: root.contentComponent
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            z: -1
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: if (islandRoot) islandRoot.cancelCollapse()
            onClicked: {
                if (!islandRoot) return
                if (modeId === "system") islandRoot.activateSystemMonitor()
                else if (modeId === "media") islandRoot.activateMediaPlayer()
                else if (modeId === "llm") islandRoot.activateLlmRunner()
                else if (modeId === "install") islandRoot.activateInstallTerminal()
            }
        }
    }
}
