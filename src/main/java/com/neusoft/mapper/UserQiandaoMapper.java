package com.neusoft.mapper;

import com.neusoft.domain.UserQiandao;

import java.util.Map;

public interface UserQiandaoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserQiandao record);

    int insertSelective(UserQiandao record);

    UserQiandao selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserQiandao record);

    int updateByPrimaryKey(UserQiandao record);

    UserQiandao selectByUserID(Integer id);

    Map<String,Object> selectForQiandao(Integer id);
}