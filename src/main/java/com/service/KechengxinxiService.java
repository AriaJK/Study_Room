package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.KechengxinxiEntity;
import com.entity.view.KechengxinxiView;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * 课程信息
 */
public interface KechengxinxiService extends IService<KechengxinxiEntity> {

    PageUtils queryPage(Map<String, Object> params);


    List<KechengxinxiView> selectListView(Wrapper<KechengxinxiEntity> wrapper);

    KechengxinxiView selectView(@Param("ew") Wrapper<KechengxinxiEntity> wrapper);

    PageUtils queryPage(Map<String, Object> params, Wrapper<KechengxinxiEntity> wrapper);


}

