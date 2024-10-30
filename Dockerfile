# 使用官方的Python基础镜像
FROM python:3.9-slim-buster

# 设置工作目录
WORKDIR /app

# 复制当前目录的内容到容器内的/app目录下
COPY . .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 将你的应用程序入口点定义在这里
CMD ["python", "main.py"]