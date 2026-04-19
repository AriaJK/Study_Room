<template>
  <div>
    <!-- 右下角悬浮按钮（圆球） -->
    <div class="ai-fab" v-if="!visible" @click="open">
      AI
    </div>

    <!-- 浮窗主体 -->
    <transition name="ai-slide">
      <div class="ai-window" v-if="visible">
        <div class="ai-header">
          <div class="ai-title">AI 助理</div>
          <div class="ai-actions">
            <i class="el-icon-minus" title="最小化" @click="minimize"></i>
            <i class="el-icon-close" title="关闭" @click="close"></i>
          </div>
        </div>

        <div class="ai-layout">
          <!-- 左侧会话栏 -->
          <div class="ai-sidebar" :class="{ collapsed: sidebarCollapsed }">
            <div class="ai-sidebar-top">
              <div class="ai-sidebar-title" v-if="!sidebarCollapsed">Chats</div>
              <div class="ai-sidebar-actions">
                <i class="el-icon-plus" title="新建会话" @click="createSession"></i>
                <i
                    :class="sidebarCollapsed ? 'el-icon-arrow-right' : 'el-icon-arrow-left'"
                    :title="sidebarCollapsed ? '展开' : '收起'"
                    @click="sidebarCollapsed = !sidebarCollapsed"
                ></i>
              </div>
            </div>

            <div class="ai-sidebar-list" v-if="!sidebarCollapsed">
              <div
                  v-for="s in sessions"
                  :key="s.id"
                  class="ai-session-item"
                  :class="{ active: s.id === activeSessionId }"
                  @click="selectSession(s.id)"
              >
                <!-- 标题 -->
                <div class="ai-session-title">
                  {{ s.title || ('Chat #' + s.id) }}
                </div>

                <!-- 更多按钮 + 下拉菜单（只包含删除） -->
                <div class="ai-session-more" @click.stop>
                  <i
                      class="el-icon-more"
                      title="更多"
                      @click="toggleSessionMenu(s.id)"
                  ></i>

                  <div class="ai-session-menu" v-if="sessionMenuOpenId === s.id">
                    <div
                        class="ai-session-menu-item danger"
                        @mousedown.stop.prevent="deleteSessionConfirm(s)"
                    >
                      删除对话
                    </div>
                  </div>
                </div>
              </div>

              <div class="ai-session-empty" v-if="sessions.length === 0">
                暂无会话，点击 + 新建
              </div>
            </div>
          </div>

          <!-- 右侧聊天区 -->
          <div class="ai-main">
            <div class="ai-body" ref="scrollBody">
              <div v-for="(m, idx) in messages" :key="idx" class="ai-msg">
                <div class="ai-msg-role" :class="m.role">
                  {{ m.role === 'user' ? '我' : 'AI' }}
                </div>
                <div class="ai-msg-bubble" :class="m.role">
                  <div class="ai-msg-text" v-html="formatText(m.content)"></div>
                  <div class="ai-msg-time" v-if="m.time">{{ m.time }}</div>
                </div>
              </div>

              <div class="ai-tip" v-if="loading">AI 正在思考...</div>
            </div>

            <div class="ai-footer">
              <el-input
                  type="textarea"
                  :rows="3"
                  resize="none"
                  v-model="input"
                  placeholder="请将您遇到的问题告诉我，Shift + Enter 换行，Enter 发送"
                  @keydown.native="onKeyDown"
              />
              <div class="ai-footer-actions">
                <el-button size="mini" @click="quickPlan">学习计划</el-button>
                <el-button size="mini" @click="quickRecommend">推荐座位</el-button>
                <el-button size="mini" @click="quickSummary">学习总结</el-button>
                <el-button type="primary" size="mini" :loading="loading" @click="send">
                  发送
                </el-button>
              </div>
              <div class="ai-disclaimer">内容由 AI 生成，仅供参考，请自行判断。</div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: "AiAssistantWidget",
  data() {
    return {
      visible: false,
      sidebarCollapsed: false,

      sessions: [],
      activeSessionId: null,

      input: "",
      loading: false,

      // 当前展开的会话菜单（只影响 UI，不改业务）
      sessionMenuOpenId: null,

      messages: [
        {
          role: "assistant",
          content:
              "你好，我是学习助手。你可以问我学习计划、复盘总结，也可以让我帮你推荐预约策略。",
          time: this.nowStr()
        }
      ]
    };
  },

  // 点击空白处自动关闭菜单（不影响其它逻辑）
  mounted() {
    document.addEventListener("click", this.onGlobalClickCloseMenu, true);
  },
  beforeDestroy() {
    document.removeEventListener("click", this.onGlobalClickCloseMenu, true);
  },

  methods: {
    // ===== UI =====
    async open() {
      console.log("### AiAssistantWidget.vue LOADED ###", Date.now());
      this.visible = true;
      await this.ensureSessionsLoaded();
      this.$nextTick(this.scrollToBottom);
    },
    close() {
      this.visible = false;
      this.sessionMenuOpenId = null; // 关闭窗口同时收起菜单
    },
    minimize() {
      this.visible = false;
      this.sessionMenuOpenId = null; // 最小化同时收起菜单
    },

    onGlobalClickCloseMenu() {
      // 任何地方点击都关掉菜单（菜单内部点击已 stop）
      this.sessionMenuOpenId = null;
    },

    toggleSessionMenu(sessionId) {
      this.sessionMenuOpenId = (this.sessionMenuOpenId === sessionId) ? null : sessionId;
    },

    nowStr() {
      const d = new Date();
      const hh = String(d.getHours()).padStart(2, "0");
      const mm = String(d.getMinutes()).padStart(2, "0");
      return `${hh}:${mm}`;
    },

    formatText(t) {
      if (!t) return "";
      return String(t)
          .replace(/</g, "&lt;")
          .replace(/>/g, "&gt;")
          .replace(/\n/g, "<br/>");
    },

    onKeyDown(e) {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        this.send();
      }
    },

    pushUser(content) {
      this.messages.push({ role: "user", content, time: this.nowStr() });
      this.$nextTick(this.scrollToBottom);
    },
    pushAI(content) {
      this.messages.push({ role: "assistant", content, time: this.nowStr() });
      this.$nextTick(this.scrollToBottom);
    },
    scrollToBottom() {
      try {
        const el = this.$refs.scrollBody;
        if (el) el.scrollTop = el.scrollHeight;
      } catch (e) {}
    },

    // ===== HTTP helper =====
    postJson(url, payload) {
      const finalUrl = url && url.indexOf("/study_room") === 0 ? url : "/study_room" + url;
      return this.$http.post(finalUrl, payload, {
        emulateJSON: false,
        headers: {
          "Content-Type": "application/json;charset=UTF-8"
        }
      });
    },
    getJson(url, params) {
      const finalUrl = url && url.indexOf("/study_room") === 0 ? url : "/study_room" + url;
      return this.$http.get(finalUrl, {
        params: params || {},
        headers: {
          "Content-Type": "application/json;charset=UTF-8"
        }
      });
    },

    // delete helper（只用于删除会话）
    deleteJson(url) {
      const finalUrl = url && url.indexOf("/study_room") === 0 ? url : "/study_room" + url;
      return this.$http.delete(finalUrl, {
        headers: {
          "Content-Type": "application/json;charset=UTF-8"
        }
      });
    },

    // ===== Sessions =====
    async ensureSessionsLoaded() {
      try {
        const res = await this.getJson("/api/ai/sessions");
        const resp = res && res.data ? res.data : null;
        const list = (resp && resp.data && resp.data.sessions) ? resp.data.sessions : [];
        this.sessions = Array.isArray(list) ? list : [];

        if (!this.sessions.length) {
          await this.createSession();
          return;
        }

        if (!this.activeSessionId) {
          this.activeSessionId = this.sessions[0].id;
        }

        await this.loadMessages(this.activeSessionId);
      } catch (e) {
        this.pushAI("会话列表加载失败（可能未登录或接口未配置），你仍可继续临时对话。");
      }
    },

    async createSession() {
      try {
        const res = await this.postJson("/api/ai/sessions", { title: "New Chat" });
        const resp = res && res.data ? res.data : null;
        const s = resp && resp.data ? resp.data.session : null;
        if (s && s.id) {
          await this.ensureSessionsLoaded();
          this.activeSessionId = s.id;
          await this.loadMessages(s.id);
        }
      } catch (e) {
        this.pushAI("新建会话失败，请稍后再试。");
      }
    },

    async selectSession(id) {
      if (!id) return;
      this.activeSessionId = id;
      await this.loadMessages(id);
    },

    async loadMessages(sessionId) {
      if (!sessionId) return;

      try {
        const res = await this.getJson(`/api/ai/sessions/${sessionId}/messages`, { limit: 80 });
        const resp = res && res.data ? res.data : null;
        const list = (resp && resp.data && resp.data.messages) ? resp.data.messages : [];

        const arr = [];
        for (const m of (Array.isArray(list) ? list : [])) {
          arr.push({
            role: (m.role === "user" ? "user" : "assistant"),
            content: m.content,
            time: this.nowStr()
          });
        }

        if (!arr.length) {
          arr.push({
            role: "assistant",
            content:
                "你好，我是学习助手。你可以问我学习计划、复盘总结，也可以让我帮你推荐预约策略。",
            time: this.nowStr()
          });
        }

        this.messages = arr;
        this.$nextTick(this.scrollToBottom);
      } catch (e) {
        this.pushAI("历史消息加载失败。");
      }
    },

    // ✅ 删除对话：Element-UI MessageBox + 中文 + 美化（不改其它逻辑）
    deleteSessionConfirm(session) {
      console.log("### deleteSessionConfirm fired ###", session);
      this.sessionMenuOpenId = null;

      this.$confirm(
          "确定要删除该对话吗？删除后无法恢复。",
          "删除对话",
          {
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            type: "warning",
            showClose: true,
            closeOnClickModal: false,
            closeOnPressEscape: true,

            customClass: "ai-delete-confirm",
            confirmButtonClass: "ai-btn-delete",
            cancelButtonClass: "ai-btn-cancel"
          }
      )
          .then(() => {
            this.deleteSession(session.id);
          })
          .catch(() => {
            // 取消/关闭：不处理
          });
    },

    async deleteSession(sessionId) {
      console.log("### deleteSession start ###", sessionId);
      try {
        const res = await this.$http.delete(`/study_room/api/ai/sessions/${sessionId}`);
        console.log("### deleteSession response ###", res);

        const resp = res && res.data ? res.data : null;
        if (!resp || resp.code !== 0) {
          this.$message.error("删除失败：" + ((resp && resp.msg) || "未知错误"));
          return;
        }

        this.$message.success("删除成功");
        await this.ensureSessionsLoaded();
      } catch (e) {
        console.log("### deleteSession exception ###", e);
        this.$message.error("删除接口调用异常，请查看 Console/Network");
      }
    },

    // ===== Main chat =====
    async send() {
      const text = (this.input || "").trim();
      if (!text) return;

      if (!this.activeSessionId) {
        await this.ensureSessionsLoaded();
      }

      this.pushUser(text);
      this.input = "";
      this.loading = true;

      try {
        const res = await this.postJson("/api/ai/chat", {
          sessionId: this.activeSessionId,
          message: text
        });
        const resp = res && res.data ? res.data : null;

        const reply =
            (resp && resp.data && resp.data.reply) ||
            (resp && resp.data && resp.data.recommendation) ||
            "";

        const sid = resp && resp.data ? resp.data.sessionId : null;
        if (sid) this.activeSessionId = sid;

        if (reply) this.pushAI(reply);
        else this.pushAI("我没有拿到有效回复，你可以再试一次。");

        await this.ensureSessionsLoaded();
      } catch (e) {
        this.pushAI("AI 服务暂时不可用，请稍后再试。");
      } finally {
        this.loading = false;
      }
    },

    // ===== Quick buttons =====
    quickPlan() {
      this.open();
      this.input =
          "帮我制定一个 2 小时学习计划（含番茄钟安排），并给我一个可执行的任务拆分模板。";
      this.$nextTick(() => {});
    },

    async quickRecommend() {
      await this.open();
      this.loading = true;
      this.pushUser("帮我推荐一个空位多的自习室/座位（如果暂时拿不到实时空位，就给我选座策略）。");

      try {
        const res = await this.postJson("/api/ai/recommend", {
          sessionId: this.activeSessionId
        });
        const resp = res && res.data ? res.data : null;
        const txt = resp && resp.data ? resp.data.recommendation : "";
        if (txt) this.pushAI(txt);
        else this.pushAI("暂时无法给出推荐。");

        await this.ensureSessionsLoaded();
      } catch (e) {
        this.pushAI("推荐接口调用失败，请稍后再试。");
      } finally {
        this.loading = false;
      }
    },

    async quickSummary() {
      await this.open();
      this.$prompt("请输入本次学习时长（分钟）", "学习总结", {
        confirmButtonText: "生成总结",
        cancelButtonText: "取消",
        inputPattern: /^[0-9]+(\.[0-9]+)?$/,
        inputErrorMessage: "请输入数字（可带小数）"
      })
          .then(async ({ value }) => {
            this.loading = true;
            this.pushUser(`请帮我生成学习总结。本次学习时长：${value} 分钟。`);

            try {
              const res = await this.postJson("/api/ai/summary", {
                sessionId: this.activeSessionId,
                durationMinutes: Number(value)
              });
              const resp = res && res.data ? res.data : null;
              const txt = resp && resp.data ? resp.data.summaryText : "";
              if (txt) this.pushAI(txt);
              else this.pushAI("暂时无法生成总结。");

              await this.ensureSessionsLoaded();
            } catch (e) {
              this.pushAI("总结接口调用失败，请稍后再试。");
            } finally {
              this.loading = false;
            }
          })
          .catch(() => {});
    }
  }
};
</script>

