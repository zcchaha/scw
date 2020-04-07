package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.*;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TPermissionMenuMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import com.atguigu.scw.mapper.TRolePermissionMapper;
import com.atguigu.scw.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    TRoleMapper tRoleMapper;


    @Override
    public List<TRole> getRoles(String condition) {
        TRoleExample example = null;
        if (!StringUtils.isEmpty(condition)){
            example = new TRoleExample();
            example.createCriteria().andNameLike("%"+condition+"%");
        }
        return tRoleMapper.selectByExample(example);
    }

    @Override
    public void saveRole(TRole role) {
        tRoleMapper.insertSelective(role);
    }

    @Override
    public TRole getRole(Integer id) {
        return tRoleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateRole(TRole role) {
        tRoleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void delRole(Integer id) {
        tRoleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDelRoles(List<Integer> ids) {
        TRoleExample example = new TRoleExample();
        example.createCriteria().andIdIn(ids);
        tRoleMapper.deleteByExample(example);
    }
@Autowired
    TPermissionMapper tPermissionMapper;
    @Override
    public List<TPermission> getPermissions() {
        return tPermissionMapper.selectByExample(null);
    }

    @Autowired
    TRolePermissionMapper tRolePermissionMapper;
    @Override
    public List<Integer> getAssignedPermissionIds(Integer roleid) {
        TRolePermissionExample example = new TRolePermissionExample();
        example.createCriteria().andRoleidEqualTo(roleid);
        List<TRolePermission> tRolePermissions = tRolePermissionMapper.selectByExample(example);
        List<Integer> permissionids = new ArrayList<Integer>(tRolePermissions.size());
        for (TRolePermission tRolePermission : tRolePermissions) {
            permissionids.add(tRolePermission.getPermissionid());
        }

        return permissionids;
    }

    @Override
    public void deleteRolePermissions(Integer roleid) {
        TRolePermissionExample example = new TRolePermissionExample();
        example.createCriteria().andRoleidEqualTo(roleid);
        tRolePermissionMapper.deleteByExample(example);
    }

    @Override
    public void assignPerssionsToRole(Integer roleid, List<Integer> permissionids) {
        tRolePermissionMapper.batchInsertRolePermissions(roleid,permissionids);
    }


}
