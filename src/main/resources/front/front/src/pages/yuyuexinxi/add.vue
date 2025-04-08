<template>
<div :style='{"width":"1000px","padding":"20px","boxShadow":"0px 4px 10px 0px rgba(0,0,0,0.302)","margin":"10px auto","position":"relative","background":"#fff"}'>
    <el-form
      class="add-update-preview"
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="120px"
    >
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="预约单号" prop="yuyuedanhao">
              <el-input v-model="ruleForm.yuyuedanhao" placeholder="预约单号" readonly></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="名称" prop="mingcheng">
            <el-input v-model="ruleForm.mingcheng" 
                placeholder="名称" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="图片" v-if="type!='cross' || (type=='cross' && !ro.tupian)" prop="tupian">
            <file-upload
            tip="点击上传图片"
            action="file/upload"
            :limit="3"
            :multiple="true"
            :fileUrls="ruleForm.tupian?ruleForm.tupian:''"
            @change="tupianUploadChange"
            ></file-upload>
          </el-form-item>
            <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' class="upload" v-else label="图片" prop="tupian">
                <img v-if="ruleForm.tupian.substring(0,4)=='http'" class="upload-img" style="margin-right:20px;" v-bind:key="index" :src="ruleForm.tupian.split(',')[0]" width="100" height="100">
                <img v-else class="upload-img" style="margin-right:20px;" v-bind:key="index" v-for="(item,index) in ruleForm.tupian.split(',')" :src="baseUrl+item" width="100" height="100">
            </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="座位" prop="zuowei">
            <el-input v-model="ruleForm.zuowei" 
                placeholder="座位" clearable readonly></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}'  label="签到状态" prop="qiandaozhuangtai">
            <el-select v-model="ruleForm.qiandaozhuangtai" placeholder="请选择签到状态" disabled >
              <el-option
                  v-for="(item,index) in qiandaozhuangtaiOptions"
                  :key="index"
                  :label="item"
                  :value="item">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="预约时间" prop="yuyueshijian" >
              <el-date-picker
                  value-format="yyyy-MM-dd HH:mm:ss"
                  v-model="ruleForm.yuyueshijian" 
                  type="datetime"
                  placeholder="预约时间">
              </el-date-picker>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="备注" prop="beizhu">
            <el-input v-model="ruleForm.beizhu" 
                placeholder="备注" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="学号" prop="xuehao">
            <el-input v-model="ruleForm.xuehao" 
                placeholder="学号" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="姓名" prop="xingming">
            <el-input v-model="ruleForm.xingming" 
                placeholder="姓名" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="手机" prop="shouji">
            <el-input v-model="ruleForm.shouji" 
                placeholder="手机" clearable ></el-input>
          </el-form-item>

      <el-form-item :style='{"padding":"0","margin":"0"}'>
        <el-button :style='{"border":"0","cursor":"pointer","padding":"0","margin":"0 20px 0 0","backgroundColor":"#fff","color":"rgba(255, 255, 255, 1)","backgroundImage":"url(http://codegen.caihongy.cn/20221018/f6c1f39bff574b6cb2564bbedb76b604.png)","outline":"none","borderRadius":"4px","width":"128px","lineHeight":"40px","fontSize":"14px","backgroundSize":"100% 100%","height":"40px"}'  type="primary" @click="onSubmit">提交</el-button>
        <el-button :style='{"border":"0px solid rgba(64, 158, 255, 1)","cursor":"pointer","padding":"0","margin":"0","backgroundColor":"#fff","color":"#fff","backgroundImage":"url(http://codegen.caihongy.cn/20221018/71c4fd01e19542dda750b9c9523c11bd.png)","outline":"none","borderRadius":"4px","width":"128px","lineHeight":"40px","fontSize":"14px","backgroundSize":"100% 100%","height":"40px"}' @click="back()">返回</el-button>
      </el-form-item>
    </el-form>
