package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.KechengxinxiEntity;
import com.entity.view.KechengxinxiView;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * 课程信息
 */
public interface KechengxinxiDao extends BaseMapper<KechengxinxiEntity> {


    List<KechengxinxiView> selectListView(@Param("ew") Wrapper<KechengxinxiEntity> wrapper);

    List<KechengxinxiView> selectListView(Pagination page, @Param("ew") Wrapper<KechengxinxiEntity> wrapper);

    KechengxinxiView selectView(@Param("ew") Wrapper<KechengxinxiEntity> wrapper);


}
