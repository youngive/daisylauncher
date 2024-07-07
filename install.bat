@echo off
chcp 65001 > nul

REM Проверка наличия Python
echo Проверка наличия Python...
call python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python не найден. Пожалуйста, загрузите его с сайта https://www.python.org/downloads/ и установите для работы DaisyLauncher.
    pause
    exit /b 1
)

REM Получаем текущую версию Python
for /f "tokens=2-4 delims=. " %%v in ('python --version 2^>^&1') do (
    set "python_major=%%v"
    set "python_minor=%%w"
    set "python_micro=%%x"
)

REM Проверяем, что установленная версия Python не меньше 3.10
if %python_major% LSS 3 (
    echo Требуется Python версии 3.5 или выше для работы DaisyLauncher.
    pause
    exit /b 1
) else if %python_major% EQU 3 (
    if %python_minor% LSS 5 (
        echo Требуется Python версии 3.5 или выше для работы DaisyLauncher.
        pause
        exit /b 1
    )
)

echo Установлен:
call python --version

REM Создание виртуального окружения
echo Создание виртуального окружения...
call python -m venv venv
if %errorlevel% neq 0 (
    echo Не удалось создать виртуальное окружение.
    pause
    exit /b 1
)
echo Виртуальное окружение создано.

REM Активация виртуального окружения
echo Активация виртуального окружения...
if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
) else (
    echo Не найден файл активации виртуального окружения.
    pause
    exit /b 1
)
if %errorlevel% neq 0 (
    echo Не удалось активировать виртуальное окружение.
    pause
    exit /b 1
)
echo Виртуальное окружение активировано.

REM Обновление pip в виртуальном окружении
echo Обновление pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo Не удалось обновить pip.
    pause
    exit /b 1
)
echo pip обновлен.

REM Установка pip-tools
echo Установка pip-tools...
call pip install pip-tools
if %errorlevel% neq 0 (
    echo Не удалось установить pip-tools.
    call venv\Scripts\deactivate.bat
    pause
    exit /b 1
)
echo pip-tools установлены.

REM Проверка наличия файла requirements.in
if not exist requirements.in (
    echo Файл requirements.in не найден. Создайте файл requirements.in с необходимыми зависимостями.
    call venv\Scripts\deactivate.bat
    pause
    exit /b 1
)

REM Генерация requirements.txt
echo Генерация requirements.txt...
call pip-compile
if %errorlevel% neq 0 (
    echo Не удалось сгенерировать requirements.txt.
    call venv\Scripts\deactivate.bat
    pause
    exit /b 1
)
echo requirements.txt сгенерирован.

REM Установка зависимостей из requirements.txt
echo Установка зависимостей из requirements.txt...
call pip-sync
if %errorlevel% neq 0 (
    echo Не удалось установить зависимости.
    call venv\Scripts\deactivate.bat
    pause
    exit /b 1
)
echo Зависимости установлены.

REM Деактивация виртуального окружения
echo Деактивация виртуального окружения...
call venv\Scripts\deactivate.bat
if %errorlevel% neq 0 (
    echo Не удалось деактивировать виртуальное окружение.
    pause
    exit /b 1
)
echo Виртуальное окружение деактивировано.

echo Установка завершена.