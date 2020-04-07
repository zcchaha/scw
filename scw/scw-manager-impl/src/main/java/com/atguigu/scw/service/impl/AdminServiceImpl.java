package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.utils.DateUtil;
import com.atguigu.scw.utils.MD5Util;
import com.atguigu.scw.utils.com.atguigu.scw.UserAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    TAdminMapper tAdminMapper;
    //用户登录功能
    @Override
    public TAdmin dologin(String loginacct, String userpswd) {
        TAdminExample tAdminExample = new TAdminExample();
        tAdminExample.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(MD5Util.digest(userpswd));
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(tAdminExample);
        if (CollectionUtils.isEmpty(tAdmins) || tAdmins.size() > 1){
            return null;
        }
        return tAdmins.get(0);
    }
//用户页面以及分页查询功能
    @Override
    public List<TAdmin> getAllAdmins(String condition) {
        TAdminExample example = null;
        if (!StringUtils.isEmpty(condition)){
            //传入的条件不为空，需要根据条件查询分页数据
            //账号  姓名或者邮箱只要包含condition字符串则查询该数据
            example = new TAdminExample();
            TAdminExample.Criteria c1 = example.createCriteria();
            c1.andLoginacctLike("%"+condition+"%");
            TAdminExample.Criteria c2 = example.createCriteria();
            c2.andUsernameLike("%"+condition+"%");
            TAdminExample.Criteria c3 = example.createCriteria();
            c3.andEmailLike("%"+condition+"%");
            example.or(c2);
            example.or(c3);
        }
        List<TAdmin> admins = tAdminMapper.selectByExample(example);
        return admins;
    }


    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
    @Override
    public void addAdmin(TAdmin admin) {

        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(admin.getLoginacct());

        if (tAdminMapper.countByExample(example) >= 1){
            throw new UserAccountException("账号已存在");
        }
        example.clear();;
        example.createCriteria().andEmailEqualTo(admin.getEmail());
        if (tAdminMapper.countByExample(example) >= 1){
            throw new UserAccountException("邮箱已存在");
        }

        admin.setCreatetime(DateUtil.getFormatTime());
        admin.setUserpswd(bCryptPasswordEncoder.encode(admin.getUserpswd()));
        tAdminMapper.insertSelective(admin);
    }

    @Override
    public TAdmin getAdmin(Integer id) {

        return tAdminMapper.selectByPrimaryKey(id);
    }



    @Override
    public void updateAdmin(TAdmin admin) {
        tAdminMapper.updateByPrimaryKeySelective(admin);
    }
    @Override
    public void deleteAdmin(Integer id) {
        tAdminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDelAdmins(List<Integer> ids) {
        TAdminExample example = new TAdminExample();
        example.createCriteria().andIdIn(ids);
        tAdminMapper.deleteByExample(example);
    }
}
