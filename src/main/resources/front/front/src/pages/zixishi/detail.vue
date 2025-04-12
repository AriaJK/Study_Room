<template>
  <div>
    <div
      :style="{
        width: '1000px',
        padding: '20px',
        margin: '10px auto',
        borderRadius: '27px',
        background: '#bfd2fc',
      }"
      class="breadcrumb-preview"
    >
      <el-breadcrumb
        :separator="'Ξ'"
        :style="{ fontSize: '14px', lineHeight: '1' }"
      >
        <el-breadcrumb-item>首页</el-breadcrumb-item>
        <el-breadcrumb-item
          v-for="(item, index) in breadcrumbItem"
          :key="index"
          >{{ item.name }}</el-breadcrumb-item
        >
      </el-breadcrumb>
    </div>

    <div
      class="detail-preview"
      :style="{
        minHeight: '1000px',
        width: '1000px',
        margin: '10px auto',
        position: 'relative',
        height: 'auto',
      }"
    >
      <div
        class="attr"
        :style="{
          minHeight: '580px',
          padding: '20px',
          position: 'relative',
          background: '#ebf0f4',
          display: 'flex',
        }"
      >
        <el-carousel
          :style="{ width: '400px', margin: '0 10px 0 0', height: '400px' }"
          trigger="click"
          indicator-position="inside"
          arrow="always"
          type="default"
          direction="horizontal"
          height="400px"
          autoplay="true"
          interval="3000"
          loop="true"
        >
          <el-carousel-item
            :style="{ borderRadius: '10px', width: '100%', height: '100%' }"
            v-for="item in detailBanner"
            :key="item.id"
          >
            <el-image
              :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
              v-if="item.substr(0, 4) == 'http'"
              :src="item"
              fit="cover"
              class="image"
            ></el-image>
            <el-image
              :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
              v-else
              :src="baseUrl + item"
              fit="cover"
              class="image"
            ></el-image>
          </el-carousel-item>
        </el-carousel>

        <div
          class="info"
          :style="{
            width: 'calc(100% - 400px)',
            padding: '10px',
            margin: '0 0 0 10px',
            background: '#e5e5e5',
          }"
        >
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              alignItems: 'center',
              background: '#ebf0f4',
              justifyContent: 'space-between',
              display: 'flex',
            }"
          >
            <div :style="{ color: '#333', fontSize: '16px' }">
              {{ detail.mingcheng }}
            </div>
            <div
              @click="storeup(1)"
              v-show="!isStoreup"
              :style="{ padding: '10px', background: '#fff' }"
            >
              <i
                v-if="true"
                :style="{ color: '#999', fontSize: '14px' }"
                class="el-icon-star-off"
              ></i
              ><span :style="{ color: '#999', fontSize: '14px' }"
                >点我收藏</span
              >
            </div>
            <div
              @click="storeup(-1)"
              v-show="isStoreup"
              :style="{ padding: '10px', background: '#fff' }"
            >
              <i
                v-if="true"
                :style="{ color: '#999', fontSize: '14px' }"
                class="el-icon-star-on"
              ></i
              ><span :style="{ color: '#999', fontSize: '14px' }"
                >取消收藏</span
              >
            </div>
          </div>

          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              规模
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.guimo }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              座位
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.sd_zuowei }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              位置
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.weizhi }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              设施
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.sheshi }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              可约时间
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.keyueshijian }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              background: '#ebf0f4',
              justifyContent: 'spaceBetween',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                color: '#000',
                textAlign: 'right',
                width: '112px',
                fontSize: '14px',
                lineHeight: '40px',
                height: '40px',
              }"
            >
              是否有课
            </div>
            <div
              :style="{
                width: '498px',
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '40px',
                color: '#666',
                height: '40px',
              }"
            >
              {{ detail.shifouyouke }}
            </div>
          </div>
          <div
            class="btn"
            :style="{
              padding: '10px 0',
              flexWrap: 'wrap',
              justifyContent: 'center',
              display: 'flex',
            }"
          >
            <el-button
              :style="{
                border: '0',
                cursor: 'pointer',
                padding: '0 10px',
                margin: '0 5px 0 0',
                outline: 'none',
                color: '#fff',
                borderRadius: '4px',
                background: '#2E61E1',
                width: 'auto',
                lineHeight: '40px',
                fontSize: '14px',
                height: '40px',
              }"
              v-if="isAuth('zixishi', '在线预约')"
              @click="onAcross('yuyuexinxi', '', '', '')"
              type="warning"
              >在线预约</el-button
            >
          </div>
        </div>
      </div>
      <!-- 座位选择模块 -->
      <div
        class="seat-map"
        :style="{
          padding: '30px',
          margin: '30px auto',
          maxWidth: '1000px',
          background: '#fff',
          borderRadius: '8px',
        }"
      >
        <div
          class="seat-title"
          :style="{
            fontSize: '16px',
            marginBottom: '15px',
            color: '#333',
            fontWeight: 'bold',
          }"
        >
          座位选择
        </div>

        <div
          v-if="seats"
          class="seat-grid"
          :style="{
            display: 'grid',
            gap: '12px',
            gridTemplateColumns: 'repeat(10, 40px)',
          }"
        >
          <div
            v-for="seat in seats"
            :key="seat.id"
            class="seat-item"
            :class="{
              selected: seat.selected,
              disabled: seat.status === 'occupied',
            }"
            @click="handleSeatClick(seat)"
            :style="{
              width: '40px',
              height: '40px',
              border: '2px solid #2E61E1',
              borderRadius: '6px',
              cursor: seat.status === 'occupied' ? 'not-allowed' : 'pointer',
              backgroundColor: getSeatColor(seat),
              color: seat.selected ? '#fff' : '#666',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              fontSize: '14px',
              transition: 'all 0.3s',
            }"
          >
            {{ seat.number }}
          </div>
        </div>

        <div
          class="selected-hint"
          v-if="seats"
          :style="{ marginTop: '15px', color: '#666', fontSize: '14px' }"
        >
          已选座位：<span style="color: #2e61e1">{{ selectedSeatsText }}</span>
        </div>

        <div v-else style="padding: 20px; color: #666">加载座位信息中...</div>
      </div>

      <el-tabs
        class="detail"
        :style="{
          border: '1px solid #DCDFE6',
          minHeight: '480px',
          boxShadow: '0 1px 6px 0 rgba(0, 0, 0, .1)',
          background: '#FFF',
          height: 'auto',
        }"
        v-model="activeName"
        type="border-card"
      >
        <el-tab-pane label="详情" name="first">
          <div v-html="detail.xiangqing"></div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>
    
    <script>
