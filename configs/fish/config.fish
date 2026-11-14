source /usr/share/cachyos-fish-config/cachyos-config.fish

# Qwen CLI shortcuts
alias AI='qwen'
alias ai='qwen'

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

function remwm
    # Aktifkan virtual environment
    source ~/iopaint-ai/venv/bin/activate.fish

    echo (set_color yellow)"=== ARSTATE CINEMA: ONE-DROP MODE ==="(set_color normal)
    echo -n "Drag & Drop folder FOTO KOTOR ke sini, lalu Enter: "
    read -l in_path

    # Bersihkan tanda kutip dan spasi gaib
    set in_path (string trim (string replace -a "'" "" (string replace -a "\"" "" $in_path)))

    if test -d "$in_path"
        # OTOMATIS buat folder 'remwm' di DALAM folder input tadi
        set out_path "$in_path/remwm"
        mkdir -p "$out_path"

        echo (set_color green)"Input Folder : $in_path"(set_color normal)
        echo (set_color cyan)"Output Folder: $out_path (Otomatis dibuat)"(set_color normal)
        echo "---------------------------------------------------"
        
        # Jalankan IOPaint
        iopaint start --model=lama --device=cuda --port=8080 --input "$in_path" --output-dir "$out_path" --enable-interactive-seg --interactive-seg-device=cuda
    else
        echo (set_color red)"Waduh Arya, foldernya nggak ketemu! Coba cek lagi lokasinya."(set_color normal)
    end
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/arya/.lmstudio/bin
# End of LM Studio CLI section


# opencode
fish_add_path /home/arya/.opencode/bin

# Android SDK Configuration (HDD)
set -gx ANDROID_HOME "/mnt/HDD-2/SOFTWARE INSTALL/LINUX APP/android-sdk"

# Tambahkan tool Android ke sistem PATH
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin


# Android SDK Configuration (HDD)
set -gx ANDROID_HOME "/mnt/HDD-2/SOFTWARE INSTALL/LINUX APP/android-sdk"

# Tambahkan tool Android ke sistem PATH
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# Added by Antigravity CLI installer
set -gx PATH "/home/arya/.local/bin" $PATH

# 9Router Root CA for Node.js SSL MITM
set -gx NODE_EXTRA_CA_CERTS "$HOME/.9router/mitm/rootCA.crt"
