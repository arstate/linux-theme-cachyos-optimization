# ⚡ PROMPT SEKALI COPAS UNTUK AI AGENT (ONE-CLICK AI AGENT PROMPT)

> **Instruksi untuk Pengguna:**
> Saat laptop baru Anda sudah selesai diinstall CachyOS, buka aplikasi terminal atau IDE dengan AI Agent (Antigravity CLI, Claude Code, Cursor, Windsurf, Cline, Aider, dll.), lalu **cukup copy-paste seluruh teks di dalam kotak kode di bawah ini sekali saja**. AI Agent akan otomatis membaca repository publik Anda di GitHub, mengunduh seluruh konfigurasi, mengompilasi Dynamic Island, memasang tema macOS, mengatur layout panel, kwin script, dan mengaktifkan optimasi CachyOS sehingga tampilan dan performa laptop baru Anda **100% identik dengan PC desktop saat ini**!

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
        - Pinned Favorite Apps: System Settings, Discover, Dolphin File Manager, Google Chrome, Konsole, Plasma System Monitor, Web Apps
      - **Secondary Bottom Panel (Panel 517)**:
        - Floating panel 40px berisi Trash (`org.kde.plasma.trash`), Margins Separator, dan AppGrid Launcher Center (`dev.xarbit.appgrid` dengan trigger tombol `Meta`, background opacity 100%, corner radius 25px).

   c. **KWin Effects, Tiling Scripts & Window Rules**:
      - Aktifkan KWin Effects: better_blur_dx (BlurStrength=15, CornerRadius=24), forceblur (patterns: Nautilus, yakuake, urxvt), glide effect (10°), scale effect (0.6), diminactive (50%).
      - Aktifkan KWin Scripts:
        - KZones (FancyZones window snapping dengan 6 layout kustom: Twin Full, Priority Grid, Quadrant Grid, Creator Workspace, Master & Stack, Media Timeline; shortcut Meta+Space untuk snap, Ctrl+Alt+C toggle overlay, Ctrl+Alt+D cycle).
        - Sticky Window Snapping (tepi jendela menempel rapi saat resize).
      - Pasang KWin Window Rules (~/.config/kwinrulesrc):
        - Otomatis atur ukuran dan penempatan: CopyQ (450x550), Konsole (600x400), System Monitor (600x450), Kalkulator (320x500), Window default (1000x600).
      - Aktifkan overview effect pada Meta+W dan edge barrier.

   d. **Trackpad Gestures Laptop (1:1 Mac Feel)**:
      - Pasang libinput-gestures (~/.config/libinput-gestures.conf):
        - 3 Jari Swipe Bawah: Expose / Present Windows
        - 3 Jari Swipe Atas: Desktop Grid / Mission Control
        - 3 Jari Swipe Kiri / Kanan: Browser History Back / Forward
        - 4 Jari Swipe Atas / Bawah: Maximize / Minimize Window
        - 4 Jari Swipe Kiri / Kanan: Switch Virtual Desktop
      - Aktifkan service: `libinput-gestures-setup autostart start`

   e. **Font Rendering, Terminal & App Tweaks**:
      - Fontconfig (~/.config/fontconfig/fonts.conf): 1080p pixel-perfect sharpness, DPI 86, subpixel RGB, slight hinting, antialiasing, mapping Calibri & Wingdings.
      - Alacritty: Opacity 0.8, dark titlebar, Nord color scheme, monospace size 12.
      - Fish Shell: config.fish dengan integrasi CachyOS fish config dan alias kustom (AI='qwen', remwm).
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

---

## 🇺🇸 ENGLISH VERSION (FOR INTERNATIONAL / ENGLISH AI AGENTS)

```markdown
Please configure this freshly installed CachyOS system (KDE Plasma 6 on Wayland) on my new laptop to be 100% identical in appearance, layout, widgets, and performance tuning to my desktop PC, using my official public GitHub repository:
https://github.com/arstate/linux-theme-cachyos-optimization

Execute the complete setup automatically via terminal:

1. Clone repository to temporary path:
   rm -rf /tmp/linux-theme-cachyos-optimization
   git clone https://github.com/arstate/linux-theme-cachyos-optimization.git /tmp/linux-theme-cachyos-optimization
   cd /tmp/linux-theme-cachyos-optimization

2. Run the automated master installer:
   chmod +x install.sh
   ./install.sh

3. Verify and ensure the following core configurations are active:
   - macOS Dark Theme (MacTahoe-Dark / MacVentura-Dark Look-and-Feel, WhiteSur-dark Plasma theme, MacVenturaDark color scheme, MacTahoe-dark icons & cursors).
   - Window decorations: __aurorae__svg__MacVentura-Dark with traffic-light buttons on the LEFT (Close, Minimize, Maximize / XIA) and BorderlessMaximizedWindows=true.
   - Top Panel (32px): Kpple Apple Menu (cat2 icon) + Application Title Bar + Global Menu + Spacer + KDE Control Station + Tray.
   - Dynamic Island Wayland Native Daemon: Compiled from https://github.com/arstate/dynamic-island into ~/.local/bin/dynamic-island, configured with notch style, Sidoarjo weather, systemd user service enabled.
   - Bottom Dock (114px): Wave Taskbar (org.vicko.wavetask) with magnification=80%, amplitude=1.1, iconSize=54px, auto-hide / dodge windows.
   - Secondary Floating Panel: AppGrid Launcher (Meta key trigger) + Trash.
   - KWin Effects, Scripts & Window Rules: better-blur-dx, forceblur, KZones (with 6 custom productivity layouts), Sticky Window Snapping, and window rules for CopyQ, terminal, kalkulator, system monitor.
   - Laptop Trackpad Gestures: libinput-gestures (3-finger swipe down for Expose, 3-finger swipe up for Mission Control grid, 4-finger swipe for minimize/maximize and desktop switching).
   - Font Sharpness: fontconfig (fonts.conf with 1080p pixel-perfect sharpness, DPI 86, subpixel RGB, slight hinting).
   - Wallpaper: 2K White Cat on Precipice.
   - CachyOS Optimizations: BORE Kernel, ananicy-cpp process priority auto-tuner, zram-generator (zstd, 2x RAM), cachyos-rate-mirrors.timer.
   - Clean reload of KWin, Plasma Shell, and Dynamic Island service.

Provide a comprehensive status report confirming that every single component is fully functional.
```
