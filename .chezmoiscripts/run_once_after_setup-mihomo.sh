#!/bin/bash

# 1. 确保配置目录存在
mkdir -p "$HOME/.config/mihomo"

# 2. 检查并安装 mihomo (针对 Linux)
if ! command -v mihomo &> /dev/null; then
    echo "Mihomo 未安装，尝试通过 pacman 安装..."
    sudo pacman -S --noconfirm mihomo
fi

# 3. 设置 Systemd 用户服务
SERVICE_FILE="$HOME/.config/systemd/user/mihomo.service"
mkdir -p "$(dirname "$SERVICE_FILE")"

cat << SERVICE_EOF > "$SERVICE_FILE"
[Unit]
Description=Mihomo (Clash Meta) Daemon
After=network.target

[Service]
Type=simple
ExecStart=$(command -v mihomo || echo /usr/bin/mihomo) -d %h/.config/mihomo
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
SERVICE_EOF

# 4. 重载服务并启动
if command -v systemctl &> /dev/null; then
    systemctl --user daemon-reload
    systemctl --user enable mihomo
    systemctl --user restart mihomo
    echo "Mihomo 后台服务已启动。"
fi
