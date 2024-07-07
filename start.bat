@echo off
chcp 65001 > nul


REM Активация виртуального окружения
echo Активация виртуального окружения...
call venv\Scripts\activate
if %errorlevel% neq 0 (
    echo Не удалось активировать виртуальное окружение. Убедитесь, что путь к 'venv\Scripts\activate' правильный.
    pause
    exit /b 1
)
echo Виртуальное окружение активировано.

REM Запуск лаунчера DaisyLauncher
echo Запуск лаунчера DaisyLauncher...
call python launcher.py
if %errorlevel% neq 0 (
    echo Не удалось запустить лаунчер. Проверьте логи для получения дополнительной информации.
    pause
    exit /b 1
)
echo Лаунчер закрыт!

pause