#!/bin/bash

# HEXAGON DRAGON 官网 Render 部署脚本

echo "🚀 HEXAGON DRAGON 官网 Render 部署脚本"
echo "========================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查必要文件
check_files() {
    echo -e "${BLUE}📁 检查必要文件...${NC}"
    required_files=("index.html" "styles.css" "script.js" "favicon.svg" "render.yaml")
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo -e "${RED}❌ 错误: 缺少必要文件 $file${NC}"
            exit 1
        fi
    done
    echo -e "${GREEN}✅ 所有必要文件检查完成${NC}"
}

# 检查Git状态
check_git() {
    echo -e "${BLUE}🔍 检查Git状态...${NC}"
    
    if [ ! -d ".git" ]; then
        echo -e "${YELLOW}⚠️  警告: 当前目录不是Git仓库${NC}"
        echo "请先初始化Git仓库:"
        echo "  git init"
        echo "  git add ."
        echo "  git commit -m 'Initial commit'"
        echo ""
        read -p "是否现在初始化Git仓库? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            git init
            git add .
            git commit -m "Initial commit"
            echo -e "${GREEN}✅ Git仓库初始化完成${NC}"
        else
            echo -e "${RED}❌ 部署到Render需要Git仓库${NC}"
            exit 1
        fi
    fi
    
    # 检查是否有未提交的更改
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}⚠️  发现未提交的更改${NC}"
        git status --short
        echo ""
        read -p "是否提交所有更改? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            git add .
            read -p "请输入提交信息: " commit_msg
            git commit -m "${commit_msg:-Update website}"
            echo -e "${GREEN}✅ 更改已提交${NC}"
        else
            echo -e "${RED}❌ 请先提交更改再部署${NC}"
            exit 1
        fi
    fi
}

# 检查远程仓库
check_remote() {
    echo -e "${BLUE}🌐 检查远程仓库...${NC}"
    
    if ! git remote get-url origin >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  未配置远程仓库${NC}"
        echo "请按照以下步骤操作："
        echo "1. 在GitHub上创建新仓库"
        echo "2. 添加远程源: git remote add origin <仓库URL>"
        echo "3. 推送代码: git push -u origin main"
        echo ""
        read -p "请输入GitHub仓库URL: " repo_url
        if [ -n "$repo_url" ]; then
            git remote add origin "$repo_url"
            echo -e "${GREEN}✅ 远程仓库已添加${NC}"
        else
            echo -e "${RED}❌ 请先配置远程仓库${NC}"
            exit 1
        fi
    fi
}

# 推送代码
push_code() {
    echo -e "${BLUE}📤 推送代码到GitHub...${NC}"
    
    # 获取当前分支
    current_branch=$(git branch --show-current)
    
    echo "当前分支: $current_branch"
    
    # 推送到远程仓库
    if git push -u origin "$current_branch"; then
        echo -e "${GREEN}✅ 代码推送成功${NC}"
    else
        echo -e "${RED}❌ 代码推送失败${NC}"
        echo "请检查网络连接和GitHub权限"
        exit 1
    fi
}

# 显示部署说明
show_deployment_steps() {
    echo ""
    echo -e "${GREEN}🎉 代码已成功推送到GitHub！${NC}"
    echo ""
    echo "接下来请按照以下步骤在Render上部署："
    echo ""
    echo -e "${BLUE}步骤1: 访问Render${NC}"
    echo "  🌐 打开 https://render.com"
    echo "  👤 使用GitHub账户登录"
    echo ""
    echo -e "${BLUE}步骤2: 创建新服务${NC}"
    echo "  ➕ 点击 'New +'"
    echo "  🌐 选择 'Static Site'"
    echo "  🔗 点击 'Connect account' 连接GitHub"
    echo ""
    echo -e "${BLUE}步骤3: 配置部署${NC}"
    echo "  📝 Name: hexagon-dragon-website"
    echo "  🌿 Branch: $current_branch"
    echo "  📁 Root Directory: 留空"
    echo "  🔨 Build Command: 留空"
    echo "  📂 Publish Directory: ."
    echo ""
    echo -e "${BLUE}步骤4: 部署${NC}"
    echo "  🚀 点击 'Create Static Site'"
    echo "  ⏳ 等待部署完成（1-3分钟）"
    echo "  ✅ 获得 .onrender.com 域名"
    echo ""
    echo -e "${YELLOW}💡 提示: Render会自动读取render.yaml配置文件${NC}"
    echo ""
}

# 显示快速部署链接
show_quick_deploy() {
    echo -e "${BLUE}🔗 快速部署链接${NC}"
    echo "如果您想使用一键部署，可以访问："
    echo "https://render.com/deploy"
    echo ""
    echo "选择您的GitHub仓库，Render会自动配置部署设置。"
    echo ""
}

# 主程序
main() {
    check_files
    check_git
    check_remote
    push_code
    show_deployment_steps
    show_quick_deploy
    
    echo -e "${GREEN}🎯 部署准备完成！${NC}"
    echo "现在您可以在Render上创建静态网站服务了。"
    echo ""
    echo "如有问题，请参考 RENDER_DEPLOYMENT.md 文件。"
}

# 检查是否直接运行脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
