package FlyCommunity.service;

import FlyCommunity.domain.User;

public interface InService {
    User checkEmail(String email);

    int reg(User user);
}
