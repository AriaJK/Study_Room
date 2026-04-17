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
    </transition>
  </div>
</template>

<script>
export default {
  name: "AiAssistantWidget",
  data() {
    return {
      visible: false,
      input: "",
      loading: false,
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
  methods: {
    // ===== UI =====
    open() {
      this.visible = true;
      this.$nextTick(this.scrollToBottom);
    },
    close() {
      this.visible = false;
    },
    minimize() {
      this.visible = false;
    },

    nowStr() {
      const d = new Date();
      const hh = String(d.getHours()).padStart(2, "0");
      const mm = String(d.getMinutes()).padStart(2, "0");
      return `${hh}:${mm}`;
    },

    formatText(t) {
      if (!t) return "";
      // 基础转义 + 换行（MVP）
      return String(t)
          .replace(/</g, "&lt;")
          .replace(/>/g, "&gt;")
          .replace(/\n/g, "<br/>");
    },

    onKeyDown(e) {
      // Shift+Enter 换行；Enter 发送
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
      // 后端有 context-path=/study_room；若已带前缀则不重复拼
      const finalUrl =
          url && url.indexOf("/study_room") === 0 ? url : "/study_room" + url;

      return this.$http.post(finalUrl, payload, {
        emulateJSON: false,
        headers: {
          "Content-Type": "application/json;charset=UTF-8"
        }
      });
    },

    // ===== Main chat =====
    async send() {
      const text = (this.input || "").trim();
      if (!text) return;

      this.pushUser(text);
      this.input = "";
      this.loading = true;

      try {
        const res = await this.postJson("/api/ai/chat", { message: text });
        const resp = res && res.data ? res.data : null;

        // 后端格式：{code,msg,data:{reply}}
        const reply = resp && resp.data ? resp.data.reply : "";
        if (reply) this.pushAI(reply);
        else this.pushAI("我没有拿到有效回复，你可以再试一次。");
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
      this.open();
      this.loading = true;
      this.pushUser(
          "帮我推荐一个空位多的自习室/座位（如果暂时拿不到实时空位，就给我选座策略）。"
      );

      try {
        const res = await this.postJson("/api/ai/recommend", {});
        const resp = res && res.data ? res.data : null;
        const txt = resp && resp.data ? resp.data.recommendation : "";
        this.pushAI(txt || "暂时无法给出推荐。");
      } catch (e) {
        this.pushAI("推荐接口调用失败，请稍后再试。");
      } finally {
        this.loading = false;
      }
    },

    async quickSummary() {
      this.open();
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
                durationMinutes: Number(value)
              });
              const resp = res && res.data ? res.data : null;
              const txt = resp && resp.data ? resp.data.summaryText : "";
              this.pushAI(txt || "暂时无法生成总结。");
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
/* 右下角浮动圆球 */
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

/* 浮窗（再放大一档） */
.ai-window {
  position: fixed;
  right: 18px;
  bottom: 18px;
  width: 520px;   /* 原 440 -> 更大 */
  height: 720px;  /* 原 640 -> 更大 */
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
  max-width: 410px; /* 配合窗口变大 */
  padding: 12px 14px;
  border-radius: 12px;
  line-height: 1.6;
  font-size: 16px; /* 原 15 -> 更护眼 */
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

/* Element-UI textarea 字体增大（Vue2 + scoped 需要 ::v-deep） */
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
</style>