#!/usr/bin/env bash
# ==============================================================================
# Quick Config Restore Script (No Package Re-install)
# ==============================================================================

set -eo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${HOME}"

echo -e "\033[1;36mRestoring configurations to $TARGET_HOME...\033[0m"

CONFIG_DIR="$TARGET_HOME/.config"
mkdir -p "$CONFIG_DIR/Kvantum" "$CONFIG_DIR/gtk-3.0" "$CONFIG_DIR/gtk-4.0" "$CONFIG_DIR/alacritty" "$CONFIG_DIR/fish" "$CONFIG_DIR/fontconfig" "$TARGET_HOME/icon"

deploy_config() {
    local src="$1"
    local dst="$2"
    if [ -f "$src" ]; then
        sed "s|/home/arya|$TARGET_HOME|g" "$src" > "$dst"
        echo "Restored: $(basename "$dst")"
    fi
}

deploy_config "$REPO_DIR/configs/kde/kdeglobals" "$CONFIG_DIR/kdeglobals"
deploy_config "$REPO_DIR/configs/kde/kwinrc" "$CONFIG_DIR/kwinrc"
deploy_config "$REPO_DIR/configs/kde/kwinrulesrc" "$CONFIG_DIR/kwinrulesrc"
deploy_config "$REPO_DIR/configs/kde/breezerc" "$CONFIG_DIR/breezerc"
deploy_config "$REPO_DIR/configs/kde/spectaclerc" "$CONFIG_DIR/spectaclerc"
deploy_config "$REPO_DIR/configs/kde/konsolerc" "$CONFIG_DIR/konsolerc"
deploy_config "$REPO_DIR/configs/kde/plasmarc" "$CONFIG_DIR/plasmarc"
deploy_config "$REPO_DIR/configs/kde/plasmashellrc" "$CONFIG_DIR/plasmashellrc"
deploy_config "$REPO_DIR/configs/kde/plasma-org.kde.plasma.desktop-appletsrc" "$CONFIG_DIR/plasma-org.kde.plasma.desktop-appletsrc"
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
deploy_config "$REPO_DIR/configs/dynamic-island/dynamic-island.conf" "$CONFIG_DIR/dynamic-island.conf"
deploy_config "$REPO_DIR/configs/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
deploy_config "$REPO_DIR/configs/fish/config.fish" "$CONFIG_DIR/fish/config.fish"

if [ -d "$REPO_DIR/assets/icons" ]; then
    cp -r "$REPO_DIR/assets/icons/"* "$TARGET_HOME/icon/" 2>/dev/null || true
fi

echo -e "\033[1;32mReloading KWin and Plasma...\033[0m"
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
systemctl --user restart plasma-plasmashell 2>/dev/null || (kquitapp6 plasmashell 2>/dev/null && kstart plasmashell 2>/dev/null) || true
systemctl --user restart dynamic-island.service 2>/dev/null || true

echo -e "\033[1;32m✓ Quick restore completed successfully!\033[0m"
