import QtQuick 2.15
import Qt5Compat.GraphicalEffects

// Apple macOS SF Symbols Native Vector Icon Renderer
// Dynamically tinted SVG vector glyphs with pixel-perfect scaling
Item {
    id: macIconRoot

    property string name: "play.fill"
    property color color: "#FFFFFF"
    property int size: 16

    readonly property bool needsTint: macIconRoot.color !== "#FFFFFF" && macIconRoot.color !== "#ffffff"

    width: size
    height: size

    Image {
        id: iconImg
        anchors.fill: parent
        source: Qt.resolvedUrl("../assets/icons/" + macIconRoot.name + ".svg")
        sourceSize.width: macIconRoot.size * 2
        sourceSize.height: macIconRoot.size * 2
        fillMode: Image.PreserveAspectFit
        smooth: true
        visible: !macIconRoot.needsTint
    }

    ColorOverlay {
        anchors.fill: iconImg
        source: iconImg
        color: macIconRoot.color
        visible: macIconRoot.needsTint
    }
}