<style scoped>
.ai-fab {
  position: fixed;
  right: 18px;
  bottom: 18px;
  width: 58px;
  height: 58px;
  border-radius: 29px;
  background: #4169e1;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  z-index: 9999;
  font-weight: 800;
  letter-spacing: 0.5px;
  box-shadow: 0 10px 24px rgba(65, 105, 225, 0.35);
  user-select: none;
}

.ai-window {
  position: fixed;
  right: 18px;
  bottom: 18px;
  width: 820px; /* 留出侧边栏 */
  height: 720px;
  background: #fff;
  border-radius: 12px;
  z-index: 10000;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.18);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.ai-header {
  height: 56px;
  background: #f7f8fa;
  border-bottom: 1px solid #ebeef5;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
}

.ai-title {
  font-weight: 700;
  color: #111;
  font-size: 17px;
}

.ai-actions i {
  font-size: 19px;
  color: #666;
  margin-left: 12px;
  cursor: pointer;
}

.ai-layout {
  flex: 1;
  display: flex;
  min-height: 0;
}

/* sidebar */
.ai-sidebar {
  width: 260px;
  background: #fbfbfc;
  border-right: 1px solid #ebeef5;
  display: flex;
  flex-direction: column;
}
.ai-sidebar.collapsed {
  width: 54px;
}
.ai-sidebar-top {
  height: 54px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 10px;
  border-bottom: 1px solid #ebeef5;
}
.ai-sidebar-title {
  font-weight: 700;
  color: #111;
}
.ai-sidebar-actions i {
  cursor: pointer;
  margin-left: 10px;
  color: #666;
  font-size: 16px;
}
.ai-sidebar-list {
  overflow-y: auto;
  padding: 10px;
}

