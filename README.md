# felix cil

## 软件包管理

### windown

- SCOOP

  - 安装路径
    用户安装路径：SCOOP  
    全局安装目录: SCOOP_GLOBAL
  - 安装

  ```ps1
  #设置允许 PowerShell 执行本地脚本
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  #安装 Scoop
  iwr -useb get.scoop.sh | iex
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  ```

### darwin

- brew

  - 安装

  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## 配置文件管理

### chezmoio

- 安装

  - windoiwn

  ```ps1
  scoop install chezmoi
  ```

  - darwin

  ```sh
  brew install chezmoi
  ```

## 更新配置

- windoiwn

```ps1
chezmoi init https://github.com/Wu-Felix/dotfiles.git
```

- darwin

```sh
chezmoi init https://github.com/Wu-Felix/dotfiles.git
```
