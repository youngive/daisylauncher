#!/bin/bash

# Определение дистрибутива
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Не удалось определить дистрибутив Linux."
    exit 1
fi

# Установка PepperFlash для Ubuntu/Debian
install_pepperflash_ubuntu() {
    echo "Установка PepperFlash для Ubuntu/Debian..."

    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    sudo apt update
    sudo apt install -y adobe-flashplugin
}

# Установка PepperFlash для Fedora
install_pepperflash_fedora() {
    echo "Установка PepperFlash для Fedora..."

    sudo dnf install -y curl
    sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
    sudo sh -c 'echo -e "[google-chrome]\nname=Google Chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo'
    sudo dnf install -y google-chrome-stable

    sudo dnf install -y chromium-libs-media-freeworld
}

# Установка PepperFlash для Arch Linux / Manjaro
install_pepperflash_arch() {
    echo "Установка PepperFlash для Arch Linux / Manjaro..."

    # Проверка и установка yay, если он не установлен
    if ! command -v yay &> /dev/null; then
        echo "yay не найден. Установка yay..."
        sudo pacman -Syu --noconfirm
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    fi

    # Установка PepperFlash из AUR
    yay -Syu --noconfirm
    yay -S --noconfirm pepper-flash
}

# Определение и запуск установки в зависимости от дистрибутива
case $DISTRO in
    ubuntu|debian)
        install_pepperflash_ubuntu
        ;;
    fedora)
        install_pepperflash_fedora
        ;;
    arch|manjaro)
        install_pepperflash_arch
        ;;
    *)
        echo "Дистрибутив $DISTRO не поддерживается этим скриптом."
        exit 1
        ;;
esac

echo "Установка PepperFlash завершена."
