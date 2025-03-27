const base = {
    get() {
        return {
            url : "http://localhost:8080/study_room/",
            name: "study_room",
            // 退出到首页链接
            indexUrl: 'http://localhost:8080/study_room/front/dist/index.html'
        };
    },
    getProjectName(){
        return {
            projectName: "高校自习室预约系统 "
        } 
    }
}
export default base
