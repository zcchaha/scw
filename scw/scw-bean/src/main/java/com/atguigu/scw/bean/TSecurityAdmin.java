package com.atguigu.scw.bean;

import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class TSecurityAdmin extends User {

    private TAdmin originalUser;//为了将数据库查出来的所有原始信息都保存

    @Override
    public String toString() {
        return "TSecurityAdmin{" +
                "originalUser=" + originalUser +
                '}';
    }

    public TSecurityAdmin(TAdmin admin, Collection<? extends GrantedAuthority> authorities){
        super(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, authorities);
        this.originalUser = admin;
    }

    public TSecurityAdmin(String username, String password, boolean enabled, boolean accountNonExpired,
                          boolean credentialsNonExpired, boolean accountNonLocked,
                          Collection<? extends GrantedAuthority> authorities) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
    }

    public TAdmin getOriginalUser() {
        return originalUser;
    }

    public void setOriginalUser(TAdmin originalUser) {
        this.originalUser = originalUser;
    }
}
