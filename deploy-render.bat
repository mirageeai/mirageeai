@echo off
chcp 65001 >nul
title HEXAGON DRAGON 官网 Render 部署脚本

echo.
echo 🚀 HEXAGON DRAGON 官网 Render 部署脚本
echo ========================================
echo.

REM 检查必要文件
echo 📁 检查必要文件...
set required_files=index.html styles.css script.js favicon.svg render.yaml
set missing_files=

for %%f in (%required_files%) do (
    if not exist "%%f" (
        set missing_files=!missing_files! %%f
    )
)

if defined missing_files (
    echo ❌ 错误: 缺少必要文件!missing_files!
    pause
    exit /b 1
)

echo ✅ 所有必要文件检查完成
echo.

REM 检查Git状态
echo 🔍 检查Git状态...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: 未安装Git
    echo 请从 https://git-scm.com 下载安装Git
    pause
    exit /b 1
)

if not exist ".git" (
    echo ⚠️  警告: 当前目录不是Git仓库
    echo 请先初始化Git仓库:
    echo   git init
    echo   git add .
    echo   git commit -m "Initial commit"
    echo.
    set /p choice="是否现在初始化Git仓库? (y/n): "
    if /i "!choice!"=="y" (
        git init
        git add .
        git commit -m "Initial commit"
        echo ✅ Git仓库初始化完成
    ) else (
        echo ❌ 部署到Render需要Git仓库
        pause
        exit /b 1
    )
)

REM 检查是否有未提交的更改
git status --porcelain >nul 2>&1
if %errorlevel% equ 0 (
    echo ⚠️  发现未提交的更改
    git status --short
    echo.
    set /p choice="是否提交所有更改? (y/n): "
    if /i "!choice!"=="y" (
        git add .
        set /p commit_msg="请输入提交信息: "
        if "!commit_msg!"=="" set commit_msg=Update website
        git commit -m "!commit_msg!"
        echo ✅ 更改已提交
    ) else (
        echo ❌ 请先提交更改再部署
        pause
        exit /b 1
    )
)

REM 检查远程仓库
echo 🌐 检查远程仓库...
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  未配置远程仓库
    echo 请按照以下步骤操作：
    echo 1. 在GitHub上创建新仓库
    echo 2. 添加远程源: git remote add origin ^<仓库URL^>
    echo 3. 推送代码: git push -u origin main
    echo.
    set /p repo_url="请输入GitHub仓库URL: "
    if not "!repo_url!"=="" (
        git remote add origin "!repo_url!"
        echo ✅ 远程仓库已添加
    ) else (
        echo ❌ 请先配置远程仓库
        pause
        exit /b 1
    )
)

REM 推送代码
echo 📤 推送代码到GitHub...
for /f "tokens=*" %%i in ('git branch --show-current') do set current_branch=%%i
echo 当前分支: !current_branch!

if git push -u origin "!current_branch!" (
    echo ✅ 代码推送成功
) else (
    echo ❌ 代码推送失败
    echo 请检查网络连接和GitHub权限
    pause
    exit /b 1
)

echo.
echo 🎉 代码已成功推送到GitHub！
echo.
echo 接下来请按照以下步骤在Render上部署：
echo.
echo 步骤1: 访问Render
echo   🌐 打开 https://render.com
echo   👤 使用GitHub账户登录
echo.
echo 步骤2: 创建新服务
echo   ➕ 点击 "New +"
echo   🌐 选择 "Static Site"
echo   🔗 点击 "Connect account" 连接GitHub
echo.
echo 步骤3: 配置部署
echo   📝 Name: hexagon-dragon-website
echo   🌿 Branch: !current_branch!
echo   📁 Root Directory: 留空
echo   🔨 Build Command: 留空
echo   📂 Publish Directory: .
echo.
echo 步骤4: 部署
echo   🚀 点击 "Create Static Site"
echo   ⏳ 等待部署完成（1-3分钟）
echo   ✅ 获得 .onrender.com 域名
echo.
echo 💡 提示: Render会自动读取render.yaml配置文件
echo.

echo 🔗 快速部署链接
echo 如果您想使用一键部署，可以访问：
echo https://render.com/deploy
echo.
echo 选择您的GitHub仓库，Render会自动配置部署设置。
echo.

echo 🎯 部署准备完成！
echo 现在您可以在Render上创建静态网站服务了。
echo.
echo 如有问题，请参考 RENDER_DEPLOYMENT.md 文件。
echo.
pause
