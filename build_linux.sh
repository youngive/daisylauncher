#!/bin/bash

# Установка кодировки UTF-8
export LANG=C.UTF-8

# Проверка наличия виртуального окружения
if [ ! -f "venv/bin/activate" ]; then
    echo "Виртуальное окружение не найдено. Убедитесь, что оно создано в папке 'venv'."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

# Активация виртуального окружения
echo "Активация виртуального окружения..."
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "Не удалось активировать виртуальное окружение. Убедитесь, что путь к 'venv/bin/activate' правильный."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi
echo "Виртуальное окружение активировано."

# Создание исполняемого файла
echo "Создание исполняемого файла..."
pyinstaller --onefile --windowed --name DaisyLauncher launcher.py
if [ $? -ne 0 ]; then
    echo "Сборка завершилась неудачей."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi
echo "Сборка завершена."

# Очистка временных файлов
echo "Очистка временных файлов..."
rm -rf build
rm -f main.spec

# Деактивация виртуального окружения
echo "Деактивация виртуального окружения..."
deactivate
if [ $? -ne 0 ]; then
    echo "Не удалось деактивировать виртуальное окружение."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi
echo "Виртуальное окружение деактивировано."

echo "Сборка завершена. Исполняемый файл находится в папке dist."

read -p "Нажмите Enter для выхода..."
