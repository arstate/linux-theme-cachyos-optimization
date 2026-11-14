#!/usr/bin/env bash
# ==============================================================================
# CachyOS & KDE Plasma 6 Mac-Style Rice & System Optimization Auto-Installer
# Author: arstate (Bachtiar Aryansyah Putra)
# Repository: https://github.com/arstate/linux-theme-cachyos-optimization
# Target OS: CachyOS / Arch Linux (KDE Plasma 6 on Wayland)
# ==============================================================================

set -eo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="${HOME}"
if [ -n "${SUDO_USER:-}" ]; then
    TARGET_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
fi

echo -e "\033[1;36m====================================================================\033[0m"
echo -e "\033[1;32m  🚀 CachyOS / KDE Plasma 6 MacOS Rice & System Optimization Setup\033[0m"
echo -e "\033[1;36m====================================================================\033[0m"
echo -e "User: \033[1;33m$TARGET_USER\033[0m | Home: \033[1;33m$TARGET_HOME\033[0m"
echo -e "Source Directory: \033[1;33m$REPO_DIR\033[0m\n"

# Helper function for AUR helper
get_aur_helper() {
    if command -v paru >/dev/null 2>&1; then
        echo "paru"
    elif command -v yay >/dev/null 2>&1; then
        echo "yay"
    else
        echo ""
    fi
}

AUR_HELPER=$(get_aur_helper)

