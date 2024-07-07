@echo off
chcp 65001 > nul

REM Проверка наличия виртуального окружения
if not exist "venv\Scripts\activate" (
    echo Виртуальное окружение не найдено. Убедитесь, что оно создано в папке 'venv'.
    pause
    exit /b 1
)



REM Активация виртуального окружения
echo Активация виртуального окружения...
call venv\Scripts\activate
if %errorlevel% neq 0 (
    echo Не удалось активировать виртуальное окружение. Убедитесь, что путь к 'venv\Scripts\activate' правильный.
    pause
    exit /b 1
)
echo Виртуальное окружение активировано.

REM Создание исполняемого файла
echo Создание исполняемого файла...
pyinstaller --onefile --windowed --name DaisyLauncher launcher.py
if %errorlevel% neq 0 (
    echo Сборка завершилась неудачей.
    pause
    exit /b 1
)
echo Сборка завершена.

REM Очистка временных файлов
echo Очистка временных файлов...
rmdir /s /q build
del /q main.spec

REM Деактивация виртуального окружения
echo Деактивация виртуального окружения...
call venv\Scripts\deactivate.bat
if %errorlevel% neq 0 (
    echo Не удалось деактивировать виртуальное окружение.
    pause
    exit /b 1
)
echo Виртуальное окружение деактивировано.

echo Сборка завершена. Исполняемый файл находится в папке dist.

pause