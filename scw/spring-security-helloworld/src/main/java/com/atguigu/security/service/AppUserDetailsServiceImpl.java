package com.atguigu.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AppUserDetailsServiceImpl implements UserDetailsService {
   @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //1、查询用户信息: javabean[属性名=属性值] , map{属性名:属性值}
        String sql = "SELECT * FROM t_admin WHERE loginacct = ?";
        Map<String, Object> adminMap = jdbcTemplate.queryForMap(sql, username);
        //2、查询用户的角色和权限信息   //adminMap代表数据库查询的用户信息
        if(CollectionUtils.isEmpty(adminMap)){
            return  null;
        }
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        //角色和权限集合
        sql = "SELECT  tr.id , tr.name FROM t_admin_role tar " +
                " JOIN t_role tr ON tar.roleid = tr.id WHERE tar.adminid = "+ adminMap.get("id");
        //List<Map<String,Object>> roles = jdbcTemplate.queryForList(sql,new ColumnMapRowMapper(), adminMap.get("id").toString());// 角色查询到的有多个，每一行数据使用一个Map对象接受，多个map对象存到一个List集合中
        List<Map<String, Object>> roles = jdbcTemplate.query(sql, new ColumnMapRowMapper());
        sql = "SELECT  tp.name FROM t_role_permission trp" +
                " JOIN t_permission tp ON trp.permissionid = tp.id  WHERE  tp.name IS NOT NULL AND    trp.roleid IN (";
        if(!CollectionUtils.isEmpty(roles)) {
            for (Map role : roles) {
                //角色封装
                authorities.add(new SimpleGrantedAuthority("ROLE_" + role.get("name").toString()));
                //1,2,3
                sql += role.get("id") + ",";
            }
            //   "IN(1,2,3, "
            sql = sql.substring(0, sql.length() - 1) + ")";
            List<String> permissions = jdbcTemplate.queryForList(sql, String.class);
            for (String permission : permissions) {
                authorities.add(new SimpleGrantedAuthority(permission));
            }
        }
        System.out.println("authorities = " + authorities);
        //3、创建主体对象  返回的主体对象数据代表数据库查询的用户信息
        return new User(adminMap.get("loginacct").toString() ,
                adminMap.get("userpswd").toString() ,authorities );
    }
}
