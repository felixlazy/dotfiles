#!/bin/zsh

# 判断目录是否存在，不存在则创建
if [ ! -d ~/.config/chezmoi ]; then
	mkdir -p ~/.config/chezmoi
fi

# 创建符号链接
if [ ! -L ~/.config/chezmoi/chezmoi.toml ]; then
  ln -s ~/OneDrive/.config/chezmoi/chezmoi.toml ~/.config/chezmoi/chezmoi.toml
else
  echo "Symbolic link already exists."
fi