# ------------------------------------------------------------------------------
# STEP 1: Install Required Dependencies
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[1/8] Installing System & Build Dependencies...\033[0m"

PACKAGES=(
    git curl wget rsync jq optipng inkscape dialog
    cmake ninja extra-cmake-modules gcc vulkan-headers qt6-base qt6-declarative qt6-shadertools layer-shell-qt
    kirigami kguiaddons kconfig kidletime kglobalaccel xdotool
    plasma-workspace plasma-pa wireplumber networkmanager bluez-utils spectacle
    kvantum kvantum-qt6 alacritty fish fastfetch
    ananicy-cpp cachyos-ananicy-rules scx-scheds zram-generator
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}" || true

if [ -n "$AUR_HELPER" ]; then
    echo -e "Installing AUR packages using $AUR_HELPER..."
    $AUR_HELPER -S --needed --noconfirm \
        kwin-effects-better-blur-dx \
        kwin-scripts-forceblur \
        wavetask \
        libinput-gestures || true
else
    echo -e "\033[1;33m[!] AUR helper not found. Installing yay automatically...\033[0m"
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (cd /tmp/yay-bin && makepkg -si --noconfirm)
    rm -rf /tmp/yay-bin
    AUR_HELPER="yay"
    $AUR_HELPER -S --needed --noconfirm \
        kwin-effects-better-blur-dx \
        kwin-scripts-forceblur \
        wavetask \
        libinput-gestures || true
fi

# ------------------------------------------------------------------------------
# STEP 2: Deploy Custom Assets (Icons & Wallpaper)
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[2/8] Deploying Custom Icons and Wallpapers...\033[0m"

mkdir -p "$TARGET_HOME/icon"
mkdir -p "$TARGET_HOME/Pictures/Wallpapers"
mkdir -p "$TARGET_HOME/Downloads"
mkdir -p "$TARGET_HOME/.local/share/wallpapers"

if [ -d "$REPO_DIR/assets/icons" ]; then
    cp -r "$REPO_DIR/assets/icons/"* "$TARGET_HOME/icon/" 2>/dev/null || true
fi

WALLPAPER_SRC="$REPO_DIR/assets/wallpapers/White_cat_sitting_on_precipice_2K.jpeg"
if [ -f "$WALLPAPER_SRC" ]; then
    cp "$WALLPAPER_SRC" "$TARGET_HOME/Pictures/Wallpapers/White_cat_sitting_on_precipice_2K.jpeg"
    # Also replicate exact path used by original config in Downloads for 100% path parity
    cp "$WALLPAPER_SRC" "$TARGET_HOME/Downloads/White_cat_sitting_on_precipice_2K_202609042320 (1).jpeg"
fi

# ------------------------------------------------------------------------------
# STEP 3: Install macOS Themes (MacTahoe, WhiteSur, MacVentura)
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[3/8] Installing macOS Themes & Icon Packs...\033[0m"

mkdir -p "$TARGET_HOME/.local/share/color-schemes"
mkdir -p "$TARGET_HOME/.local/share/aurorae/themes"
mkdir -p "$TARGET_HOME/.local/share/icons"
mkdir -p "$TARGET_HOME/.themes"

# Copy local bundled color schemes & aurorae immediately
if [ -d "$REPO_DIR/assets/color-schemes" ]; then
    cp -r "$REPO_DIR/assets/color-schemes/"* "$TARGET_HOME/.local/share/color-schemes/" 2>/dev/null || true
fi
if [ -d "$REPO_DIR/assets/aurorae" ]; then
    cp -r "$REPO_DIR/assets/aurorae/"* "$TARGET_HOME/.local/share/aurorae/themes/" 2>/dev/null || true
fi

# Clone and install full theme packages for maximum completeness
THEME_BUILD_DIR="/tmp/theme-installer-$$"
mkdir -p "$THEME_BUILD_DIR"

install_git_theme() {
    local url="$1"
    local name="$2"
    local install_cmd="$3"
    echo -e "Installing $name..."
    if [ ! -d "$TARGET_HOME/.local/share/icons/$name" ] && [ ! -d "$TARGET_HOME/.local/share/plasma/look-and-feel/*$name*" ]; then
        git clone --depth=1 "$url" "$THEME_BUILD_DIR/$name" 2>/dev/null || true
        if [ -d "$THEME_BUILD_DIR/$name" ]; then
            (cd "$THEME_BUILD_DIR/$name" && eval "$install_cmd") 2>/dev/null || true
        fi
    fi
}

install_git_theme "https://github.com/vinceliuice/MacTahoe-kde.git" "MacTahoe-kde" "./install.sh"
install_git_theme "https://github.com/vinceliuice/MacTahoe-icon-theme.git" "MacTahoe-icon-theme" "./install.sh"
install_git_theme "https://github.com/vinceliuice/WhiteSur-kde.git" "WhiteSur-kde" "./install.sh"
install_git_theme "https://github.com/vinceliuice/WhiteSur-icon-theme.git" "WhiteSur-icon-theme" "./install.sh"
install_git_theme "https://github.com/vinceliuice/WhiteSur-cursors.git" "WhiteSur-cursors" "./install.sh"
install_git_theme "https://github.com/vinceliuice/MacVentura-kde.git" "MacVentura-kde" "./install.sh --round"

rm -rf "$THEME_BUILD_DIR"

# ------------------------------------------------------------------------------
# STEP 4: Deploy Plasmoids & KWin Scripts
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[4/8] Deploying Custom Plasmoids and KWin Scripts...\033[0m"

PLASMOIDS_DIR="$TARGET_HOME/.local/share/plasma/plasmoids"
KWIN_SCRIPTS_DIR="$TARGET_HOME/.local/share/kwin/scripts"
mkdir -p "$PLASMOIDS_DIR"
mkdir -p "$KWIN_SCRIPTS_DIR"

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

if [ -d "$REPO_DIR/kwin-scripts" ]; then
    for script in "$REPO_DIR/kwin-scripts"/*; do
        if [ -d "$script" ]; then
            cp -r "$script" "$KWIN_SCRIPTS_DIR/"
        fi
    done
fi

# Deploy Dynamic Island collector script
mkdir -p "$TARGET_HOME/.local/share/plasma-dynamic-island/scripts"
if [ -f "$REPO_DIR/plasmoids/plasma-dynamic-island/scripts/di-v13-collector.sh" ]; then
    cp "$REPO_DIR/plasmoids/plasma-dynamic-island/scripts/di-v13-collector.sh" "$TARGET_HOME/.local/share/plasma-dynamic-island/scripts/"
    chmod +x "$TARGET_HOME/.local/share/plasma-dynamic-island/scripts/di-v13-collector.sh"
fi

# ------------------------------------------------------------------------------
# STEP 5: Build and Install Dynamic Island Wayland Native Binary
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[5/8] Building & Installing Dynamic Island Wayland Native Daemon...\033[0m"

DI_BUILD_DIR="/tmp/dynamic-island-build-$$"
mkdir -p "$TARGET_HOME/.local/bin"

if git clone --depth=1 https://github.com/arstate/dynamic-island.git "$DI_BUILD_DIR"; then
    cmake -S "$DI_BUILD_DIR" -B "$DI_BUILD_DIR/build" -G Ninja -DCMAKE_INSTALL_PREFIX="$TARGET_HOME/.local"
    cmake --build "$DI_BUILD_DIR/build"
    cmake --install "$DI_BUILD_DIR/build"
    rm -rf "$DI_BUILD_DIR"
    echo -e "\033[1;32m✓ Dynamic Island binary compiled and installed to ~/.local/bin/dynamic-island\033[0m"
else
    echo -e "\033[1;31m✗ Failed to clone dynamic-island repo, skipping compile.\033[0m"
fi

# Setup systemd user service and autostart
mkdir -p "$TARGET_HOME/.config/systemd/user"
mkdir -p "$TARGET_HOME/.config/autostart"

if [ -f "$REPO_DIR/configs/dynamic-island/dynamic-island.service" ]; then
    sed "s|/home/arya|$TARGET_HOME|g" "$REPO_DIR/configs/dynamic-island/dynamic-island.service" > "$TARGET_HOME/.config/systemd/user/dynamic-island.service"
fi
if [ -f "$REPO_DIR/configs/dynamic-island/dynamic-island-collector.service" ]; then
    sed "s|/home/arya|$TARGET_HOME|g" "$REPO_DIR/configs/dynamic-island/dynamic-island-collector.service" > "$TARGET_HOME/.config/systemd/user/dynamic-island-collector.service"
fi
if [ -f "$REPO_DIR/configs/dynamic-island/dynamic-island.conf" ]; then
    sed "s|/home/arya|$TARGET_HOME|g" "$REPO_DIR/configs/dynamic-island/dynamic-island.conf" > "$TARGET_HOME/.config/dynamic-island.conf"
fi
if [ -f "$REPO_DIR/configs/dynamic-island/plasma-dynamic-island-collector.desktop" ]; then
    sed "s|/home/arya|$TARGET_HOME|g" "$REPO_DIR/configs/dynamic-island/plasma-dynamic-island-collector.desktop" > "$TARGET_HOME/.config/autostart/plasma-dynamic-island-collector.desktop"
fi

systemctl --user daemon-reload || true
systemctl --user enable --now dynamic-island.service || true

# ------------------------------------------------------------------------------
# STEP 6: Deploy KDE & App Configurations (Path-Adapted)
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[6/8] Restoring Plasma, KWin, GTK, Kvantum & Terminal Configs...\033[0m"

CONFIG_DIR="$TARGET_HOME/.config"
mkdir -p "$CONFIG_DIR/Kvantum"
mkdir -p "$CONFIG_DIR/gtk-3.0"
mkdir -p "$CONFIG_DIR/gtk-4.0"
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/fish"
mkdir -p "$CONFIG_DIR/fontconfig"

# Function to copy config with home path substitution
deploy_config() {
    local src="$1"
    local dst="$2"
    if [ -f "$src" ]; then
        sed "s|/home/arya|$TARGET_HOME|g" "$src" > "$dst"
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
which libinput-gestures-setup >/dev/null 2>&1 && libinput-gestures-setup autostart start || true

deploy_config "$REPO_DIR/configs/kvantum/kvantum.kvconfig" "$CONFIG_DIR/Kvantum/kvantum.kvconfig"
if [ -d "$REPO_DIR/configs/kvantum/MacTahoeDark" ]; then
    cp -r "$REPO_DIR/configs/kvantum/MacTahoeDark" "$CONFIG_DIR/Kvantum/"
fi
if [ -d "$REPO_DIR/configs/kvantum/MacTahoe" ]; then
    cp -r "$REPO_DIR/configs/kvantum/MacTahoe" "$CONFIG_DIR/Kvantum/"
fi
if [ -d "$REPO_DIR/configs/kvantum/MacVentura" ]; then
    cp -r "$REPO_DIR/configs/kvantum/MacVentura" "$CONFIG_DIR/Kvantum/"
fi
if [ -d "$REPO_DIR/configs/kvantum/WhiteSur" ]; then
    cp -r "$REPO_DIR/configs/kvantum/WhiteSur" "$CONFIG_DIR/Kvantum/"
fi

deploy_config "$REPO_DIR/configs/gtk/gtk-3.0/settings.ini" "$CONFIG_DIR/gtk-3.0/settings.ini"
deploy_config "$REPO_DIR/configs/gtk/gtk-3.0/gtk.css" "$CONFIG_DIR/gtk-3.0/gtk.css"
deploy_config "$REPO_DIR/configs/gtk/gtk-4.0/settings.ini" "$CONFIG_DIR/gtk-4.0/settings.ini"
deploy_config "$REPO_DIR/configs/gtk/gtk-4.0/gtk.css" "$CONFIG_DIR/gtk-4.0/gtk.css"

deploy_config "$REPO_DIR/configs/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
deploy_config "$REPO_DIR/configs/fish/config.fish" "$CONFIG_DIR/fish/config.fish"

# SDDM and Plymouth
if [ -f "$REPO_DIR/configs/sddm/kde_settings.conf" ]; then
    sudo mkdir -p /etc/sddm.conf.d
    sudo cp "$REPO_DIR/configs/sddm/kde_settings.conf" /etc/sddm.conf.d/kde_settings.conf
fi
if [ -f "$REPO_DIR/configs/plymouth/plymouthd.conf" ]; then
    sudo mkdir -p /etc/plymouth
    sudo cp "$REPO_DIR/configs/plymouth/plymouthd.conf" /etc/plymouth/plymouthd.conf
fi

# ------------------------------------------------------------------------------
# STEP 7: Apply KDE Plasma Settings Directly via CLI
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[7/8] Activating Themes, Icons, Cursors & KWin Scripts...\033[0m"

# Apply Color Scheme
kwriteconfig6 --file kdeglobals --group General --key ColorScheme "MacVenturaDark" 2>/dev/null || true
# Apply Icons
kwriteconfig6 --file kdeglobals --group Icons --key Theme "MacTahoe-dark" 2>/dev/null || true
# Apply Cursor
kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme "MacTahoe-dark" 2>/dev/null || true
kwriteconfig6 --file kcminputrc --group Mouse --key cursorSize "24" 2>/dev/null || true
# Apply Plasma Theme
kwriteconfig6 --file plasmarc --group Theme --key name "WhiteSur-dark" 2>/dev/null || true
# Apply Window Decoration (Aurorae)
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae.v2" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "__aurorae__svg__MacVentura-Dark" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "XIA" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "E_M" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group Windows --key BorderlessMaximizedWindows "true" 2>/dev/null || true

# Apply KWin Plugins
kwriteconfig6 --file kwinrc --group Plugins --key better_blur_dxEnabled "true" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group Plugins --key forceblurEnabled "true" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group Plugins --key kzonesEnabled "true" 2>/dev/null || true
kwriteconfig6 --file kwinrc --group Plugins --key sticky-window-snappingEnabled "true" 2>/dev/null || true

# ------------------------------------------------------------------------------
# STEP 8: Apply CachyOS System Optimizations & Restart Shell
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[8/8] Applying CachyOS Kernel & Performance Optimizations...\033[0m"

if [ -f "$REPO_DIR/optimizations/zram-generator.conf" ]; then
    sudo cp "$REPO_DIR/optimizations/zram-generator.conf" /etc/systemd/zram-generator.conf
    sudo systemctl daemon-reload || true
    sudo systemctl restart /dev/zram0 2>/dev/null || sudo systemctl restart systemd-zram-setup@zram0.service || true
fi

# Enable ananicy-cpp process priority auto-tuning
sudo systemctl enable --now ananicy-cpp || true

# Enable cachyos rate mirrors timer
sudo systemctl enable --now cachyos-rate-mirrors.timer || true

echo -e "\n\033[1;35mReloading KDE Plasma Shell & KWin Compositor...\033[0m"
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
systemctl --user restart plasma-plasmashell 2>/dev/null || (kquitapp6 plasmashell 2>/dev/null && kstart plasmashell 2>/dev/null) || true
systemctl --user restart dynamic-island.service 2>/dev/null || true

echo -e "\n\033[1;32m====================================================================\033[0m"
echo -e "\033[1;32m  🎉 SETUP COMPLETE! Your Linux laptop now matches your desktop!    \033[0m"
echo -e "\033[1;32m====================================================================\033[0m"
echo -e "Enjoy your CachyOS Mac-style rice with Dynamic Island & high performance!"
