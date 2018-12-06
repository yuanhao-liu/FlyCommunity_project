package FlyCommunity.mapper;

import FlyCommunity.domain.Tab_user;

public interface Tab_userMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tab_user record);

    int insertSelective(Tab_user record);

    Tab_user selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tab_user record);

    int updateByPrimaryKey(Tab_user record);

    Tab_user selectByEmail(String email);
}