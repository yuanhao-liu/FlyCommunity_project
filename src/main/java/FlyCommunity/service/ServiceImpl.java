package FlyCommunity.service;

import FlyCommunity.domain.User;
import FlyCommunity.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceImpl implements InService {
    @Autowired
    UserMapper userMapper;

    @Override
    public User checkEmail(String email) {
        User user1 = userMapper.selectByEmail(email);
        return user1;
    }

    @Override
    public int reg(User user) {
        int i = userMapper.insertSelective(user);
        return i;
    }

}
