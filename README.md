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
> Anda tidak perlu repot-repot setup manual satu per satu! Buka file [README_AI_AGENT.md](file:///home/arya/FILE%20DATA/SOFTWARE%20LINUX/linux%20theme%20cacy%20os%20optimization/README_AI_AGENT.md) atau [PROMPT_COPAS_AI_AGENT.md](file:///home/arya/FILE%20DATA/SOFTWARE%20LINUX/linux%20theme%20cacy%20os%20optimization/PROMPT_COPAS_AI_AGENT.md), copy prompt-nya, lalu paste ke AI Agent Anda (Antigravity CLI, Cursor, Claude Code, Windsurf, Cline). AI Agent akan mengeksekusi seluruh setup secara otomatis!

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

### Floating Dock (Panel 492)
- **Ketinggian**: `114px` | **Mode**: Fit Content | **Visibilitas**: Auto-hide / Dodge Windows
- **Widget**: `org.vicko.wavetask` (Wave Taskbar)
  - Pembesaran ikon halus (`magnification=80`, `amplitud=1.1`)
  - Icon Size: `54px`
  - macOS dock bounce animation saat membuka aplikasi

### Secondary Applet Panel (Panel 517)
- **Ketinggian**: `40px` | **Mode**: Floating | **Visibilitas**: Auto-hide
- **Widget**:
  - `org.kde.plasma.trash` (Tong Sampah macOS)
  - `dev.xarbit.appgrid` (AppGrid Launcher Center dengan trigger tombol `Meta`)

### Desktop Widgets (Containment 409)
- `org.kde.plasma.analogclock` (Analog Grand Clock elegan di pojok kanan atas)

---

## 🪟 KWIN SCRIPTS & WINDOW TILING

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

### 3. Blur & Efek Kustom
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
│   │   ├── kdeglobals
│   │   ├── kwinrc
│   │   ├── plasmarc
│   │   ├── plasmashellrc
│   │   ├── plasma-org.kde.plasma.desktop-appletsrc
│   │   ├── kcminputrc
│   │   ├── kscreenlockerrc
│   │   ├── krunnerrc
│   │   ├── kglobalshortcutsrc
│   │   └── dolphinrc
│   ├── kvantum/                       # Kvantum frosted glass themes
│   ├── gtk/                           # GTK 3 & GTK 4 themes dan custom css
│   ├── dynamic-island/                # Config & systemd service Dynamic Island
│   ├── alacritty/                     # Terminal Alacritty config
│   ├── fish/                          # Shell fish config & custom aliases
│   ├── sddm/                          # Login manager config
│   └── plymouth/                      # Boot animation config
├── assets/
│   ├── icons/                         # Ikon custom (cat1, cat2, cat3, control center)
│   ├── wallpapers/                    # 2K Cat Precipice Wallpaper
│   ├── color-schemes/                 # MacVenturaDark & MacTahoeDark
│   └── aurorae/                       # Aurorae window decoration themes
├── plasmoids/                         # Plasmoids widget desktop & panel
├── kwin-scripts/                      # KZones & Sticky Window Snapping
└── optimizations/                     # CachyOS packages list, zram, & kernel docs
```

---

## 📄 LISENSI
MIT License © 2026 [arstate](https://github.com/arstate). Dilengkapi tema dan skrip open-source dari Vinceliuice, Vicko, EliverLara, ChrTall, Antroids, dan Gerrit DeVriese.
