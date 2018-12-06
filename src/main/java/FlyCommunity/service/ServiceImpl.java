package FlyCommunity.service;


import FlyCommunity.domain.Tab_user;
import FlyCommunity.mapper.Tab_userMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceImpl implements InService {
    @Autowired
    Tab_userMapper tab_userMapper;

    @Override
    public Tab_user checkEmail(String email) {
        Tab_user user1 = tab_userMapper.selectByEmail(email);
        return user1;
    }

    @Override
    public int reg(Tab_user user) {
        int i = tab_userMapper.insertSelective(user);
        return i;
    }

}
