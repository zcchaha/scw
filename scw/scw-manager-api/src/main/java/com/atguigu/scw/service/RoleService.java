package com.atguigu.scw.service;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TRole;

import java.util.List;

public interface RoleService {
    List<TRole> getRoles(String condition);

    void saveRole(TRole role);

    TRole getRole(Integer id);

    void updateRole(TRole role);

    void delRole(Integer id);

    void batchDelRoles(List<Integer> ids);

    List<TPermission> getPermissions();

    List<Integer> getAssignedPermissionIds(Integer roleid);

    void deleteRolePermissions(Integer roleid);

    void assignPerssionsToRole(Integer roleid, List<Integer> permissionids);
}
