#!/bin/bash

# 创建必要的目录
mkdir -p output
mkdir -p uploads

# 构建并启动服务
echo "🚀 启动图像处理API服务..."
docker-compose up --build -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 10

# 检查服务状态
echo "📊 服务状态:"
docker-compose ps

echo "✅ 服务已启动！"
echo "🌐 API地址: http://localhost:2500"
echo "📁 输出目录: ./output"
echo "📁 上传目录: ./uploads"
echo ""
echo "查看日志: docker-compose logs -f"
echo "停止服务: docker-compose down"
