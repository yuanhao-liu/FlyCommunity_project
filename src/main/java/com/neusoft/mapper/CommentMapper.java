package com.neusoft.mapper;

import com.neusoft.domain.Comment;

import java.util.List;
import java.util.Map;

public interface CommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);

    List<Map<String,Object>> selectByUseridAndTopicid(int id);

    List<Map<String,Object>> selectForMessage(int id);

    List<Map<String,Object>> selectForIndexHuitie();
}