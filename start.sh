#!/bin/bash

# HEXAGON DRAGON 官网快速启动脚本

echo "🚀 启动 HEXAGON DRAGON 官网本地预览..."
echo "=========================================="

# 检查文件是否存在
if [ ! -f "index.html" ]; then
    echo "❌ 错误: 找不到 index.html 文件"
    exit 1
fi

# 尝试启动本地服务器
echo "🌐 正在启动本地Web服务器..."

# 尝试使用Python 3
if command -v python3 &> /dev/null; then
    echo "✅ 使用 Python 3 启动服务器..."
    echo "📱 网站将在浏览器中打开..."
    echo "🌍 访问地址: http://localhost:8000"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo ""
    
    # 延迟2秒后打开浏览器
    sleep 2
    open http://localhost:8000
    
    # 启动Python服务器
    python3 -m http.server 8000

# 尝试使用Python 2
elif command -v python &> /dev/null; then
    echo "✅ 使用 Python 启动服务器..."
    echo "📱 网站将在浏览器中打开..."
    echo "🌍 访问地址: http://localhost:8000"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo ""
    
    # 延迟2秒后打开浏览器
    sleep 2
    open http://localhost:8000
    
    # 启动Python服务器
    python -m http.server 8000

# 尝试使用Node.js
elif command -v node &> /dev/null; then
    echo "✅ 使用 Node.js 启动服务器..."
    echo "📱 网站将在浏览器中打开..."
    echo "🌍 访问地址: http://localhost:8000"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo ""
    
    # 延迟2秒后打开浏览器
    sleep 2
    open http://localhost:8000
    
    # 启动Node.js服务器
    npx serve . -p 8000

# 尝试使用PHP
elif command -v php &> /dev/null; then
    echo "✅ 使用 PHP 启动服务器..."
    echo "📱 网站将在浏览器中打开..."
    echo "🌍 访问地址: http://localhost:8000"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo ""
    
    # 延迟2秒后打开浏览器
    sleep 2
    open http://localhost:8000
    
    # 启动PHP服务器
    php -S localhost:8000

else
    echo "❌ 错误: 未找到可用的Web服务器"
    echo ""
    echo "💡 解决方案:"
    echo "1. 安装 Python 3: brew install python3"
    echo "2. 安装 Node.js: brew install node"
    echo "3. 安装 PHP: brew install php"
    echo ""
    echo "或者直接双击 index.html 文件在浏览器中打开"
    exit 1
fi
