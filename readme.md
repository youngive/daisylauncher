# DaisyLauncher

![FastDale Logo](assets/apple-touch-icon.png)

**DaisyLauncher** - это open-source лаунчер на PyQt5 для легаси аватар-чатов, использующих технологию Adobe Flash Player

# Плюсы DaisyLauncher
Из плюсов можно выделить:

1. **Лёгкий запуск**. Для работы достаточно открыть исполняемый файл

2. **Поддержку**. Этот репозиторий будет постоянно обновляться

3. **Минималистичность**. Геймплей доступен на любом проекте в < чем 100 строках


# Сборка

1. Клонируем репозиторий
2. Запускаем `install.bat` / `install.sh` (требуется изменение прав доступа через `chmod +x`) для установки зависимостей
3. Запускаем `build_windows.bat` / `build_linux.sh` (требуется изменение прав доступа через `chmod +x`) для создания исполняемого файла под Windows / Linux
4. Теперь вы можете его найти в директории `dist` и наслаждаться игрой

# Дополнительный шаг для корректной работы лаунчера
Т. к. лаунчер не предусматривает содержания внутри себя PepperFlash (Adobe Flash Player под Chrome), его нужно установить отдельно, для этого под пользователей OS Linux (Fedora, Arch/Manjaro, Debian/Ubuntu) предусмотрен shell-установщик `install_flash_linux.sh`, пользователи OS Windows могут скачать плагин [здесь](https://archive.org/download/flashplayer_old/flashplayer32_0r0_371_winpep.exe)

# Лицензия

Делайте что хотите, но на ваш страх и риск.