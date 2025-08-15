@echo off
chcp 65001 >nul
title HEXAGON DRAGON 官网启动器

echo.
echo 🚀 启动 HEXAGON DRAGON 官网本地预览...
echo ==========================================
echo.

REM 检查文件是否存在
if not exist "index.html" (
    echo ❌ 错误: 找不到 index.html 文件
    pause
    exit /b 1
)

echo 🌐 正在启动本地Web服务器...
echo.

REM 尝试使用Python 3
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 使用 Python 启动服务器...
    echo 📱 网站将在浏览器中打开...
    echo 🌍 访问地址: http://localhost:8000
    echo ⏹️  按 Ctrl+C 停止服务器
    echo.
    
    REM 延迟2秒后打开浏览器
    timeout /t 2 /nobreak >nul
    start http://localhost:8000
    
    REM 启动Python服务器
    python -m http.server 8000
    goto :end
)

REM 尝试使用Node.js
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 使用 Node.js 启动服务器...
    echo 📱 网站将在浏览器中打开...
    echo 🌍 访问地址: http://localhost:8000
    echo ⏹️  按 Ctrl+C 停止服务器
    echo.
    
    REM 延迟2秒后打开浏览器
    timeout /t 2 /nobreak >nul
    start http://localhost:8000
    
    REM 启动Node.js服务器
    npx serve . -p 8000
    goto :end
)

REM 尝试使用PHP
php --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 使用 PHP 启动服务器...
    echo 📱 网站将在浏览器中打开...
    echo 🌍 访问地址: http://localhost:8000
    echo ⏹️  按 Ctrl+C 停止服务器
    echo.
    
    REM 延迟2秒后打开浏览器
    timeout /t 2 /nobreak >nul
    start http://localhost:8000
    
    REM 启动PHP服务器
    php -S localhost:8000
    goto :end
)

REM 如果没有找到可用的Web服务器
echo ❌ 错误: 未找到可用的Web服务器
echo.
echo 💡 解决方案:
echo 1. 安装 Python: 从 https://python.org 下载安装
echo 2. 安装 Node.js: 从 https://nodejs.org 下载安装
echo 3. 安装 PHP: 从 https://php.net 下载安装
echo.
echo 或者直接双击 index.html 文件在浏览器中打开
echo.
pause
exit /b 1

:end
echo.
echo 服务器已停止
pause
