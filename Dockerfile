# 基础镜像（Java项目用openjdk）
FROM openjdk:8-jre-slim
# 复制Maven构建好的jar包到镜像里
COPY target/study_room.jar /app.jar
# 启动命令
CMD ["java", "-jar", "/app.jar"]