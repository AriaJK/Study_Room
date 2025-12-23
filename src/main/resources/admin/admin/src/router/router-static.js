import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

// 组件引入（你原来的保持不变）
import Index from '@/views/index'
import Home from '@/views/home'
import Login from '@/views/login'
import NotFound from '@/views/404'
import UpdatePassword from '@/views/update-password'
import register from '@/views/register'
import center from '@/views/center'
import appointment_quxiaoyuyue from '@/views/modules/appointment/quxiaoyuyue/list'
import appointment_yuyuexinxi from '@/views/modules/appointment/yuyuexinxi/list'
import xuesheng_list from '@/views/modules/xuesheng/list'
import xuesheng_add from '@/views/modules/xuesheng/add-or-update'
import zixishi_list from '@/views/modules/zixishi/list'
import zixishi_add from '@/views/modules/zixishi/add-or-update'
import config from '@/views/modules/config/list'
import news from '@/views/modules/news/list'
import complaint from '@/views/modules/complaint/index'
import ranking from '@/views/modules/ranking/ranking'
import shensu from '@/views/modules/shensu/shensu'
import tubiaozhanshi from '@/views/modules/tubiaozhanshi/tubiaozhanshi'
import blacklist from '@/views/blacklist.vue'
import weiguiRecord from '@/views/weiguiRecord.vue'

// 1) routes 先定义
const routes = [
  {
    path: '/index',
    name: '系统首页',
    component: Index,
    children: [
      { path: '/', component: Home },
      { path: '/updatePassword', component: UpdatePassword },
      { path: '/center', component: center },
      { path: '/xuesheng_list', component: xuesheng_list },
      { path: '/xuesheng_add', component: xuesheng_add },
      { path: '/yuyuexinxi', component: appointment_yuyuexinxi },
      { path: '/quxiaoyuyue', component: appointment_quxiaoyuyue },
      { path: '/zixishi_list', component: zixishi_list },
      { path: '/zixishi_add', component: zixishi_add },
      { path: '/blacklist', component: blacklist },
      { path: '/WeiguiRecord', component: weiguiRecord },
      { path: '/shensu', component: shensu },
      { path: '/complaint', component: complaint },
      { path: '/ranking', component: ranking },
      { path: '/tubiaozhanshi', component: tubiaozhanshi },
      { path: '/config', component: config },
      { path: '/news', component: news },
    ],
  },
  { path: '/login', component: Login },
  { path: '/register', component: register },
  { path: '/', redirect: '/index' },
  { path: '*', component: NotFound },
]

const router = new VueRouter({
  mode: 'hash',
  routes
});

import storage from "@/utils/storage";

router.beforeEach((to, from, next) => {
  const q = to.query || {};
  const token = q.token;
  const role = q.role;
  const sessionTable = q.sessionTable;
  const adminName = q.adminName;

  // 1) 如果 URL 带了 token（从学生端跳过来）
  if (token) {
    // 用同一套 storage 写，保证 http.js 能读到
    storage.set("Token", token);
    storage.set("token", token); // 保险：有些代码读小写

    // 这些决定“显示哪个角色菜单”
    storage.set("role", role || "管理员");
    storage.set("sessionTable", sessionTable || "users");
    if (adminName) storage.set("adminName", adminName);

    // 清掉地址栏参数，并强制进首页
    return next({ path: "/index", query: {}, replace: true });
  }

  // 2) 已经有 token 还访问 /login，就别让他看登录页了，直接去首页
  const hasToken = storage.get("Token") || storage.get("token");
  if (hasToken && to.path === "/login") {
    return next("/index");
  }

  next();
});


export default router;

