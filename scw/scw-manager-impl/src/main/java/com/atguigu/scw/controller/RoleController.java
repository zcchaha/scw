package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/role")
@Controller
public class RoleController {
    @Autowired
    RoleService roleService;


    //1、转发到role页面
    @GetMapping("/index")
    public String toRolePage(){
        return "/role/role";
    }
    //带条件查询分页集合的方法
    @ResponseBody
    //2.带条件的分页
    @GetMapping("/listRoles")
    public PageInfo<TRole> listRoles(@RequestParam(required = false,defaultValue = "1")Integer pageNumber, @RequestParam(required = false,defaultValue = "")String condition){

        PageHelper.startPage(pageNumber,3);
        List<TRole> roles = roleService.getRoles(condition);
        PageInfo<TRole> pageInfo = new PageInfo<TRole>(roles, 3);
        return pageInfo;
    }
    //3.异步新增的方法
    @ResponseBody
    @PostMapping("/addRole")
    public String addRole(TRole role){
        roleService.saveRole(role);
        return "ok";
    }
    //4.异步修改查询的方法
    @ResponseBody
    @GetMapping("/getRole")
    public TRole getRole(Integer id){
        TRole role = roleService.getRole(id);
        return role;
    }
    //5.异步修改查询的方法
    @ResponseBody
    @PostMapping("/updateRole")
    public String updateRole(TRole role){
        roleService.updateRole(role);
        return "ok";
    }
    //6、异步删除角色的方法
    @PreAuthorize("hasAnyRole('PM - 项目经理')")
    @ResponseBody
    @GetMapping("/delRole")
    public String delRole(Integer id){
        roleService.delRole(id);
        return "ok";
    }
    //7、异步批量删除角色的方法
    @ResponseBody
    @GetMapping("/batchDelRoles")
    public String batchDelRoles(@RequestParam List<Integer> ids){
        roleService.batchDelRoles(ids);
        return "ok";
    }
    //8、查询权限列表的方法的方法
    @ResponseBody
    @GetMapping("/getPermissions")
    public List<TPermission> getPermissions(){
        List<TPermission> permissions = roleService.getPermissions();
        return permissions;
    }
    //9、查询指定id拥有的权限id集合的方法
    @ResponseBody
    @GetMapping("/getAssignedPermissionIds")
    public List<Integer> getAssignedPermissionIds(Integer roleid){
        List<Integer> assignedPermissionIds = roleService.getAssignedPermissionIds(roleid);
        return assignedPermissionIds;
    }
    //10、分配权限之前先删除所拥有的所有的权限
    @ResponseBody
    @PostMapping("/assignPermissions")
    public String getAssignedPermissionIds(Integer roleid, @RequestParam List<Integer> permissionids){
        roleService.deleteRolePermissions(roleid);
        if (!CollectionUtils.isEmpty(permissionids)){
            roleService.assignPerssionsToRole(roleid,permissionids);
        }
        return "ok";
    }
}
