#!/bin/bash

# Проверка наличия Python
echo "Проверка наличия Python..."
python --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Python не найден. Пожалуйста, загрузите его с сайта https://www.python.org/downloads/ и установите для работы DaisyLauncher."
    exit 1
fi

# Получаем текущую версию Python
python_version=$(python --version 2>&1)
python_major=$(echo "$python_version" | cut -d' ' -f2 | cut -d'.' -f1)
python_minor=$(echo "$python_version" | cut -d' ' -f2 | cut -d'.' -f2)
python_micro=$(echo "$python_version" | cut -d' ' -f2 | cut -d'.' -f3)

# Проверяем, что установленная версия Python не меньше 3.10
if [ $python_major -lt 3 ] || { [ $python_major -eq 3 ] && [ $python_minor -lt 5 ]; }; then
    echo "Требуется Python версии 3.5 или выше для работы DaisyLauncher."
    exit 1
fi

echo "Установлен: $python_version"

# Создание виртуального окружения
echo "Создание виртуального окружения..."
python -m venv venv
if [ $? -ne 0 ]; then
    echo "Не удалось создать виртуальное окружение."
    exit 1
fi
echo "Виртуальное окружение создано."

# Активация виртуального окружения
echo "Активация виртуального окружения..."
if [ -f venv/bin/activate ]; then
    source venv/bin/activate
else
    echo "Не найден файл активации виртуального окружения."
    exit 1
fi
if [ $? -ne 0 ]; then
    echo "Не удалось активировать виртуальное окружение."
    exit 1
fi
echo "Виртуальное окружение активировано."

# Обновление pip в виртуальном окружении
echo "Обновление pip..."
python -m pip install --upgrade pip
if [ $? -ne 0 ]; then
    echo "Не удалось обновить pip."
    exit 1
fi
echo "pip обновлен."

# Установка pip-tools
echo "Установка pip-tools..."
pip install pip-tools
if [ $? -ne 0 ]; then
    echo "Не удалось установить pip-tools."
    deactivate
    exit 1
fi
echo "pip-tools установлены."

# Проверка наличия файла requirements.in
if [ ! -f requirements.in ]; then
    echo "Файл requirements.in не найден. Создайте файл requirements.in с необходимыми зависимостями."
    deactivate
    exit 1
fi

# Генерация requirements.txt
echo "Генерация requirements.txt..."
pip-compile
if [ $? -ne 0 ]; then
    echo "Не удалось сгенерировать requirements.txt."
    deactivate
    exit 1
fi
echo "requirements.txt сгенерирован."

# Установка зависимостей из requirements.txt
echo "Установка зависимостей из requirements.txt..."
pip-sync
if [ $? -ne 0 ]; then
    echo "Не удалось установить зависимости."
    deactivate
    exit 1
fi
echo "Зависимости установлены."

# Деактивация виртуального окружения
echo "Деактивация виртуального окружения..."
deactivate
if [ $? -ne 0 ]; then
    echo "Не удалось деактивировать виртуальное окружение."
    exit 1
fi
echo "Виртуальное окружение деактивировано."

echo "Установка завершена."
