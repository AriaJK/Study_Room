<template>
<div :style='{"width":"1000px","padding":"20px","boxShadow":"0px 4px 10px 0px rgba(0,0,0,0.302)","margin":"10px auto","position":"relative","background":"#fff"}'>
    <el-form
      class="add-update-preview"
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="120px"
    >
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="课程名称" prop="kechengmingcheng">
            <el-input v-model="ruleForm.kechengmingcheng" 
                placeholder="课程名称" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="课程图片" v-if="type!='cross' || (type=='cross' && !ro.kechengtupian)" prop="kechengtupian">
            <file-upload
            tip="点击上传课程图片"
            action="file/upload"
            :limit="3"
            :multiple="true"
            :fileUrls="ruleForm.kechengtupian?ruleForm.kechengtupian:''"
            @change="kechengtupianUploadChange"
            ></file-upload>
          </el-form-item>
            <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' class="upload" v-else label="课程图片" prop="kechengtupian">
                <img v-if="ruleForm.kechengtupian.substring(0,4)=='http'" class="upload-img" style="margin-right:20px;" v-bind:key="index" :src="ruleForm.kechengtupian.split(',')[0]" width="100" height="100">
                <img v-else class="upload-img" style="margin-right:20px;" v-bind:key="index" v-for="(item,index) in ruleForm.kechengtupian.split(',')" :src="baseUrl+item" width="100" height="100">
            </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="课程类型" prop="kechengleixing">
            <el-input v-model="ruleForm.kechengleixing" 
                placeholder="课程类型" clearable ></el-input>
          </el-form-item>
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="课程资源" prop="kechengziyuan">
            <file-upload
            tip="点击上传课程资源"
            action="file/upload"
            :limit="1"
            :multiple="true"
            :fileUrls="ruleForm.kechengziyuan?ruleForm.kechengziyuan:''"
            @change="kechengziyuanUploadChange"
            ></file-upload>
          </el-form-item>  
          <el-form-item :style='{"width":"80%","padding":"10px","margin":"0 2% 10px","display":"inline-block"}' label="课程介绍" prop="kechengjieshao">
            <editor 
                :style='{"minHeight":"400px","padding":"0","boxShadow":"0 0 6px #2e61e1","margin":"0","borderColor":"#ccc","backgroundColor":"#fff","borderRadius":"0","color":"#000","borderWidth":"0","width":"100%","borderStyle":"solid","height":"auto"}'
                v-model="ruleForm.kechengjieshao" 
                class="editor" 
                action="file/upload">
            </editor>
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
            kechengmingcheng : false,
            kechengtupian : false,
            kechengleixing : false,
            kechengziyuan : false,
            kechengjieshao : false,
        },
        type: '',
        userTableName: localStorage.getItem('UserTableName'),
        ruleForm: {
          kechengmingcheng: '',
          kechengtupian: '',
          kechengleixing: '',
          kechengziyuan: '',
          kechengjieshao: '',
        },
        rules: {
          kechengmingcheng: [
            { required: true, message: '课程名称不能为空', trigger: 'blur' },
          ],
          kechengtupian: [
          ],
          kechengleixing: [
          ],
          kechengziyuan: [
          ],
          kechengjieshao: [
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
            if(o=='kechengmingcheng'){
              this.ruleForm.kechengmingcheng = obj[o];
              this.ro.kechengmingcheng = true;
              continue;
            }
            if(o=='kechengtupian'){
              this.ruleForm.kechengtupian = obj[o].split(",")[0];
              this.ro.kechengtupian = true;
              continue;
            }
            if(o=='kechengleixing'){
              this.ruleForm.kechengleixing = obj[o];
              this.ro.kechengleixing = true;
              continue;
            }
            if(o=='kechengziyuan'){
              this.ruleForm.kechengziyuan = obj[o];
              this.ro.kechengziyuan = true;
              continue;
            }
            if(o=='kechengjieshao'){
              this.ruleForm.kechengjieshao = obj[o];
              this.ro.kechengjieshao = true;
              continue;
            }
          }
        }
        // 获取用户信息
        this.$http.get(this.userTableName + '/session', {emulateJSON: true}).then(res => {
          if (res.data.code == 0) {
            var json = res.data.data;
          }
        });
      },

    // 多级联动参数
      // 多级联动参数
      info(id) {
        this.$http.get('kechengxinxi/detail/${id}', {emulateJSON: true}).then(res => {
          if (res.data.code == 0) {
            this.ruleForm = res.data.data;
          }
        });
      },
      // 提交
      onSubmit() {

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
                 this.$http.get('kechengxinxi/list', {
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


                          this.$http.post('kechengxinxi/add', this.ruleForm).then(res => {
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


                  this.$http.post('kechengxinxi/add', this.ruleForm).then(res => {
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
      kechengtupianUploadChange(fileUrls) {
          this.ruleForm.kechengtupian = fileUrls.replace(new RegExp(this.$config.baseUrl,"g"),"");;
      },
      kechengziyuanUploadChange(fileUrls) {
          this.ruleForm.kechengziyuan = fileUrls.replace(new RegExp(this.$config.baseUrl,"g"),"");;
      },
    }
  };
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.el-date-editor.el-input {
		width: auto;
	}
	
	.add-update-preview .el-form-item /deep/ .el-form-item__label {
	  padding: 0 10px 0 0;
	  color: #666;
	  font-weight: 500;
	  width: 120px;
	  font-size: 14px;
	  line-height: 40px;
	  text-align: center;
	}
	
	.add-update-preview .el-form-item /deep/ .el-form-item__content {
	  margin-left: 120px;
	}
	
	.add-update-preview .el-input /deep/ .el-input__inner {
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
	
	.add-update-preview .el-select /deep/ .el-input__inner {
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
	
	.add-update-preview .el-date-editor /deep/ .el-input__inner {
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
	
	.add-update-preview /deep/ .el-upload--picture-card {
		background: transparent;
		border: 0;
		border-radius: 0;
		width: auto;
		height: auto;
		line-height: initial;
		vertical-align: middle;
	}
	
	.add-update-preview /deep/ .upload .upload-img {
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
	
	.add-update-preview /deep/ .el-upload-list .el-upload-list__item {
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
	
	.add-update-preview /deep/ .el-upload .el-icon-plus {
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
	
	.add-update-preview .el-textarea /deep/ .el-textarea__inner {
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
