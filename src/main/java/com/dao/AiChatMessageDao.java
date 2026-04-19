package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.entity.AiChatMessageEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AiChatMessageDao extends BaseMapper<AiChatMessageEntity> {
}