# 自习室预约系统 - AI 助手增强版

**自习室预约系统** 是一款面向校园自习室资源管理的软件平台。  
其中，AI 助手模块由我独立开发，旨在通过人工智能提供更加高效的学习辅助功能，包括座位推荐、学习总结生成和智能对话，使学生能够更高效地管理时间、资源，并提高学习效率。

---

## 🌟 核心功能

### 自习室功能
1. **自习室与座位管理：**
   - 实时显示所有自习室的座位使用状态。
   - 用户可以方便地浏览空闲座位并查看预约日程。

2. **座位预约与取消：**
   - 支持学生通过系统轻松进行座位预约。
   - 支持修改或取消已有预约记录，后台自动避免预定冲突。

3. **日程管理：**
   - 支持按天、周或月的视图形式展示教室安排。
   - 过期预约可自动释放，未来预约支持延期功能。

### AI 助手功能（个人独立开发）
1. **智能对话助手：**
   - 提供基于 [阿里百炼 DashScope](https://dashscope.console.aliyun.com/) API 的智能自然语言交流功能，支持用户获取学习帮助、座位推荐等服务。

2. **个性化学习建议：**
   - 结合用户的学习时间与偏好，给出个性化的座位分配与建议。

3. **学习总结生成：**
   - 根据聊天记录智能生成总结文本，便于用户复习与巩固知识点。

4. **历史会话管理：**
   - 支持保存、查看与管理学习会话记录，提供数据回溯功能。
   - 可方便地查找或删除历史记录，增强用户体验。

---

## 💡 技术栈

| **组件**    | **技术选型**                      |
|-------------|-----------------------------------|
| **前端**    | **Vue**（73.5%），CSS（0.1%）      |
| **前端框架**| Element UI，JavaScript（5.9%）     |
| **后端**    | **Spring Boot / Java (20.3%)**    |
| **数据库**  | **MySQL**，支持座位状态与会话存储  |
| **AI 服务** | **阿里百炼 DashScope API**         |

---

## ⚙️ 如何在本地运行

### 1. 克隆项目
```bash
# 使用SSH或HTTPS方式克隆
git clone https://github.com/AriaJK/Study_Room.git
cd Study_Room
```

### 2. 初始化数据库
1. 确保本地安装了 **MySQL**。
2. 使用以下语句创建数据库：
   ```sql
   CREATE DATABASE study_room CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
   ```
3. 导入项目中的数据库表结构：
   ```sql
   SOURCE db/ai_chat_tables.sql;
   ```

### 3. 配置后端服务
在 `src/main/resources` 文件夹下，创建 `application.yml`，并填写如下配置：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/study_room?useSSL=false&characterEncoding=UTF-8
    username: <你的数据库用户名>
    password: <你的数据库密码>

llm:
  api-key: <阿里百炼的API_KEY>    # 从阿里云 DashScope 获取的密钥
  endpoint: https://dashscope.aliyuncs.com
```

---

### 4. 启动后端服务
在项目根目录下，运行以下命令：
```bash
mvn spring-boot:run
```

服务将运行在默认端口 `http://localhost:8080`。

---

### 5. 启动前端服务
进入前端文件夹并启动：
```bash
cd src/main/resources/front/front
npm install
npm run serve
```

前端服务将运行在默认端口 `http://localhost:8081`。

---

## 📂 项目结构

```text
Study_Room/
├── db/                     # 数据库脚本与表结构文件
├── src/
│   ├── main/
│   │   ├── java/           # 后端代码（Spring Boot 实现核心功能）
│   │   ├── resources/
│   │   │   ├── front/      # 前端代码目录（Vue 2 + Element UI）
│   │   │   └── ...         # 其他资源文件、配置与模板
├── Dockerfile              # Docker 配置文件
├── mvnw                    # Maven Wrapper 可执行文件
├── pom.xml                 # Maven 配置文件
└── README.md               # 项目说明文档
```

---

## 📢 特别声明

本项目公开源码，欢迎用于学习和个人开发。如计划用于商用或进一步传播，请注明出处即可。


## 💌 反馈 & 建议
如有任何建议或问题，欢迎通过 GitHub 提交 Issue。  
更多功能和模块的开发计划正在进行中，期待您的关注！

## 🎉 参与贡献
欢迎提交 Pull Request，或提出任何问题和改进建议。  
请先参考本仓库的开发规范，我们期待你的加入。
