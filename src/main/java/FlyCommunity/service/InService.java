package FlyCommunity.service;

import FlyCommunity.domain.Tab_user;


public interface InService {
    Tab_user checkEmail(String email);

    int reg(Tab_user user);
}
