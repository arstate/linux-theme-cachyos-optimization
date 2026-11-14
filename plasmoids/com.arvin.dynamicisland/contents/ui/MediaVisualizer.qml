import QtQuick 2.15

// Apple Music Dynamic Equalizer Waveform
// 4-bar audio frequency bars with rounded stadium caps and realistic bounce physics
Row {
    id: visualizer

    property bool active: false
    property color barColor: "#FF375F" // Apple Music Pink or Spotify Green
    visible: active
    spacing: 2.5
    height: 18
    property real t: 0

    Timer {
        interval: 45
        running: visualizer.visible
        repeat: true
        onTriggered: visualizer.t += 0.22
    }

    // 4 bars mimicking bass, low-mid, high-mid, treble
    Repeater {
        model: 4
        Rectangle {
            width: 2.8
            radius: 1.4
            anchors.verticalCenter: parent.verticalCenter

            // Dynamic heights with varying frequency speeds
            readonly property real h1: Math.abs(Math.sin(visualizer.t * 1.4 + index * 1.1))
            readonly property real h2: Math.abs(Math.cos(visualizer.t * 2.1 + index * 1.7))
            readonly property real targetH: 3.5 + 13 * (h1 * 0.6 + h2 * 0.4)

            height: visualizer.active ? targetH : 3
            color: visualizer.barColor

            Behavior on height {
                NumberAnimation { duration: 40; easing.type: Easing.OutQuad }
            }
        }
    }
}
