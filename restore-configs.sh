#!/usr/bin/env bash
# ==============================================================================
# Quick Config Restore Script (Full System Parity & WaveTask Dock Alignment)
# ==============================================================================

set -eo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${HOME}"

echo -e "\033[1;36mRestoring configurations to $TARGET_HOME...\033[0m"

CONFIG_DIR="$TARGET_HOME/.config"
mkdir -p "$CONFIG_DIR/Kvantum" "$CONFIG_DIR/gtk-3.0" "$CONFIG_DIR/gtk-4.0" \
         "$CONFIG_DIR/alacritty" "$CONFIG_DIR/fish" "$CONFIG_DIR/fontconfig" \
         "$CONFIG_DIR/environment.d" "$TARGET_HOME/icon" \
         "$TARGET_HOME/.local/share/applications" "$TARGET_HOME/.local/share/icons/hicolor" \
         "$TARGET_HOME/.local/share/plasma/plasmoids" "$TARGET_HOME/.local/share/kwin/scripts" \
         "$TARGET_HOME/Pictures/Wallpapers" "$TARGET_HOME/Downloads"

deploy_config() {
    local src="$1"
    local dst="$2"
    if [ -f "$src" ]; then
        sed "s|/home/arya|$TARGET_HOME|g" "$src" > "$dst"
        echo "Restored: $(basename "$dst")"
    fi
}

# Deploy KDE Plasma & KWin configs
deploy_config "$REPO_DIR/configs/kde/kdeglobals" "$CONFIG_DIR/kdeglobals"
deploy_config "$REPO_DIR/configs/kde/kwinrc" "$CONFIG_DIR/kwinrc"
deploy_config "$REPO_DIR/configs/kde/kwinrulesrc" "$CONFIG_DIR/kwinrulesrc"
deploy_config "$REPO_DIR/configs/kde/breezerc" "$CONFIG_DIR/breezerc"
deploy_config "$REPO_DIR/configs/kde/spectaclerc" "$CONFIG_DIR/spectaclerc"
deploy_config "$REPO_DIR/configs/kde/konsolerc" "$CONFIG_DIR/konsolerc"
deploy_config "$REPO_DIR/configs/kde/plasmarc" "$CONFIG_DIR/plasmarc"
deploy_config "$REPO_DIR/configs/kde/plasmashellrc" "$CONFIG_DIR/plasmashellrc"
deploy_config "$REPO_DIR/configs/kde/plasma-org.kde.plasma.desktop-appletsrc" "$CONFIG_DIR/plasma-org.kde.plasma.desktop-appletsrc"
deploy_config "$REPO_DIR/configs/kde/plasmanotifyrc" "$CONFIG_DIR/plasmanotifyrc"
deploy_config "$REPO_DIR/configs/kde/powerdevilrc" "$CONFIG_DIR/powerdevilrc"
deploy_config "$REPO_DIR/configs/kde/powermanagementprofilesrc" "$CONFIG_DIR/powermanagementprofilesrc"
deploy_config "$REPO_DIR/configs/kde/systemmonitorrc" "$CONFIG_DIR/systemmonitorrc"
deploy_config "$REPO_DIR/configs/kde/kcminputrc" "$CONFIG_DIR/kcminputrc"
deploy_config "$REPO_DIR/configs/kde/kscreenlockerrc" "$CONFIG_DIR/kscreenlockerrc"
deploy_config "$REPO_DIR/configs/kde/krunnerrc" "$CONFIG_DIR/krunnerrc"
deploy_config "$REPO_DIR/configs/kde/kglobalshortcutsrc" "$CONFIG_DIR/kglobalshortcutsrc"
deploy_config "$REPO_DIR/configs/kde/dolphinrc" "$CONFIG_DIR/dolphinrc"
deploy_config "$REPO_DIR/configs/kde/kwinoutputconfig.json" "$CONFIG_DIR/kwinoutputconfig.json"

deploy_config "$REPO_DIR/configs/fontconfig/fonts.conf" "$CONFIG_DIR/fontconfig/fonts.conf"
deploy_config "$REPO_DIR/configs/libinput/libinput-gestures.conf" "$CONFIG_DIR/libinput-gestures.conf"

deploy_config "$REPO_DIR/configs/kvantum/kvantum.kvconfig" "$CONFIG_DIR/Kvantum/kvantum.kvconfig"
deploy_config "$REPO_DIR/configs/gtk/gtk-3.0/settings.ini" "$CONFIG_DIR/gtk-3.0/settings.ini"
deploy_config "$REPO_DIR/configs/gtk/gtk-3.0/gtk.css" "$CONFIG_DIR/gtk-3.0/gtk.css"
deploy_config "$REPO_DIR/configs/gtk/gtk-4.0/settings.ini" "$CONFIG_DIR/gtk-4.0/settings.ini"
deploy_config "$REPO_DIR/configs/gtk/gtk-4.0/gtk.css" "$CONFIG_DIR/gtk-4.0/gtk.css"
deploy_config "$REPO_DIR/configs/gtk/gtkrc" "$CONFIG_DIR/gtkrc"
deploy_config "$REPO_DIR/configs/gtk/gtkrc-2.0" "$CONFIG_DIR/gtkrc-2.0"

