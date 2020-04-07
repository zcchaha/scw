package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.bean.TSecurityAdmin;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    TAdminMapper tAdminMapper;
    @Autowired
    TRoleMapper tRoleMapper;
    @Autowired
    TPermissionMapper tPermissionMapper;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //1、根据username查询 用户信息
        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(username);
        List<TAdmin> admins = tAdminMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(admins) || admins.size()>1)return null;
        TAdmin admin = admins.get(0);
//2、根据用户id查询角色(角色名称)集合
        List<String> roleNames = tRoleMapper.selectRoleNamesByAdminId(admin.getId());
        //3、根据用户id查询权限(权限名称)集合
        List<String> permissionNames = tPermissionMapper.selectPermissionNamesByAdminId(admin.getId());
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        if (!CollectionUtils.isEmpty(roleNames)){
            for (String roleName : roleNames) {
                authorities.add(new SimpleGrantedAuthority("ROLE_"+roleName));
            }
        }
        if(!CollectionUtils.isEmpty(permissionNames)){
            for (String permissionName : permissionNames) {
                authorities.add(new SimpleGrantedAuthority(permissionName));
            }
        }

        TSecurityAdmin securityAdmin = new TSecurityAdmin(admin, authorities);
        System.out.println("securityAdmin = " + admin+" , authrities:" + authorities);
        return securityAdmin;
    }
}
