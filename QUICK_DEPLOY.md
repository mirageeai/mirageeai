# ⚡ Render 快速部署检查清单

## 🚀 5分钟快速部署到Render

### 📋 前置条件检查
- [ ] 已安装Git
- [ ] 有GitHub账户
- [ ] 所有网站文件已准备就绪
- [ ] 英文版为主页面（index.html）
- [ ] 中文版为辅助页面（index-zh.html）

### 🔄 一键部署流程

#### 方法1：使用部署脚本（推荐）
```bash
# Mac/Linux
./deploy-render.sh

# Windows
deploy-render.bat
```

#### 方法2：手动部署
1. **初始化Git仓库**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **创建GitHub仓库**
   - 访问 https://github.com/new
   - 仓库名：`hexagon-dragon-website`
   - 设为公开仓库
   - 不要初始化README

3. **推送代码**
   ```bash
   git remote add origin https://github.com/你的用户名/hexagon-dragon-website.git
   git push -u origin main
   ```

4. **部署到Render**
   - 访问 https://render.com
   - 使用GitHub登录
   - 点击 "New +" → "Static Site"
   - 选择您的GitHub仓库
   - 点击 "Create Static Site"

### ⚙️ 关键配置设置

#### Render配置
- **Name**: `hexagon-dragon-website`
- **Branch**: `main`
- **Root Directory**: 留空
- **Build Command**: 留空
- **Publish Directory**: `.`

#### 自动配置
Render会自动读取 `render.yaml` 文件，无需手动配置！

### 🎯 部署成功标志

✅ 获得 `.onrender.com` 域名  
✅ 网站可以正常访问  
✅ 所有功能正常工作  
✅ SSL证书自动配置  
✅ 全球CDN加速  

### 🚨 常见问题

#### 部署失败
- 检查GitHub仓库是否为公开
- 确认所有文件已提交
- 查看Render构建日志

#### 样式丢失
- 确认CSS文件路径正确
- 检查浏览器控制台错误
- 清除浏览器缓存

#### 功能异常
- 检查JavaScript文件路径
- 查看浏览器控制台错误
- 确认所有依赖文件已提交

### 📱 部署后测试

- [ ] 桌面端访问正常
- [ ] 移动端适配良好
- [ ] 所有链接正常工作
- [ ] 联系表单可以提交
- [ ] 动画效果流畅

### 🔗 快速链接

- **Render官网**: https://render.com
- **快速部署**: https://render.com/deploy
- **官方文档**: https://render.com/docs
- **社区支持**: https://community.render.com

---

**提示**: 使用部署脚本可以自动化大部分流程，推荐优先使用！
