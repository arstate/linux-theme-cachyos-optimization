# 🍎 CachyOS Linux macOS Rice & System Optimization Suite

[![CachyOS](https://img.shields.io/badge/OS-CachyOS%20(Arch%20Based)-0078D7?style=for-the-badge&logo=arch-linux&logoColor=white)](https://cachyos.org/)
[![KDE Plasma 6](https://img.shields.io/badge/Desktop-KDE%20Plasma%206%20(Wayland)-1D99F3?style=for-the-badge&logo=kde&logoColor=white)](https://kde.org/plasma-desktop/)
[![Dynamic Island](https://img.shields.io/badge/Widget-Dynamic%20Island%20Native-FF453A?style=for-the-badge&logo=apple&logoColor=white)](https://github.com/arstate/dynamic-island)
[![Kernel](https://img.shields.io/badge/Kernel-BORE%20%2B%20LTO-5856D6?style=for-the-badge&logo=linux&logoColor=white)](https://cachyos.org/)

Repositori resmi arsitektur tema, kustomisasi visual macOS Dark, widget Dynamic Island native Wayland, layout panel/dock, KWin scripts, dan optimasi performa kernel CachyOS milik **[arstate](https://github.com/arstate)**.

Dibuat untuk memudahkan replikasi 100% otomatis ke laptop/PC baru tanpa perlu mengedit pengaturan satu per satu secara manual.

---

## ⚡ INSTALASI 1-KLIK VIA AI AGENT

> [!TIP]
> **Punya laptop baru dengan CachyOS yang baru diinstall?**  
> Anda tidak perlu repot-repot setup manual satu per satu! Copy prompt di bawah ini lalu paste ke AI Agent Anda (Antigravity CLI, Cursor, Claude Code, Windsurf, Cline, Aider). AI Agent akan mengeksekusi seluruh setup secara otomatis dari GitHub!

<details open>
<summary><b>📋 Klik untuk Buka / Copy Prompt One-Click AI Agent:</b></summary>

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
</details>

Atau jalankan instalasi mandiri via terminal:

```bash
git clone https://github.com/arstate/linux-theme-cachyos-optimization.git /tmp/linux-theme-cachyos-optimization
cd /tmp/linux-theme-cachyos-optimization
chmod +x install.sh
./install.sh
```

---

## 🖥️ ARSITEKTUR DESKTOP & TEMA VISUAL

### 1. Tema macOS Dark Glassmorphism
- **Global Theme (Look-and-Feel)**: `com.github.vinceliuice.MacTahoe-Dark` & `MacVentura-Dark`
- **Plasma Theme**: `WhiteSur-dark`
- **Color Scheme**: `MacVenturaDark` (Accent: macOS Vibrant Blue `#315BEF` / Selection `#315BEF`)
- **Icon Theme**: `MacTahoe-dark` (dengan varian warna lengkap)
- **Cursor Theme**: `MacTahoe-dark` (Size: 24)
- **Window Decoration (Aurorae)**: `__aurorae__svg__MacVentura-Dark`
  - Tombol kontrol di sisi **KIRI**: `Close (X)`, `Minimize (I)`, `Maximize (A)`
  - Border: `None`
  - `BorderlessMaximizedWindows`: `true` (jendela maximized menyatu rapi tanpa titlebar ganda)
- **Kvantum Engine**: `MacTahoeDark` (efek frosted glass blur transparan pada aplikasi Qt)
- **GTK 3 & GTK 4**: `WhiteSur-Dark` dengan injeksi `gtk.css` kustom
- **Wallpaper**: White Cat on Mountain Precipice 2K (`assets/wallpapers/White_cat_sitting_on_precipice_2K.jpeg`)
- **Lock Screen**: MacVentura-Dark (Timeout: 15 menit)
- **SDDM Login Screen**: `MacTahoe-Dark`
- **Plymouth Boot Animation**: `apple-mac-plymouth`

---

## 🏝️ DYNAMIC ISLAND NATIVE WAYLAND

Dynamic Island berjalan sebagai daemon native Wayland berkecepatan tinggi yang dikompilasi langsung dari repository kustom arstate: **[arstate/dynamic-island](https://github.com/arstate/dynamic-island)**.

### Fitur Unggulan:
- **Tampilan Notch Apple**: `look=notch`, tinggi `32px`, `compactWidth=160px`, `idleWidth=130px`, `radius=10px`.
- **Aksen Warna**: Apple Red `#ff453a`.
- **Weather Telemetry**: Cuaca real-time Sidoarjo (Lat: `-7.4478`, Lon: `112.7183`, Celcius).
- **Kawaii Cat Morph Animation**: Mata kucing kartun animasi dinamis (`blink`, `lookLeft`, `lookRight`, `happy`, `excited`, `wink`, `sleepy`).
- **Interactive Photo Card**: Widget foto interaktif dengan rounded corner, drag-to-pan, dan mouse-wheel zoom (100%–500%).
- **Virtual Desktop Switcher**: Indikator live workspace dan navigasi KWin D-Bus.
- **PWA Notification Intelligence**: Notifikasi Chrome PWA (WhatsApp Web, Instagram, Netflix, YouTube) menampilkan logo aplikasi asli.
- **Systemd Service**: `dynamic-island.service` berjalan otomatis di background (`restart=always`, `QT_QPA_PLATFORM=wayland`).

---

## 📊 STRUKTUR PANEL & DOCK

### Top Bar (Panel 410)
- **Ketinggian**: `32px` | **Mode**: Full Width | **Visibilitas**: Always Visible
- **Susunan Widget**:
  1. `com.github.chrtall.kppleMenu` (Apple Logo Menu dengan icon custom `cat2.png`)
  2. `com.github.antroids.application-title-bar` (Judul window aktif + kontrol tombol)
  3. `org.kde.plasma.appmenu` (Global Menu Bar: File, Edit, View, Window, Help)
  4. `org.kde.plasma.panelspacer` (Flexible expanding spacer)
  5. `KdeControlStation` (macOS Big Sur/Ventura Control Center dengan icon toggle kustom)
  6. `org.kde.plasma.systemtray` (System Tray & Network Manager)
  7. `org.kde.plasma.marginsseparator`

### Dynamic Island Pill (Center Top)
- Mengambang tepat di tengah atas layar, menyatu mulus di antara Global Menu dan Control Center.

### Floating Dock (Panel 492 - WaveTask)
- **Ketinggian**: `114px` (`thickness=114`) | **Mode**: Fit Content (`panelLengthMode=1`) | **Visibilitas**: Auto-hide / Dodge Windows (`panelVisibility=2`)
- **Widget**: `org.vicko.wavetask` (Wave Taskbar ala macOS Dock)
  - **Efek Pembesaran Ikon (Zoom/Magnification)**: `magnification=80%`, `amplitud=1.1`
  - **Ukuran Dasar Ikon**: `iconSize=54px`
  - **Grouping Strategy**: `groupingStrategy=0` (Grouping aplikasi cerdas dan rapi)
  - **Audio Stream Indicator**: `indicateAudioStreams=false`, `interactiveMute=false`
  - **Reflection**: `showReflection=false` (clean look tanpa pantulan semu)
  - **macOS Dock Bounce Animation**: Animasi icon melompat saat meluncurkan aplikasi
  - **Aplikasi Tersemat (Pinned Launchers)**: System Settings, Discover, Dolphin File Manager, Google Chrome, Konsole, Plasma System Monitor, Google Drive, WhatsApp PWA, Netflix PWA.
  - **QML Plugin**: Menggunakan native C++ QML plugin `libwavetaskplugin.so` dari package `wavetask` (AUR) + backup plasmoid lengkap di repository.

### Secondary Applet Panel (Panel 517)
- **Ketinggian**: `40px` | **Mode**: Floating (`floating=1`) | **Visibilitas**: Auto-hide (`panelVisibility=2`)
- **Widget**:
  - `org.kde.plasma.trash` (Tong Sampah macOS)
  - `dev.xarbit.appgrid` (AppGrid Launcher Center dengan trigger tombol `Meta`, background opacity 100%, corner radius 25px)

### Desktop Widgets (Containment 409)
- `org.kde.plasma.analogclock` (Analog Grand Clock elegan di pojok kanan atas)

---

## 🪟 KWIN SCRIPTS, WINDOW RULES & GESTURES

### 1. KZones (Tiling Window Manager ala FancyZones)
Membagi layar menjadi zona-zona produktivitas presisi tinggi tanpa batas:
- **Layout 1: Twin Full** (Dua jendela berdampingan 50:50)
- **Layout 2: Priority Grid** (Satu fokus utama 50% di tengah, dua panel 25% di kiri-kanan)
- **Layout 3: Quadrant Grid** (Empat jendela 2x2 seimbang)
- **Layout 4: Creator Workspace** (Fokus tengah 70%, dua panel referensi 15%)
- **Layout 5: Master & Stack** (Master window 60% kiri, stack dua window 40% kanan)
- **Layout 6: Media Timeline** (Dua window 50% atas untuk preview, 1 bar horizontal bawah untuk timeline editing)

#### Shortcuts KZones:
- `Meta + Space`: Snap seluruh jendela ke zona terdekat
- `Meta + Shift + Space`: Snap jendela aktif ke zona
- `Ctrl + Alt + C`: Buka / tutup overlay visual zona
- `Ctrl + Alt + D`: Siklus layout berikutnya
- `Ctrl + Alt + Shift + D`: Siklus layout sebelumnya
- `Ctrl + Alt + Panah`: Pindahkan jendela ke zona berikutnya / sebelumnya

### 2. Sticky Window Snapping
Membuat tepi dua jendela yang saling menempel tetap menempel secara elastis saat salah satu ukuran jendela di-resize.

### 3. KWin Window Rules (`kwinrulesrc`)
Aturan otomatis ukuran dan peletakan jendela saat dibuka:
- **CopyQ**: Ukuran fixed 450x550, shortcut `Meta+C`
- **Konsole (Terminal)**: Ukuran default 600x400
- **System Monitor**: Ukuran default 600x450
- **Kalkulator (Kalk)**: Ukuran default 320x500
- **TikTok PWA**: Ukuran vertikal smartphone 600x900 di koordinat (90, 100)
- **General Windows**: Ukuran fallback 1000x600

### 4. Trackpad Gestures Laptop 1:1 macOS (`libinput-gestures.conf`)
- **3 Jari Gesek Bawah**: Expose / Present Windows
- **3 Jari Gesek Atas**: Mission Control / Desktop Grid
- **3 Jari Gesek Kiri / Kanan**: Navigasi Web Back / Forward (`Alt+Left` / `Alt+Right`)
- **4 Jari Gesek Atas**: Maximize Window aktif
- **4 Jari Gesek Bawah**: Minimize Window aktif
- **4 Jari Gesek Kiri / Kanan**: Berpindah Virtual Desktop berikutnya / sebelumnya

### 5. Font Sharpness & Pixel-Perfect Rendering (`fonts.conf`)
- Optimalisasi render layar 1080p dengan DPI 86 (`ForceFontDPI=86`)
- Antialiasing aktif + Slight Hinting (`hintslight`) + Subpixel RGB rendering
- Substitusi font Microsoft (Calibri, Wingdings) untuk kompatibilitas dokumen

### 6. Blur & Efek Kustom
- `kwin-effects-better-blur-dx`: Blur Strength 15, Corner Radius 24px, Refraction glass.
- `kwin-scripts-forceblur`: Memaksa efek blur pada jendela Nautilus, Yakuake, dan terminal.
- `Effect-glide`: Animasi buka/tutup window meluncur dengan rotasi 10°.
- `Effect-scale`: Scale in/out 0.6.
- `Overview`: Aktif via `Meta + W` atau pojok layar.

---

## 🚀 OPTIMASI PERFORMA CACHYOS

Sistem ini dikonfigurasi untuk performa gaming, kompilasi kode, dan multitasking berat:
1. **Linux Kernel BORE (Burst-Oriented Response Enhancer) + LTO**:
   - Menjamin 0% micro-stutter pada UI desktop dan latensi input rendah saat CPU 100% load.
2. **Auto Nice Priority Optimizer (`ananicy-cpp`)**:
   - Menyesuaikan prioritas CPU & IO secara real-time untuk browser, IDE, video editor, dan game.
3. **ZRAM Generator (zstd compression)**:
   - Alokasi RAM swap terkompresi hingga 2x kapasitas RAM fisik dengan algoritma zstd berkecepatan tinggi. Nol aus pada NVMe SSD.
4. **Mirror Ranking Otomatis (`cachyos-rate-mirrors.timer`)**:
   - Menjaga koneksi download package selalu di mirror tercepat di Asia/Indonesia.

---

## 📁 STRUKTUR REPOSITORI

```
linux-theme-cachyos-optimization/
├── README.md                          # Dokumentasi utama repositori
├── README_AI_AGENT.md                 # Prompt sekali copas untuk AI Agent
├── PROMPT_COPAS_AI_AGENT.md           # Prompt dua bahasa (ID & EN)
├── install.sh                         # Master script instalasi 100% otomatis
├── restore-configs.sh                 # Quick restore konfigurasi
├── configs/
│   ├── kde/                           # Konfigurasi lengkap KDE Plasma 6
│   │   ├── kdeglobals                 # Palet warna, theme, DPI font (86)
│   │   ├── kwinrc                     # Dekorasi jendela, blur dx, KZones layouts
│   │   ├── kwinrulesrc                # Aturan ukuran/posisi jendela otomatis
│   │   ├── breezerc                   # Style widget Breeze & left title alignment
│   │   ├── plasmarc                   # Theme plasma WhiteSur-dark
│   │   ├── plasmashellrc              # Konfigurasi panel 410, 492 (WaveTask), 517
│   │   ├── plasma-org.kde.plasma.desktop-appletsrc # Konfigurasi applet & dock lengkap
│   │   ├── kcminputrc                 # Cursor MacTahoe-dark & akselerasi mouse
│   │   ├── kscreenlockerrc            # Lock screen wallpaper & timeout 15 min
│   │   ├── krunnerrc                  # Spotlight search mengambang
│   │   ├── kglobalshortcutsrc         # Pemetaan shortcut Meta/Mac komprehensif
│   │   ├── dolphinrc                  # File manager Dolphin tanpa menubar
│   │   ├── spectaclerc                # Tangkapan layar Spectacle + OCR Indo/Eng
│   │   ├── konsolerc                  # Terminal Konsole minimalis tanpa menubar
│   │   └── kwinoutputconfig.json      # Output layar 1080p 60Hz Wayland
│   ├── kvantum/                       # Kvantum frosted glass (MacTahoe, MacVentura, WhiteSur)
│   ├── gtk/                           # GTK 3 & GTK 4 themes dan custom css
│   ├── fontconfig/                    # fonts.conf pixel-perfect font rendering
│   ├── libinput/                      # libinput-gestures.conf Mac trackpad gestures
│   ├── dynamic-island/                # Config, daemon service & collector Dynamic Island
│   ├── alacritty/                     # Terminal Alacritty config (Nord theme, opacity 0.8)
│   ├── fish/                          # Shell fish config & custom aliases
│   ├── sddm/                          # Login manager config (MacTahoe-Dark)
│   └── plymouth/                      # Boot animation config (apple-mac-plymouth)
├── assets/
│   ├── icons/                         # Ikon custom (cat1, cat2, cat3, control center)
│   ├── wallpapers/                    # 2K Cat Precipice Wallpaper
│   ├── color-schemes/                 # MacVenturaDark & MacTahoeDark
│   └── aurorae/                       # Aurorae window decoration themes
├── plasmoids/                         # Plasmoids widget desktop & panel (termasuk WaveTask)
├── kwin-scripts/                      # KZones & Sticky Window Snapping
└── optimizations/                     # CachyOS packages list, zram, & kernel docs
```

---

## 📄 LISENSI
MIT License © 2026 [arstate](https://github.com/arstate). Dilengkapi tema dan skrip open-source dari Vinceliuice, Vicko, EliverLara, ChrTall, Antroids, dan Gerrit DeVriese.
