#!/bin/bash

# HEXAGON DRAGON 官网部署脚本
# 支持多种部署方式

echo "🚀 HEXAGON DRAGON 官网部署脚本"
echo "=================================="

# 检查必要文件是否存在
check_files() {
    echo "📁 检查必要文件..."
    required_files=("index.html" "styles.css" "script.js")
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "❌ 错误: 缺少必要文件 $file"
            exit 1
        fi
    done
    echo "✅ 所有必要文件检查完成"
}

# 本地预览
local_preview() {
    echo "🌐 启动本地预览服务器..."
    
    if command -v python3 &> /dev/null; then
        echo "使用 Python 3 启动服务器..."
        python3 -m http.server 8000
    elif command -v python &> /dev/null; then
        echo "使用 Python 启动服务器..."
        python -m http.server 8000
    elif command -v node &> /dev/null; then
        echo "使用 Node.js 启动服务器..."
        npx serve . -p 8000
    elif command -v php &> /dev/null; then
        echo "使用 PHP 启动服务器..."
        php -S localhost:8000
    else
        echo "❌ 错误: 未找到可用的Web服务器"
        echo "请安装 Python、Node.js 或 PHP"
        exit 1
    fi
}

# 创建压缩包
create_archive() {
    echo "📦 创建部署压缩包..."
    timestamp=$(date +"%Y%m%d_%H%M%S")
    archive_name="hexagon_dragon_website_${timestamp}.zip"
    
    if command -v zip &> /dev/null; then
        zip -r "$archive_name" index.html styles.css script.js README.md
        echo "✅ 压缩包创建完成: $archive_name"
    else
        echo "❌ 错误: 未找到 zip 命令"
        echo "请安装 zip 工具"
        exit 1
    fi
}

# 部署到GitHub Pages
deploy_github() {
    echo "🐙 部署到 GitHub Pages..."
    
    if [ ! -d ".git" ]; then
        echo "❌ 错误: 当前目录不是Git仓库"
        echo "请先初始化Git仓库: git init"
        exit 1
    fi
    
    echo "请按照以下步骤操作："
    echo "1. 创建GitHub仓库"
    echo "2. 添加远程源: git remote add origin <仓库URL>"
    echo "3. 提交代码: git add . && git commit -m 'Initial commit'"
    echo "4. 推送到GitHub: git push -u origin main"
    echo "5. 在仓库设置中启用GitHub Pages"
}

# 部署到Netlify
deploy_netlify() {
    echo "☁️ 部署到 Netlify..."
    
    if command -v netlify &> /dev/null; then
        echo "使用 Netlify CLI 部署..."
        netlify deploy --prod
    else
        echo "请按照以下步骤操作："
        echo "1. 访问 https://netlify.com"
        echo "2. 注册/登录账户"
        echo "3. 点击 'New site from Git'"
        echo "4. 连接GitHub仓库"
        echo "5. 选择部署分支和目录"
        echo "6. 点击 'Deploy site'"
    fi
}

# 部署到Vercel
deploy_vercel() {
    echo "⚡ 部署到 Vercel..."
    
    if command -v vercel &> /dev/null; then
        echo "使用 Vercel CLI 部署..."
        vercel --prod
    else
        echo "请按照以下步骤操作："
        echo "1. 访问 https://vercel.com"
        echo "2. 注册/登录账户"
        echo "3. 点击 'New Project'"
        echo "4. 导入GitHub仓库"
        echo "5. 配置项目设置"
        echo "6. 点击 'Deploy'"
    fi
}

# 显示部署选项
show_menu() {
    echo ""
    echo "请选择部署方式："
    echo "1) 本地预览"
    echo "2) 创建部署压缩包"
    echo "3) 部署到 GitHub Pages"
    echo "4) 部署到 Netlify"
    echo "5) 部署到 Vercel"
    echo "6) 显示所有部署方式"
    echo "0) 退出"
    echo ""
    read -p "请输入选项 (0-6): " choice
}

# 显示所有部署方式
show_all_deployments() {
    echo ""
    echo "📋 所有可用的部署方式："
    echo ""
    echo "🌐 本地预览:"
    echo "   - 双击 index.html 文件"
    echo "   - 使用本地Web服务器"
    echo ""
    echo "📦 传统部署:"
    echo "   - 上传文件到Web服务器"
    echo "   - 使用FTP/SFTP上传"
    echo ""
    echo "🐙 GitHub Pages:"
    echo "   - 免费托管"
    echo "   - 自动部署"
    echo "   - 自定义域名支持"
    echo ""
    echo "☁️ Netlify:"
    echo "   - 免费托管"
    echo "   - 自动部署"
    echo "   - CDN加速"
    echo "   - 表单处理"
    echo ""
    echo "⚡ Vercel:"
    echo "   - 免费托管"
    echo "   - 极速部署"
    echo "   - 全球CDN"
    echo "   - 自动HTTPS"
    echo ""
    echo "🔧 其他选项:"
    echo "   - AWS S3 + CloudFront"
    echo "   - Google Cloud Storage"
    echo "   - Azure Blob Storage"
    echo "   - 阿里云OSS"
    echo "   - 腾讯云COS"
}

# 主程序
main() {
    check_files
    
    while true; do
        show_menu
        
        case $choice in
            1)
                local_preview
                break
                ;;
            2)
                create_archive
                break
                ;;
            3)
                deploy_github
                break
                ;;
            4)
                deploy_netlify
                break
                ;;
            5)
                deploy_vercel
                break
                ;;
            6)
                show_all_deployments
                ;;
            0)
                echo "👋 再见！"
                exit 0
                ;;
            *)
                echo "❌ 无效选项，请重新选择"
                ;;
        esac
        
        if [ $choice -ge 1 ] && [ $choice -le 5 ]; then
            echo ""
            read -p "按回车键继续..."
        fi
    done
}

# 检查是否直接运行脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