deploy_config "$REPO_DIR/configs/dynamic-island/dynamic-island.conf" "$CONFIG_DIR/dynamic-island.conf"
deploy_config "$REPO_DIR/configs/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
deploy_config "$REPO_DIR/configs/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
deploy_config "$REPO_DIR/configs/chrome-flags.conf" "$CONFIG_DIR/chrome-flags.conf"

if [ -d "$REPO_DIR/configs/environment.d" ]; then
    cp -r "$REPO_DIR/configs/environment.d/"* "$CONFIG_DIR/environment.d/" 2>/dev/null || true
fi

# Deploy custom PWA applications (.desktop files for WhatsApp Web, YouTube, Figma, Dynamic Island)
if [ -d "$REPO_DIR/configs/applications" ]; then
    for app in "$REPO_DIR/configs/applications"/*.desktop; do
        if [ -f "$app" ]; then
            deploy_config "$app" "$TARGET_HOME/.local/share/applications/$(basename "$app")"
        fi
    done
fi

# Deploy custom icons (Apple cat icons & PWA hicolor icons)
if [ -d "$REPO_DIR/assets/icons" ]; then
    cp -r "$REPO_DIR/assets/icons/"* "$TARGET_HOME/icon/" 2>/dev/null || true
fi
if [ -d "$REPO_DIR/assets/icons/hicolor" ]; then
    cp -r "$REPO_DIR/assets/icons/hicolor/"* "$TARGET_HOME/.local/share/icons/hicolor/" 2>/dev/null || true
fi

# Deploy Wallpapers to both paths
WALLPAPER_SRC="$REPO_DIR/assets/wallpapers/White_cat_sitting_on_precipice_2K.jpeg"
if [ -f "$WALLPAPER_SRC" ]; then
    cp "$WALLPAPER_SRC" "$TARGET_HOME/Pictures/Wallpapers/White_cat_sitting_on_precipice_2K.jpeg"
    cp "$WALLPAPER_SRC" "$TARGET_HOME/Downloads/White_cat_sitting_on_precipice_2K_202609042320 (1).jpeg"
fi

# Deploy custom Plasmoids
PLASMOIDS_DIR="$TARGET_HOME/.local/share/plasma/plasmoids"
if [ -d "$REPO_DIR/plasmoids" ]; then
    for plasmoid in "$REPO_DIR/plasmoids"/*; do
        if [ -d "$plasmoid" ]; then
            pname="$(basename "$plasmoid")"
            if [ "$pname" != "plasma-dynamic-island" ]; then
                cp -r "$plasmoid" "$PLASMOIDS_DIR/"
            fi
        fi
    done
fi

# Deploy KWin Scripts
KWIN_SCRIPTS_DIR="$TARGET_HOME/.local/share/kwin/scripts"
if [ -d "$REPO_DIR/kwin-scripts" ]; then
    for script in "$REPO_DIR/kwin-scripts"/*; do
        if [ -d "$script" ]; then
            cp -r "$script" "$KWIN_SCRIPTS_DIR/"
        fi
    done
fi

# Ensure WaveTask Qt6 QML plugin is installed
if [ ! -f /usr/lib/qt6/qml/org/vicko/wavetask/libwavetaskplugin.so ] && [ -d "$REPO_DIR/configs/wavetask/qml-plugin" ]; then
    echo -e "Installing bundled WaveTask Qt6 QML plugin (requires sudo)..."
    sudo mkdir -p /usr/lib/qt6/qml/org/vicko/wavetask
    sudo cp -r "$REPO_DIR/configs/wavetask/qml-plugin/"* /usr/lib/qt6/qml/org/vicko/wavetask/
    sudo mkdir -p /usr/share/plasma/layout-templates/org.vicko.wavetask.panel
    sudo cp -r "$REPO_DIR/configs/wavetask/layout-template/"* /usr/share/plasma/layout-templates/org.vicko.wavetask.panel/
fi

echo -e "\033[1;32mReloading KWin and Plasma...\033[0m"
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
systemctl --user restart plasma-plasmashell 2>/dev/null || (kquitapp6 plasmashell 2>/dev/null && kstart plasmashell 2>/dev/null) || true
systemctl --user restart dynamic-island.service 2>/dev/null || true

echo -e "\033[1;32m✓ Full configuration restored successfully!\033[0m"
