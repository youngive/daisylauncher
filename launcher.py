import sys
import platform
import os
import re
from PyQt5.QtWidgets import QApplication, QMessageBox, QInputDialog
from PyQt5.QtWebEngineWidgets import QWebEngineView, QWebEngineSettings
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QIcon

class MainWindow(QWebEngineView):
    def __init__(self):
        super(MainWindow, self).__init__()

        # Включение поддержки плагинов
        QWebEngineSettings.globalSettings().setAttribute(QWebEngineSettings.PluginsEnabled, True)

        # Установка размера окна
        self.setFixedSize(1280, 720)

        # Установка названия окна
        self.setWindowTitle("DaisyLauncher")

        # Установка иконки окна
        self.setWindowIcon(QIcon("assets/android-chrome-192x192.png"))

        # Установка пользовательского агента
        user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Shararam/2.0.6 Chrome/80.0.3987.165 Electron/8.2.5 Safari/537.36"  # Замените на ваш User-Agent
        self.page().profile().setHttpUserAgent(user_agent)

        # Проверка наличия Adobe Flash Player под Chrome
        if not self.check_flash_player_for_chrome():
            QMessageBox.critical(self, "Ошибка", "Adobe Flash Player под Chrome не найден на вашем компьютере.")
            sys.exit(1)

        # Диалоговое окно для ввода URL
        url, ok = QInputDialog.getText(self, "Ввод URL", "Введите URL для запуска:", text="http://localhost")
        if ok and url:
            self.load(QUrl(url))
        else:
            QMessageBox.critical(self, "Ошибка", "URL не был введен.")
            sys.exit(1)

    def check_flash_player_for_chrome(self):
        if platform.system() == "Windows":
            # Проверка наличия плагина под Chrome на Windows
            flash_dir = "C:\\Windows\\System32\\Macromed\\Flash"
            return self.file_exists(flash_dir, r"pepflashplayer.*\.dll")

        elif platform.system() == "Linux":
            # Проверка наличия плагина под Chrome на Linux в нескольких директориях
            directories = [
                "/opt/google/chrome/PepperFlash",
                "/usr/lib/PepperFlash",
                "/usr/lib/pepflashplugin-installer"
            ]
            pattern = r"libpepflashplayer.so"

            for flash_dir in directories:
                if self.file_exists(flash_dir, pattern):
                    return True

            return False

        # Для других операционных систем предполагаем, что плагин не установлен
        return False

    def file_exists(self, directory, pattern):
        try:
            for filename in os.listdir(directory):
                if re.match(pattern, filename):
                    return True
            return False
        except FileNotFoundError:
            return False

if __name__ == "__main__":
    # Создание приложения
    app = QApplication(sys.argv)

    # Создание и отображение главного окна
    window = MainWindow()
    window.show()

    # Запуск цикла обработки событий
    sys.exit(app.exec())
