# CachyOS Performance & Optimization Architecture

This guide details the exact performance tuning stack running on this machine.

## 1. Linux Kernel: BORE + LTO
- **Kernel Package**: `linux-cachyos-bore-lto` / `linux-cachyos`
- **Scheduler**: **BORE (Burst-Oriented Response Enhancer)**
  - Dynamically detects and prioritizes interactive desktop tasks, audio processing, and gaming over background throughput tasks.
  - Mitigates frame drops, micro-stutters, and input latency under heavy system load.
- **LTO (Link-Time Optimization)**: Whole-program optimization with clang/LLVM for maximum instruction cache locality.

## 2. Process Auto-Tuner: ananicy-cpp
- **Daemon**: `ananicy-cpp.service` (C++ rewrite of Ananicy)
- **Rules**: `cachyos-ananicy-rules`
- **Function**: Automatically sets nice levels, IO scheduler classes (Realtime/Best Effort), and OOM score adjustments for known processes (browsers, games, media players, IDEs, desktop shell).
- **Service Command**:
  ```bash
  sudo systemctl enable --now ananicy-cpp
  ```

## 3. Memory Optimization: ZRAM Generator (zstd)
- **Config**: `/etc/systemd/zram-generator.conf`
  ```ini
  [zram0]
  compression-algorithm = zstd
  zram-size = ram * 2
  swap-priority = 100
  fs-type = swap
  ```
- **Benefits**:
  - Dynamically allocates a compressed RAM swap block up to 2x physical RAM.
  - Zero disk thrashing on NVMe/SSD.
  - Near-zero latency decompression via zstd algorithm.

## 4. Sched-ext (scx) eBPF Schedulers
- **Packages**: `scx-scheds`, `scx-manager`, `scx-tools`
- **Supported Schedulers**:
  - `scx_lavd`: Gaming & latency-critical workloads.
  - `scx_rusty`: Balanced desktop interactivity.
  - `scx_bpfland`: Interactive desktop responsiveness.
- **Run on demand**:
  ```bash
  sudo scx_lavd
  ```

## 5. Automated Mirror Ranking
- **Timer**: `cachyos-rate-mirrors.timer`
- Regularly benchmarks CachyOS and Arch package mirrors to ensure maximum download speeds during system updates.
- **Command**:
  ```bash
  sudo systemctl enable --now cachyos-rate-mirrors.timer
  ```