import CountDown from "@/components/CountDown";
export default {
  //数据集合
  data() {
    return {
      tablename: "zixishi",
      baseUrl: "",
      breadcrumbItem: [
        {
          name: "详情信息",
        },
      ],
      title: "",
      detailBanner: [],
      endTime: 0,
      detail: {},
      activeName: "first",
      total: 1,
      pageSize: 5,
      pageSizes: [10, 20, 30, 50],
      totalPage: 1,
      rules: {
        content: [{ required: true, message: "请输入内容", trigger: "blur" }],
      },
      storeupParams: {
        name: "",
        picture: "",
        refid: 0,
        tablename: "zixishi",
        userid: localStorage.getItem("userid"),
      },
      isStoreup: false,
      storeupInfo: {},
      buynumber: 1,
      seats: null, // 座位数据
      maxSelect: 1,
    };
  },
  computed: {
    // 已选座位文字显示
    selectedSeatsText() {
      return (
        this.seats
          .filter((s) => s.selected)
          .map((s) => s.number)
          .join(", ") || "暂无"
      );
    },
  },
  created() {
    this.init();
    this.initSeats();
  },
  //方法集合
  methods: {
    init() {
      this.baseUrl = this.$config.baseUrl;
      if (this.$route.query.detailObj) {
        this.detail = JSON.parse(this.$route.query.detailObj);
        // console.log(this.detail);
      }
      if (this.$route.query.storeupObj) {
        this.detail.id = JSON.parse(this.$route.query.storeupObj).refid;
      }
      this.$http
        .get(this.tablename + "/detail/" + this.detail.id, {})
        .then((res) => {
          if (res.data.code == 0) {
            // console.log(res);
            this.detail = res.data.data;
            this.title = this.detail.mingcheng;
            this.detailBanner = this.detail.tupian
              ? this.detail.tupian.split(",")
              : [];
            this.$forceUpdate();
            // console.log('ssss');
          }
        });

      this.getStoreupStatus();
    },
    async initSeats(zixishiId) {
      try {
        // 1. 从后端获取座位数据
        const response = await this.$http.get(this.tablename + "/seats/" + this.detail.id, {});
        const dbSeats = response.data; 
        console.log(dbSeats);
        // 2. 转换为前端需要的格式
        this.seats = dbSeats.map((seat) => ({
          id: `seat_${seat.id}`,
          number: `${seat.id}`,
          status: seat.status === 1 ? "available" : "occupied",
          selected: false,
        }));

        // 3. 清除旧状态
        this.error = "";
      } catch (err) {
        this.error = "座位数据加载失败";
        console.error("API错误:", err.response?.data || err.message);

        // 可选：显示默认空数据
        this.seats = [];
      }
    },

    // 获取座位颜色
    getSeatColor(seat) {
      if (seat.selected) return "#2E61E1";
      return seat.status === "occupied" ? "#F0F2F5" : "#fff";
    },

    // 点击座位
    handleSeatClick(seat) {
      if (seat.status === "occupied") {
        this.$message.warning("该座位已被占用");
        return;
      }

      const selectedCount = this.seats.filter((s) => s.selected).length;
      const newSeats = this.seats.map((s) => {
        if (s.id === seat.id) {
          if (!s.selected && selectedCount >= this.maxSelect) {
            this.$message.warning(`最多选择${this.maxSelect}个座位`);
            return s;
          }
          return { ...s, selected: !s.selected };
        }
        return s;
      });

      this.seats = newSeats;
    },
    onAcross(
      acrossTable,
      crossOptAudit,
      statusColumnName,
      tips,
      statusColumnValue
    ) {
      // ========== 1. 数据验证 ==========
      const validateSelection = () => {
        const selectedSeats = this.seats.filter((s) => s.selected);

        // 基础验证
        if (selectedSeats.length === 0) {
          this.$message.error("请先选择座位");
          return false;
        }

        // 二次验证（可选）：检查是否有座位在选中后被占用
        const conflictSeats = selectedSeats.filter(
          (s) => s.status === "occupied"
        );
        if (conflictSeats.length > 0) {
          this.$message.error(
            `座位 ${conflictSeats.map((s) => s.number)} 已被占用，请重新选择`
          );
          return false;
        }

        return selectedSeats;
      };

      // ========== 2. 数据存储 ==========
      const storeSelectionData = (seats) => {
        try {
          // 结构化存储数据
          const storageData = {
            version: "1.0",
            timestamp: new Date().getTime(),
            data: {
              seatNumbers: seats.map((s) => s.number),
              seatIds: seats.map((s) => s.id),
              zixishiId: this.detail.id,
            },
          };

          // 使用加密存储（可选）
          const encrypted = btoa(JSON.stringify(storageData));
          localStorage.setItem("seatSelection", encrypted);

          // 同步存储基础跨表数据
          localStorage.setItem("crossTable", "zixishi");
          localStorage.setItem("crossObj", JSON.stringify(this.detail));
        } catch (error) {
          console.error("本地存储失败:", error);
          this.$message.error("数据保存失败，请检查浏览器设置");
          return false;
        }
        return true;
      };

      // ========== 3. 主流程 ==========
      const selected = validateSelection();
      if (!selected) return;

      if (!storeSelectionData(selected)) return;

      // ========== 4. 路由跳转 ==========
      const routeParams = {
        path: `/index/${acrossTable}Add`,
        query: {
          type: "cross",
          // 通过URL传递基础信息（防localStorage失效）
          seats: selected.map((s) => s.id).join(","),
          zixishiId: this.detail.id,
        },
      };

      // 处理特殊状态跳转
      if (statusColumnName && !statusColumnName.startsWith("[")) {
        const obj = JSON.parse(localStorage.getItem("crossObj") || {});
        if (obj[statusColumnName] === statusColumnValue) {
          this.$message.success(tips);
          return;
        }
      }
      const obj = JSON.parse(localStorage.getItem("crossObj") || {});
      
      obj["zuowei"] =
        this.seats
          .filter((s) => s.selected)
          .map((s) => s.number)
          .join(", ") || "暂无";
      var updatedCrossObjStr = JSON.stringify(obj);

      // 保存回 localStorage
      localStorage.setItem("crossObj", updatedCrossObjStr);
      console.log(updatedCrossObjStr);
      //   console.log("修改后的对象:", obj);
      this.$router.push(routeParams);
    },
    storeup(type) {
      if (type == 1 && !this.isStoreup) {
        this.storeupParams.name = this.title;
        this.storeupParams.picture = this.detailBanner[0];
        this.storeupParams.refid = this.detail.id;
        this.storeupParams.type = type;
        this.$http.post("storeup/add", this.storeupParams).then((res) => {
          if (res.data.code == 0) {
            this.isStoreup = true;
            this.$message({
              type: "success",
              message: "收藏成功!",
              duration: 1500,
            });
          }
        });
      }
      if (type == -1 && this.isStoreup) {
        let delIds = new Array();
        delIds.push(this.storeupInfo.id);
        this.$http.post("storeup/delete", delIds).then((res) => {
          if (res.data.code == 0) {
            this.isStoreup = false;
            this.$message({
              type: "success",
              message: "取消成功!",
              duration: 1500,
            });
          }
        });
      }
    },
    getStoreupStatus() {
      if (localStorage.getItem("Token")) {
        this.$http
          .get("storeup/list", {
            params: {
              page: 1,
              limit: 1,
              type: 1,
              refid: this.detail.id,
              tablename: "zixishi",
              userid: localStorage.getItem("userid"),
            },
          })
          .then((res) => {
            if (res.data.code == 0 && res.data.data.list.length > 0) {
              this.isStoreup = true;
              this.storeupInfo = res.data.data.list[0];
            }
          });
      }
    },
    curChange(page) {
      this.getDiscussList(page);
    },
    prevClick(page) {
      this.getDiscussList(page);
    },
    nextClick(page) {
      this.getDiscussList(page);
    },
    // 下载
    download(file) {
      if (!file) {
        this.$message({
          type: "error",
          message: "文件不存在",
          duration: 1500,
        });
        return;
      }
      window.open(this.baseUrl + file);
    },
  },
  components: {
    CountDown,
  },
};
</script>
    
    <style rel="stylesheet/scss" lang="scss" scoped>
