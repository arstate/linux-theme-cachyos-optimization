# ⚡ README AI AGENT — SINGLE COPY-PASTE PROMPT FOR NEW LAPTOP

> **Panduan untuk Pemilik Laptop Baru (arstate):**  
> Setelah Anda install CachyOS di laptop baru, **buka AI Agent Anda** (Antigravity CLI, Cursor, Claude Code, Windsurf, Cline, Aider, dll.), lalu **copy dan paste prompt di bawah ini** ke dalam chat. AI Agent akan langsung mengeksekusi seluruh setup dari GitHub secara otomatis dalam sekali jalan!

---

```markdown
Tolong konfigurasikan sistem operasi CachyOS (KDE Plasma 6 Wayland) di laptop baru saya agar 100% persis dan identik dengan setup PC desktop saya dari repository resmi:
https://github.com/arstate/linux-theme-cachyos-optimization

Lakukan seluruh instalasi dan replikasi berikut ini secara otomatis dari terminal tanpa perlu saya edit-edit lagi:

1. Clone repository resmi ke direktori temporary:
   rm -rf /tmp/linux-theme-cachyos-optimization
   git clone https://github.com/arstate/linux-theme-cachyos-optimization.git /tmp/linux-theme-cachyos-optimization
   cd /tmp/linux-theme-cachyos-optimization

2. Jalankan master setup script secara otomatis:
   chmod +x install.sh
   ./install.sh

3. Pastikan poin-poin berikut telah tervalidasi dan aktif sempurna di sistem:
   a. **Tema & Estetika Visual macOS Dark**:
      - Global Look-and-Feel: MacTahoe-Dark / MacVentura-Dark
      - Plasma Theme: WhiteSur-dark
      - Color Scheme: MacVenturaDark
      - Icon Theme: MacTahoe-dark
      - Cursor Theme: MacTahoe-dark (size 24)
      - Window Decoration (Aurorae): __aurorae__svg__MacVentura-Dark dengan tombol jendela di sisi KIRI (Close, Minimize, Maximize / XIA) dan BorderlessMaximizedWindows aktif.
      - Kvantum Theme: MacTahoeDark
      - GTK 3 & GTK 4: WhiteSur-Dark + custom gtk.css styling.
      - Wallpaper Desktop: White Cat Sitting on Precipice 2K.
      - Lock Screen Wallpaper: MacVentura-Dark (Timeout 15 menit).
      - SDDM Login Theme: MacTahoe-Dark.
      - Plymouth Boot Animation: apple-mac-plymouth.

   b. **Panel, Dock & Applet Layout**:
      - **Top Bar (Panel 410)**: Tinggi 32px, full-width, always visible. Urutan widget:
        1. Kpple Menu (Apple Logo Menu dengan icon custom cat2.png)
        2. Application Title Bar (menampilkan judul aplikasi aktif + window buttons)
        3. Global Menu Bar (File, Edit, View, Window, Help)
        4. Panel Spacer (flexible spacer)
        5. KDE Control Station (macOS Control Center dengan custom button icon)
        6. System Tray & Margins Separator
      - **Dynamic Island (Top Center Notch / Pill)**:
        - Compile dan install binary native Wayland dari https://github.com/arstate/dynamic-island ke ~/.local/bin/dynamic-island
        - Pasang konfigurasi ~/.config/dynamic-island.conf (look=notch, accent=#ff453a, idleWidth=130, compactWidth=160, weather Sidoarjo, quick buttons, photo widget, history apps)
        - Aktifkan systemd user service: dynamic-island.service (restart=always, QT_QPA_PLATFORM=wayland)
        - Pasang collector script di ~/.local/share/plasma-dynamic-island/scripts/di-v13-collector.sh dan autostart desktop entry
      - **Bottom Floating Dock (Panel 492 - WaveTask)**:
        - Widget Task Manager: **WaveTask (`org.vicko.wavetask`)**
        - Ketebalan dock: `thickness=114px`
        - Tipe panel: `panelLengthMode=1` (Fit Content / centered floating dock)
        - Visibilitas: `panelVisibility=2` (Dodge Windows / Auto-Hide cerdas ala macOS Dock)
        - Efek zoom pembesaran icon: `magnification=80%`, `amplitud=1.1`, `iconSize=54px`
        - Grouping strategy: `groupingStrategy=0` (Task grouping rapi)
        - Audio stream indicator: `indicateAudioStreams=false`, `interactiveMute=false`
        - Reflection: `showReflection=false`
        - Pinned Favorite Apps: System Settings, Discover, Dolphin File Manager, Google Chrome, Konsole, Plasma System Monitor, WhatsApp Web PWA, YouTube PWA
        - Pre-compiled Qt6 QML plugin (`libwavetaskplugin.so`) dan layout template terpasang di `/usr/lib/qt6/qml/org/vicko/wavetask/` dan `/usr/share/plasma/layout-templates/org.vicko.wavetask.panel/`
      - **Secondary Bottom Panel (Panel 517)**:
        - Floating panel 40px berisi Trash (`org.kde.plasma.trash`), Margins Separator, dan AppGrid Launcher Center (`dev.xarbit.appgrid` dengan trigger tombol `Meta`, background opacity 100%, corner radius 25px).

   c. **KWin Effects, Tiling Scripts & Window Rules**:
      - Aktifkan KWin Effects: better_blur_dx (BlurStrength=15, CornerRadius=24), forceblur (patterns: Nautilus, yakuake, urxvt), glide effect (10°), scale effect (0.6), diminactive (50%).
      - Aktifkan KWin Scripts (5 scripts lengkap di ~/.local/share/kwin/scripts/):
        - KZones (FancyZones window snapping dengan 6 layout kustom: Twin Full, Priority Grid, Quadrant Grid, Creator Workspace, Master & Stack, Media Timeline; shortcut Meta+Space untuk snap, Ctrl+Alt+C toggle overlay, Ctrl+Alt+D cycle).
        - Sticky Window Snapping (tepi jendela menempel rapi saat resize).
        - Karousel (Scrollable tiling extension).
        - FullScreenify (macOS full-screen behavior ke workspace baru).
        - Truely Maximized (Sembunyikan titlebar saat maximized).
      - Pasang KWin Window Rules (~/.config/kwinrulesrc):
        - Otomatis atur ukuran dan penempatan: CopyQ (450x550), Konsole (600x400), System Monitor (600x450), Kalkulator (320x500), Window default (1000x600).
      - Aktifkan overview effect pada Meta+W dan edge barrier.

   d. **Trackpad Gestures Laptop (1:1 Mac Feel) & Power Management**:
      - Pasang libinput-gestures (~/.config/libinput-gestures.conf):
        - 3 Jari Swipe Bawah: Expose / Present Windows
        - 3 Jari Swipe Atas: Desktop Grid / Mission Control
        - 3 Jari Swipe Kiri / Kanan: Browser History Back / Forward
        - 4 Jari Swipe Atas / Bawah: Maximize / Minimize Window
        - 4 Jari Swipe Kiri / Kanan: Switch Virtual Desktop
      - Aktifkan service: `libinput-gestures-setup autostart start`
      - Power Management (~/.config/powerdevilrc & powermanagementprofilesrc): Anti-sleep saat lid ditutup (`LidAction=0`), layar tidak dim/mati mendadak (`DimDisplayWhenIdle=false`).

   e. **Font Rendering, Terminal & App Tweaks**:
      - Fontconfig (~/.config/fontconfig/fonts.conf): 1080p pixel-perfect sharpness, DPI 86, subpixel RGB, slight hinting, antialiasing, mapping Calibri & Wingdings.
      - Notifikasi (~/.config/plasmanotifyrc): Popup dibisukan (`ShowPopups=false`) agar Dynamic Island memegang kendali notifikasi tanpa tabrakan.
      - Alacritty: Opacity 0.8, dark titlebar, Nord color scheme, monospace size 12.
      - Fish Shell: config.fish dengan integrasi CachyOS fish config dan alias kustom (AI='qwen', remwm).
      - Dolphin File Manager: Menubar disabled (clean macOS style), delete item enabled, preview size 144px, full multimedia thumbnailers.
      - Konsole: Menubar disabled (clean macOS style).
      - Spectacle: OCR aktif (eng, ind), auto close after OCR, quit after save.
      - KRunner: FreeFloating=true (Spotlight style di tengah layar).
      - PWA Launchers: Desktop entries & 256x256 hicolor icons untuk WhatsApp Web, YouTube, Figma GPU Fix.
      - Dolphin File Manager: Menubar disabled (clean macOS style), delete item enabled, preview size 144px, full multimedia thumbnailers.
      - Konsole: Menubar disabled (clean macOS style).
      - Spectacle: OCR aktif (eng, ind), auto close after OCR, quit after save.
      - KRunner: FreeFloating=true (Spotlight style di tengah layar).

   f. **CachyOS Performance & Kernel Optimizations**:
      - Linux Kernel BORE + LTO (linux-cachyos-bore-lto) responsiveness tuning.
      - ananicy-cpp service aktif dengan cachyos-ananicy-rules (auto nice priority optimizer).
      - ZRAM Generator aktif dengan algoritma zstd, ukuran 2x RAM, swap priority 100.
      - cachyos-rate-mirrors.timer aktif untuk pembaruan mirror repo berkecepatan tinggi.

4. Setelah seluruh konfigurasi terpasang, lakukan reload KWin dan Plasma Shell:
   qdbus org.kde.KWin /KWin reconfigure
   systemctl --user restart plasma-plasmashell
   systemctl --user restart dynamic-island.service

Laporkan status instalasi setiap komponen di terminal dan pastikan tampilan desktop laptop baru saya sudah menyala indah dan 100% mirip dengan desktop PC saya.
```