.ai-session-item {
  padding: 10px 10px;
  border-radius: 10px;
  cursor: pointer;
  color: #333;
  margin-bottom: 8px;
  background: #fff;
  border: 1px solid #f0f0f0;

  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.ai-session-item.active {
  border-color: #4169e1;
  background: #ecf3ff;
}

.ai-session-title {
  font-size: 14px;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;

  flex: 1;
  min-width: 0;
}

.ai-session-more {
  position: relative;
  width: 18px;
  height: 18px;
  flex: 0 0 18px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.ai-session-more .el-icon-more {
  font-size: 16px;
  color: #666;
  cursor: pointer;
}

.ai-session-menu {
  position: absolute;
  top: 22px;
  right: 0;
  z-index: 99999;
  width: 120px;
  background: #fff;
  border: 1px solid #ebeef5;
  border-radius: 10px;
  box-shadow: 0 10px 22px rgba(0, 0, 0, 0.12);
  overflow: hidden;
}

.ai-session-menu-item {
  padding: 10px 12px;
  font-size: 13px;
  cursor: pointer;
  user-select: none;
}

.ai-session-menu-item:hover {
  background: #f6f6f6;
}

.ai-session-menu-item.danger {
  color: #f56c6c;
}

.ai-session-empty {
  padding: 10px;
  color: #999;
  font-size: 13px;
}

/* main */
.ai-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.ai-body {
  flex: 1;
  padding: 16px;
  overflow-y: auto;
  background: #ffffff;
}

.ai-msg {
  display: flex;
  margin-bottom: 12px;
}

.ai-msg-role {
  width: 34px;
  font-size: 14px;
  color: #999;
  margin-top: 6px;
}
.ai-msg-role.user {
  color: #4169e1;
}
.ai-msg-role.assistant {
  color: #333;
}

.ai-msg-bubble {
  max-width: 540px;
  padding: 12px 14px;
  border-radius: 12px;
  line-height: 1.6;
  font-size: 16px;
  position: relative;
  word-break: break-word;
}

.ai-msg-bubble.user {
  background: #ecf3ff;
  color: #0b3a8a;
}

.ai-msg-bubble.assistant {
  background: #f6f6f6;
  color: #222;
}

.ai-msg-time {
  margin-top: 6px;
  font-size: 12px;
  color: #999;
}

.ai-tip {
  font-size: 13px;
  color: #999;
  padding: 6px 0;
}

.ai-footer {
  border-top: 1px solid #ebeef5;
  padding: 14px;
  background: #fff;
}

.ai-footer-actions {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.ai-footer-actions .el-button {
  font-size: 13px;
}

.ai-disclaimer {
  margin-top: 8px;
  font-size: 12px;
  color: #aaa;
}

.ai-footer ::v-deep .el-textarea__inner {
  font-size: 15px;
  line-height: 1.55;
  padding: 10px 12px;
}

/* 动画 */
.ai-slide-enter-active,
.ai-slide-leave-active {
  transition: all 0.2s ease;
}
.ai-slide-enter,
.ai-slide-leave-to {
  transform: translateY(10px);
  opacity: 0;
}

/* ✅ 方案 A：直接把 MessageBox 的 z-index 提高（更激进，确保盖住 AI 窗口） */
::v-deep .el-message-box__wrapper {
  z-index: 999999 !important;
}
::v-deep .v-modal {
  z-index: 999998 !important;
}

/* ✅ 删除确认弹窗美化（Element-UI MessageBox） */
::v-deep .ai-delete-confirm {
  border-radius: 14px;
  overflow: hidden;
  width: 420px;
}

::v-deep .ai-delete-confirm .el-message-box__header {
  padding: 18px 18px 10px 18px;
}

::v-deep .ai-delete-confirm .el-message-box__title {
  font-size: 18px;
  font-weight: 700;
  color: #111;
}

::v-deep .ai-delete-confirm .el-message-box__content {
  padding: 8px 18px 0 18px;
}

::v-deep .ai-delete-confirm .el-message-box__message p {
  font-size: 14px;
  line-height: 1.7;
  color: #444;
}

::v-deep .ai-delete-confirm .el-message-box__btns {
  padding: 16px 18px 18px 18px;
}

/* 取消按钮（灰） */
::v-deep .ai-delete-confirm .ai-btn-cancel {
  border-radius: 10px;
  padding: 9px 18px;
}

/* 删除按钮（红） */
::v-deep .ai-delete-confirm .ai-btn-delete {
  border-radius: 10px;
  padding: 9px 18px;
  background: #f56c6c;
  border-color: #f56c6c;
  color: #fff;
}

::v-deep .ai-delete-confirm .ai-btn-delete:hover,
::v-deep .ai-delete-confirm .ai-btn-delete:focus {
  background: #f78989;
  border-color: #f78989;
  color: #fff;
}
</style>