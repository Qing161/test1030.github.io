FROM docker.io/docker:dind

#使用 ali 仓库地址
RUN echo -e "http://mirrors.aliyun.com/alpine/latest-stable/main\n\
http://mirrors.aliyun.com/alpine/latest-stable/community" > /etc/apk/repositories

#增加不安全链接地址，本地注册中心地址。
RUN mkdir -p /etc/docker && echo -e '{"insecure-registries": ["hub.local.ip:port"]}' > /etc/docker/daemon.json

RUN apk update && apk add tzdata vim openjdk8 libstdc++ curl ca-certificates bash && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /root/.cache

#设置环境变量
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH $PATH:$JAVA_HOME/jre/bin:$JAVA_HOME/bin
#安装字体 Jenkins 需要，git，ssh，修改root主目录
RUN apk update && apk add ttf-dejavu git openssh && \
    sed -i -e 's/root:\/root/root:\/var\/jenkins_home/g' /etc/passwd

#设置jenkins 主目录
ENV JENKINS_HOME /var/jenkins_home
#设置maven目录
ENV MAVEN_HOME /var/jenkins_home/tools/maven3
ENV PATH $PATH:$MAVEN_HOME/bin
WORKDIR /var/jenkins_home

#添加启动脚本和 war 文件从Jenkins 下载。
ADD jenkins_run.sh /jenkins_run.sh
ADD jenkins.war /usr/share/jenkins/jenkins.war

EXPOSE 8080

ENTRYPOINT ["/jenkins_run.sh"]