FROM docker:20.10.7-dind

# 安装必要的软件
RUN apk update && apk add \
    openjdk8 \
    git \
    vim \
    curl \
    bash \
    tzdata \
    ca-certificates

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 持久化 Docker 数据
VOLUME /var/lib/docker

# 启动 Docker 服务
CMD ["dockerd-entrypoint.sh"]