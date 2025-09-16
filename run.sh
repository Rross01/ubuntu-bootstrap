#!/bin/bash

set -x
set -a

sudo apt install -y \
    gnome-shell-extensions evolution-ews keepassxc wireshark python3-venv \
    moreutils wl-clipboard podman podman-compose podman-docker golang-go \
    postgresql-client bat curl fzf skopeo sshfs tldr tmux npm ripgrep  \
    network-manager-openconnect network-manager-openconnect-gnome

sudo snap install pinta postman telegram-desktop
sudo snap install --classic pycharm-community

dconf write "/org/gnome/desktop/input-sources/xkb-options" "['caps:swapescape']"
dconf write "/org/gnome/desktop/interface/enable-animations" "false"
dconf write "/org/gnome/desktop/wm/keybindings/close" "['<Shift><Super>q']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-input-source" "['<Alt>Shift_L']"
dconf write "/org/gnome/desktop/wm/keybindings/toggle-maximized" "['<Super>Up']"
dconf write "/org/gnome/settings-daemon/plugins/media-keys/calculator" "['<Super>c']"
dconf write "/org/gnome/settings-daemon/plugins/media-keys/home" "['<Super>e']"
dconf write "/org/gnome/shell/extensions/dash-to-dock/click-action" "'minimize'"
dconf write "/org/gnome/shell/extensions/dash-to-dock/show-trash" "false"
dconf write "/org/gnome/shell/window-switcher/app-icon-mode" "'app-icon-only'"

for file in $(find $PWD/home); do
    RELNAME=$(echo $file | sed "s|$PWD/home/||g")
    if [ -d $file ]; then
        mkdir -p ~/$RELNAME
    else
        ln -sf $file ~/$RELNAME
    fi
done

if [ ! -f /usr/bin/ghostty ]; then
    wget \
        https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.1.3-0-ppa2/ghostty_1.1.3-0.ppa2_amd64_25.04.deb \
        -O /tmp/ghostty.deb
    sudo apt install -y /tmp/ghostty.deb
fi

if [ ! -f /usr/bin/ktalk ]; then
    wget \
        https://st.ktalk.host/ktalk-app/linux/ktalk3.1.0amd64.deb \
        -O /tmp/ktalk.deb
    sudo apt install -y /tmp/ktalk.deb
fi

if [ ! -f ~/.fonts/README.md ]; then
    wget \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ZedMono.zip \
        -O /tmp/ZedMono.zip
    unzip /tmp/ZedMono.zip -d ~/.fonts
fi

if [ ! -d /opt/pytimesched ]; then
    wget \
        https://gitlab.com/ilmenshik/pytimesched/-/jobs/3568673400/artifacts/raw/pyTimeSched-v0.6-linux.tar.gz \
        -O /tmp/pyTimeSched.tar.gz
    sudo mkdir /opt/pytimesched
    sudo tar xzvf /tmp/pyTimeSched.tar.gz -C /opt/pytimesched
    sudo chown -R $USER:$USER /opt/pytimesched
    cat << EOF | sed 's/^[[:space:]]*//' > ~/.local/share/applications/pyTimeSched.desktop
        [Desktop Entry]
        Version=1.0
        Name=pyTimeSched
        Exec=/opt/pytimesched/pyTimeSched
        Icon=/opt/pytimesched/gui/icons/icon.png
        Terminal=false
        Type=Application
EOF
fi

CONTAINER="arch-tools"
TOOLS="kubectl helm helmfile sops k9s dive uv"

if ! podman container exists $CONTAINER; then
    podman run --name $CONTAINER archlinux:latest pacman -Sy --noconfirm --needed $TOOLS
else
    podman start -ai $CONTAINER
fi

for tool in $TOOLS; do
    podman cp $CONTAINER:/usr/bin/$tool ~/.bin
    sudo ln -sf ~/.bin/$tool /usr/bin/$tool
done