.detail-preview {
  .attr {
    .el-carousel /deep/ .el-carousel__indicator button {
      width: 0;
      height: 0;
      display: none;
    }

    .el-input-number__decrease:hover:not(.is-disabled)
      ~ .el-input
      .el-input__inner:not(.is-disabled),
    .el-input-number__increase:hover:not(.is-disabled)
      ~ .el-input
      .el-input__inner:not(.is-disabled) {
      border-color: none;
    }
  }

  .detail {
    & /deep/ .el-tabs__header .el-tabs__nav-wrap {
      margin-bottom: 0;
    }

    & .add .el-textarea {
      width: auto;
    }
  }
}

.attr .el-carousel /deep/ .el-carousel__container .el-carousel__arrow--left {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.attr
  .el-carousel
  /deep/
  .el-carousel__container
  .el-carousel__arrow--left:hover {
  background: red;
}

.attr .el-carousel /deep/ .el-carousel__container .el-carousel__arrow--right {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.attr
  .el-carousel
  /deep/
  .el-carousel__container
  .el-carousel__arrow--right:hover {
  background: red;
}

.attr .el-carousel /deep/ .el-carousel__indicators {
  padding: 0;
  margin: 0 0 10px;
  z-index: 2;
  position: absolute;
  list-style: none;
}

.attr .el-carousel /deep/ .el-carousel__indicators li {
  border-radius: 10px;
  padding: 0;
  margin: 0 4px;
  background: #fff;
  display: inline-block;
  width: 12px;
  opacity: 0.4;
  transition: 0.3s;
  height: 12px;
}

.attr .el-carousel /deep/ .el-carousel__indicators li:hover {
  padding: 0;
  margin: 0 4px;
  background: #fff;
  display: inline-block;
  width: 24px;
  opacity: 0.7;
  height: 12px;
}

.attr .el-carousel /deep/ .el-carousel__indicators li.is-active {
  padding: 0;
  margin: 0 4px;
  background: #fff;
  display: inline-block;
  width: 24px;
  opacity: 1;
  height: 12px;
}

.attr .el-input-number /deep/ .el-input-number__decrease {
  cursor: pointer;
  z-index: 1;
  display: flex;
  border-color: #dcdfe6;
  border-radius: 4px 0 0 4px;
  top: 1px;
  left: 1px;
  background: #2e61e1;
  width: 40px;
  justify-content: center;
  border-width: 0 1px 0 0;
  align-items: center;
  position: absolute;
  border-style: solid;
  text-align: center;
  height: 38px;
}

.attr .el-input-number /deep/ .el-input-number__decrease i {
  color: #fff;
  font-size: 14px;
}

.attr .el-input-number /deep/ .el-input-number__increase {
  cursor: pointer;
  z-index: 1;
  display: flex;
  border-color: #dcdfe6;
  right: 1px;
  border-radius: 0 4px 4px 0;
  top: 1px;
  background: #2e61e1;
  width: 40px;
  justify-content: center;
  border-width: 0 0 0 1px;
  align-items: center;
  position: absolute;
  border-style: solid;
  text-align: center;
  height: 38px;
}

.attr .el-input-number /deep/ .el-input-number__increase i {
  color: #fff;
  font-size: 14px;
}

.attr .el-input-number /deep/ .el-input .el-input__inner {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 0 40px;
  outline: none;
  color: #666;
  background: #fff;
  display: inline-block;
  width: 100%;
  font-size: 14px;
  line-height: 40px;
  text-align: center;
  height: 40px;
}

.detail-preview .detail.el-tabs /deep/ .el-tabs__header {
  padding: 10px;
  margin: 0;
  background: #ebf0f4;
  border-color: #e4e7ed;
  border-width: 0 0 1px 0;
  border-style: solid;
}

.detail-preview .detail.el-tabs /deep/ .el-tabs__header .el-tabs__item {
  border: 0;
  padding: 0 20px;
  margin: 0 10px;
  background-size: 100% 100%;
  color: #fff;
  font-weight: 500;
  display: inline-block;
  font-size: 14px;
  line-height: 40px;
  background: transparent;
  background-image: url(http://codegen.caihongy.cn/20221018/71c4fd01e19542dda750b9c9523c11bd.png);
  position: relative;
  list-style: none;
  height: 40px;
}

.detail-preview .detail.el-tabs /deep/ .el-tabs__header .el-tabs__item:hover {
  border: 0;
  background-size: 100% 100%;
  color: #fff;
  background-image: url(http://codegen.caihongy.cn/20221018/71c4fd01e19542dda750b9c9523c11bd.png);
}

.detail-preview
  .detail.el-tabs
  /deep/
  .el-tabs__header
  .el-tabs__item.is-active {
  border: 0;
  background-color: #ebf0f4;
  margin: 0 10px;
  background-size: 100% 100%;
  color: #fff;
  background-image: url(http://codegen.caihongy.cn/20221018/f6c1f39bff574b6cb2564bbedb76b604.png);
}

.detail-preview .detail.el-tabs /deep/ .el-tabs__content {
  padding: 15px;
}

.detail-preview .detail.el-tabs .add /deep/ .el-form-item__label {
  padding: 0 10px 0 0;
  color: #666;
  width: 80px;
  font-size: 14px;
  line-height: 40px;
  text-align: right;
}

.detail-preview .detail.el-tabs .add /deep/ .el-textarea__inner {
  border: 0;
  border-radius: 4px;
  padding: 0 12px;
  box-shadow: 0px 4px 10px 0px rgba(0, 0, 0, 0.302);
  outline: none;
  color: #333;
  width: 800px;
  font-size: 14px;
  line-height: 32px;
  height: 120px;
}

.breadcrumb-preview .el-breadcrumb /deep/ .el-breadcrumb__separator {
  margin: 0 9px;
  color: #000;
  font-weight: 500;
}

.breadcrumb-preview .el-breadcrumb /deep/ .el-breadcrumb__inner a {
  color: #000;
  display: inline-block;
}

.breadcrumb-preview .el-breadcrumb /deep/ .el-breadcrumb__inner {
  color: #000;
  display: inline-block;
}

.el-pagination /deep/ .el-pagination__total {
  margin: 0 10px 0 0;
  color: #666;
  font-weight: 400;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

.el-pagination /deep/ .btn-prev {
  border: none;
  border-radius: 2px;
  padding: 0;
  margin: 0 5px;
  color: #666;
  background: #f4f4f5;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  min-width: 35px;
  height: 28px;
}

.el-pagination /deep/ .btn-next {
  border: none;
  border-radius: 2px;
  padding: 0;
  margin: 0 5px;
  color: #666;
  background: #f4f4f5;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  min-width: 35px;
  height: 28px;
}

.el-pagination /deep/ .btn-prev:disabled {
  border: none;
  cursor: not-allowed;
  border-radius: 2px;
  padding: 0;
  margin: 0 5px;
  color: #c0c4cc;
  background: #f4f4f5;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

.el-pagination /deep/ .btn-next:disabled {
  border: none;
  cursor: not-allowed;
  border-radius: 2px;
  padding: 0;
  margin: 0 5px;
  color: #c0c4cc;
  background: #f4f4f5;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

.el-pagination /deep/ .el-pager {
  padding: 0;
  margin: 0;
  display: inline-block;
  vertical-align: top;
}

.el-pagination /deep/ .el-pager .number {
  cursor: pointer;
  padding: 0 4px;
  margin: 0 5px;
  color: #666;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 2px;
  background: #f4f4f5;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

.el-pagination /deep/ .el-pager .number:hover {
  cursor: pointer;
  padding: 0 4px;
  margin: 0 5px;
  color: #409eff;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 2px;
  background: #f4f4f5;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

.el-pagination /deep/ .el-pager .number.active {
  cursor: default;
  padding: 0 4px;
  margin: 0 5px;
  color: #fff;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 2px;
  background: #2e61e1;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

.el-pagination /deep/ .el-pagination__sizes {
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

.el-pagination /deep/ .el-pagination__sizes .el-input {
  margin: 0 5px;
  width: 100px;
  position: relative;
}

.el-pagination /deep/ .el-pagination__sizes .el-input .el-input__inner {
  border: 1px solid #dcdfe6;
  cursor: pointer;
  padding: 0 25px 0 8px;
  color: #606266;
  display: inline-block;
  font-size: 13px;
  line-height: 28px;
  border-radius: 3px;
  outline: 0;
  background: #fff;
  width: 100%;
  text-align: center;
  height: 28px;
}

.el-pagination /deep/ .el-pagination__sizes .el-input span.el-input__suffix {
  top: 0;
  position: absolute;
  right: 0;
  height: 100%;
}

.el-pagination
  /deep/
  .el-pagination__sizes
  .el-input
  .el-input__suffix
  .el-select__caret {
  cursor: pointer;
  color: #c0c4cc;
  width: 25px;
  font-size: 14px;
  line-height: 28px;
  text-align: center;
}

.el-pagination /deep/ .el-pagination__jump {
  margin: 0 0 0 24px;
  color: #606266;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

.el-pagination /deep/ .el-pagination__jump .el-input {
  border-radius: 3px;
  padding: 0 2px;
  margin: 0 2px;
  display: inline-block;
  width: 50px;
  font-size: 14px;
  line-height: 18px;
  position: relative;
  text-align: center;
  height: 28px;
}

.el-pagination /deep/ .el-pagination__jump .el-input .el-input__inner {
  border: 1px solid #dcdfe6;
  cursor: pointer;
  padding: 0 3px;
  color: #606266;
  display: inline-block;
  font-size: 14px;
  line-height: 28px;
  border-radius: 3px;
  outline: 0;
  background: #fff;
  width: 100%;
  text-align: center;
  height: 28px;
}
.seat-item:hover {
  transform: scale(1.05);
  box-shadow: 0 2px 8px rgba(46, 97, 225, 0.2);
}

/* 禁用状态 */
.seat-item.disabled {
  border-color: #dcdfe6 !important;
  background-color: #f0f2f5 !important;
  color: #c0c4cc !important;
}
</style>
    