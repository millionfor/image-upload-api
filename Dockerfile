# 多阶段构建 Dockerfile
FROM node:18-alpine AS builder

# 设置工作目录
WORKDIR /app

# 复制 package 文件
COPY package*.json ./
COPY yarn.lock ./

# 安装依赖
RUN yarn install --frozen-lockfile

# 复制源代码
COPY . .

# 构建应用
RUN yarn build

# 生产阶段
FROM node:18-alpine AS production

# 安装 Sharp 的依赖
RUN apk add --no-cache \
    vips-dev \
    build-base \
    python3

# 设置工作目录
WORKDIR /app

# 复制 package 文件
COPY package*.json ./
COPY yarn.lock ./

# 只安装生产依赖
RUN yarn install --production --frozen-lockfile

# 从构建阶段复制构建产物
COPY --from=builder /app/build ./build

# 创建输出目录
RUN mkdir -p output

# 设置环境变量
ENV NODE_ENV=production
ENV PORT=2500
ENV FILE_OUTPUT_DIR=output

# 暴露端口
EXPOSE 2500

# 启动应用
CMD ["yarn", "start"]
