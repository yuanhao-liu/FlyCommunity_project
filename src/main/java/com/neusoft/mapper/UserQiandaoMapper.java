package com.neusoft.mapper;

import com.neusoft.domain.UserQiandao;

public interface UserQiandaoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserQiandao record);

    int insertSelective(UserQiandao record);

    UserQiandao selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserQiandao record);

    int updateByPrimaryKey(UserQiandao record);
}