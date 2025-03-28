package com.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.dao.KechengxinxiDao;
import com.entity.KechengxinxiEntity;
import com.entity.view.KechengxinxiView;
import com.service.KechengxinxiService;
import com.utils.PageUtils;
import com.utils.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("kechengxinxiService")
public class KechengxinxiServiceImpl extends ServiceImpl<KechengxinxiDao, KechengxinxiEntity> implements KechengxinxiService {


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<KechengxinxiEntity> page = this.selectPage(
                new Query<KechengxinxiEntity>(params).getPage(),
                new EntityWrapper<KechengxinxiEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<KechengxinxiEntity> wrapper) {
        Page<KechengxinxiView> page = new Query<KechengxinxiView>(params).getPage();
        page.setRecords(baseMapper.selectListView(page, wrapper));
        PageUtils pageUtil = new PageUtils(page);
        return pageUtil;
    }


    @Override
    public List<KechengxinxiView> selectListView(Wrapper<KechengxinxiEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public KechengxinxiView selectView(Wrapper<KechengxinxiEntity> wrapper) {
        return baseMapper.selectView(wrapper);
    }


}