</div>
</template>

<script>
  export default {
    data() {
      return {
        id: '',
        baseUrl: '',
        ro:{
            yuyuedanhao : false,
            mingcheng : false,
            tupian : false,
            zuowei : false,
            qiandaozhuangtai : false,
            yuyueshijian : false,
            beizhu : false,
            xuehao : false,
            xingming : false,
            shouji : false,
            sfsh : false,
            shhf : false,
        },
        type: '',
        userTableName: localStorage.getItem('UserTableName'),
        ruleForm: {
          yuyuedanhao: this.getUUID(),
          mingcheng: '',
          tupian: '',
          zuowei: '1',
          qiandaozhuangtai: '未签到',
          yuyueshijian: '',
          beizhu: '',
          xuehao: '',
          xingming: '',
          shouji: '',
        },
        qiandaozhuangtaiOptions: [],
        rules: {
          yuyuedanhao: [
          ],
          mingcheng: [
          ],
          tupian: [
          ],
          zuowei: [
            { validator: this.$validate.isIntNumer, trigger: 'blur' },
          ],
          qiandaozhuangtai: [
          ],
          yuyueshijian: [
            { required: true, message: '预约时间不能为空', trigger: 'blur' },
          ],
          beizhu: [
          ],
          xuehao: [
          ],
          xingming: [
          ],
          shouji: [
            { validator: this.$validate.isMobile, trigger: 'blur' },
          ],
          sfsh: [
          ],
          shhf: [
          ],
        },
      };
    },
    computed: {



    },
    created() {
	  //this.bg();
      let type = this.$route.query.type ? this.$route.query.type : '';
      this.init(type);
      this.baseUrl = this.$config.baseUrl;
    },
    methods: {
      getMakeZero(s) {
          return s < 10 ? '0' + s : s;
      },
      // 下载
      download(file){
        window.open(`${file}`)
      },
      // 初始化
      init(type) {
        this.type = type;
        if(type=='cross'){
          var obj = JSON.parse(localStorage.getItem('crossObj'));
          for (var o in obj){
            if(o=='yuyuedanhao'){
              this.ruleForm.yuyuedanhao = obj[o];
              this.ro.yuyuedanhao = true;
              continue;
            }
            if(o=='mingcheng'){
              this.ruleForm.mingcheng = obj[o];
              this.ro.mingcheng = true;
              continue;
            }
            if(o=='tupian'){
              this.ruleForm.tupian = obj[o].split(",")[0];
              this.ro.tupian = true;
              continue;
            }
            if(o=='zuowei'){
              this.ruleForm.zuowei = obj[o];
              this.ro.zuowei = true;
              continue;
            }
            if(o=='qiandaozhuangtai'){
              this.ruleForm.qiandaozhuangtai = obj[o];
              this.ro.qiandaozhuangtai = true;
              continue;
            }
            if(o=='yuyueshijian'){
              this.ruleForm.yuyueshijian = obj[o];
              this.ro.yuyueshijian = true;
              continue;
            }
            if(o=='beizhu'){
              this.ruleForm.beizhu = obj[o];
              this.ro.beizhu = true;
              continue;
            }
            if(o=='xuehao'){
              this.ruleForm.xuehao = obj[o];
              this.ro.xuehao = true;
              continue;
            }
            if(o=='xingming'){
              this.ruleForm.xingming = obj[o];
              this.ro.xingming = true;
              continue;
            }
            if(o=='shouji'){
              this.ruleForm.shouji = obj[o];
              this.ro.shouji = true;
              continue;
            }
          }
          this.ruleForm.zuowei = 0
        }
        // 获取用户信息
        this.$http.get(this.userTableName + '/session', {emulateJSON: true}).then(res => {
          if (res.data.code == 0) {
            var json = res.data.data;
            if((json.xuehao!=''&&json.xuehao) || json.xuehao==0){
                this.ruleForm.xuehao = json.xuehao
            }
            if((json.xingming!=''&&json.xingming) || json.xingming==0){
                this.ruleForm.xingming = json.xingming
            }
            if((json.shouji!=''&&json.shouji) || json.shouji==0){
                this.ruleForm.shouji = json.shouji
            }
          }
        });
        this.qiandaozhuangtaiOptions = "已签到,未签到".split(',')
      },

    // 多级联动参数
      // 多级联动参数
      info(id) {
        this.$http.get('yuyuexinxi/detail/${id}', {emulateJSON: true}).then(res => {
          if (res.data.code == 0) {
            this.ruleForm = res.data.data;
          }
        });
      },
      // 提交
      onSubmit() {

        var obj = JSON.parse(localStorage.getItem('crossObj'));
        var table = localStorage.getItem('crossTable');
        obj.zuowei = obj.zuowei - this.ruleForm.zuowei
        if(obj.zuowei<0){
          this.$message.error("座位不足");
          return
        }
      
        //this.$http.post(table+`/update`, obj).then(res => {});
        //更新跨表属性
        var crossuserid;
        var crossrefid;
        var crossoptnum;
        this.$refs["ruleForm"].validate(valid => {
          if(valid) {
            if(this.type=='cross'){
                 var statusColumnName = localStorage.getItem('statusColumnName');
                 var statusColumnValue = localStorage.getItem('statusColumnValue');
                 if(statusColumnName && statusColumnName!='') {
                     var obj = JSON.parse(localStorage.getItem('crossObj'));
                     if(!statusColumnName.startsWith("[")) {
                         for (var o in obj){
                             if(o==statusColumnName){
                                 obj[o] = statusColumnValue;
                             }
                         }
                         var table = localStorage.getItem('crossTable');
                         this.$http.post(table+'/update', obj).then(res => {});
                     } else {
                            crossuserid=Number(localStorage.getItem('userid'));
                            crossrefid=obj['id'];
                            crossoptnum=localStorage.getItem('statusColumnName');
                            crossoptnum=crossoptnum.replace(/\[/,"").replace(/\]/,"");
                     }
                 }
            }
            if(crossrefid && crossuserid) {
                 this.ruleForm.crossuserid=crossuserid;
                 this.ruleForm.crossrefid=crossrefid;
                 var params = {
                     page: 1,
                     limit: 10,
                     crossuserid:crossuserid,
                     crossrefid:crossrefid,
                 }
                 this.$http.get('yuyuexinxi/list', {
                  params: params
                 }).then(res => {
                     if(res.data.data.total>=crossoptnum) {
                         this.$message({
                          message: localStorage.getItem('tips'),
                          type: 'success',
                          duration: 1500,
                         });
                          return false;
                     } else {
                         // 跨表计算
                          var obj = JSON.parse(localStorage.getItem('crossObj'));
                          var table = localStorage.getItem('crossTable');

                          obj.zuowei = parseFloat(obj.zuowei) - parseFloat(this.ruleForm.zuowei)

                          this.$http.post(table+`/update`,obj).then(res => {});
                          this.$http.post('yuyuexinxi/add', this.ruleForm).then(res => {
                              if (res.data.code == 0) {
                                  this.$message({
                                      message: '操作成功',
                                      type: 'success',
                                      duration: 1500,
                                      onClose: () => {
                                          this.$router.go(-1);
                                      }
                                  });
                              } else {
                                  this.$message({
                                      message: res.data.msg,
                                      type: 'error',
                                      duration: 1500
                                  });
                              }
                          });
                     }
                 });
             } else {
                  var obj = JSON.parse(localStorage.getItem('crossObj'));
                  var table = localStorage.getItem('crossTable');

                  obj.zuowei = parseFloat(obj.zuowei) - parseFloat(this.ruleForm.zuowei)

                  this.$http.post(table+`/update`,obj).then(res => {});
                  this.$http.post('yuyuexinxi/add', this.ruleForm).then(res => {
                     if (res.data.code == 0) {
                          this.$message({
                              message: '操作成功',
                              type: 'success',
                              duration: 1500,
                              onClose: () => {
                                  this.$router.go(-1);
                              }
                          });
                      } else {
                          this.$message({
                              message: res.data.msg,
                              type: 'error',
                              duration: 1500
                          });
                      }
                  });
             }
          }
        });
      },
      // 获取uuid
      getUUID () {
        return new Date().getTime();
      },
      // 返回
      back() {
        this.$router.go(-1);
      },
      tupianUploadChange(fileUrls) {
          this.ruleForm.tupian = fileUrls.replace(new RegExp(this.$config.baseUrl,"g"),"");;
      },
    }
  };
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.el-date-editor.el-input {
		width: auto;
	}
	
	.add-update-preview .el-form-item >>> .el-form-item__label {
	  padding: 0 10px 0 0;
	  color: #666;
	  font-weight: 500;
	  width: 120px;
	  font-size: 14px;
	  line-height: 40px;
	  text-align: center;
	}
	
	.add-update-preview .el-form-item >>> .el-form-item__content {
	  margin-left: 120px;
	}
	
	.add-update-preview .el-input >>> .el-input__inner {
	  border: 2px solid #2e61e1;
	  border-radius: 4px;
	  padding: 0 12px;
	  outline: none;
	  color: #000;
	  background: #BFD2FC;
	  width: 100%;
	  font-size: 14px;
	  height: 40px;
	}
	
	.add-update-preview .el-select >>> .el-input__inner {
	  border: 2px solid #2e61e1;
	  border-radius: 4px;
	  padding: 0 10px;
	  outline: none;
	  color: #000;
	  background: #BFD2FC;
	  width: 100%;
	  font-size: 14px;
	  height: 40px;
	}
	
	.add-update-preview .el-date-editor >>> .el-input__inner {
	  border: 2px solid #2e61e1;
	  border-radius: 4px;
	  padding: 0 10px 0 30px;
	  outline: none;
	  color: #000;
	  background: #BFD2FC;
	  width: 100%;
	  font-size: 14px;
	  height: 40px;
	}
	
	.add-update-preview >>> .el-upload--picture-card {
		background: transparent;
		border: 0;
		border-radius: 0;
		width: auto;
		height: auto;
		line-height: initial;
		vertical-align: middle;
	}
	
	.add-update-preview >>> .upload .upload-img {
	  border: 1px dashed rgba(64, 158, 255, 1);
	  cursor: pointer;
	  border-radius: 6px;
	  color: rgba(64, 158, 255, 1);
	  width: 100px;
	  font-size: 32px;
	  line-height: 100px;
	  text-align: center;
	  height: 100px;
	}
	
	.add-update-preview >>> .el-upload-list .el-upload-list__item {
	  border: 1px dashed rgba(64, 158, 255, 1);
	  cursor: pointer;
	  border-radius: 6px;
	  color: rgba(64, 158, 255, 1);
	  width: 100px;
	  font-size: 32px;
	  line-height: 100px;
	  text-align: center;
	  height: 100px;
	}
	
	.add-update-preview >>> .el-upload .el-icon-plus {
	  border: 1px dashed rgba(64, 158, 255, 1);
	  cursor: pointer;
	  border-radius: 6px;
	  color: rgba(64, 158, 255, 1);
	  width: 100px;
	  font-size: 32px;
	  line-height: 100px;
	  text-align: center;
	  height: 100px;
	}
	
	.add-update-preview .el-textarea >>> .el-textarea__inner {
	  border: 2px solid #2e61e1;
	  border-radius: 4px;
	  padding: 12px;
	  outline: none;
	  color: #000;
	  background: #BFD2FC;
	  width: 100%;
	  font-size: 14px;
	  height: 120px;
	}
</style>
