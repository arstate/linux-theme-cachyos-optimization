pragma Singleton
import QtQuick 2.15

// Apple-Grade Human Interface Design Tokens for Dynamic Island
// True OLED Black (#000000) body, sub-pixel borders, dark glass cards (#141417),
// and Apple System accent colors (Blue, Coral/Pink, Mint, Orange, Cyan).
QtObject {
    id: root

    // True black OLED pill body with glassmorphic depth
    readonly property color oledBlack: "#000000"
    readonly property color glassCard: "#141417"
    readonly property color glassCardHover: "#1F1F24"
    readonly property color hairlineBorder: Qt.rgba(1, 1, 1, 0.12)
    readonly property color hairlineHighlight: Qt.rgba(1, 1, 1, 0.22)

    // Apple System Accents
    readonly property color appleBlue: "#0A84FF"
    readonly property color applePink: "#FF375F"
    readonly property color appleCyan: "#32ADE6"
    readonly property color appleMint: "#30D158"
    readonly property color appleOrange: "#FF9F0A"
    readonly property color appleRed: "#FF453A"
    readonly property color applePurple: "#BF5AF2"

    // Pill background color: True Apple OLED black with subtle mode tint on borders
    function pillColor(mode, rawAction, isInstalling, isUninstalling, isInstalled, isUninstalled, isMediaOnly) {
        return "#000000"
    }

    // Pill label color: crisp Apple typography
    function textColor(isInstalling, isUninstalling, isInstalled, isUninstalled, isMediaOnly, isDefaultState) {
        if (isInstalling) return "#E8F4FD"
        if (isUninstalling) return "#FDE8E8"
        if (isInstalled) return "#E8F5E8"
        if (isUninstalled) return "#FDF4E8"
        if (isMediaOnly) return "#FFFFFF"
        if (isDefaultState) return "#F5F5F7"
        return "#FFFFFF"
    }

    // Expanded-view card color: unified dark glass
    function cardColor(modeId, installModeActive, rawAction) {
        return "#141417"
    }

    // Category accent dot/badge
    function accentColor(modeId) {
        if (modeId === "spaces") return appleCyan
        if (modeId === "media") return applePink
        if (modeId === "system") return appleBlue
        if (modeId === "llm") return applePurple
        if (modeId === "install") return appleMint
        return appleBlue
    }
}
