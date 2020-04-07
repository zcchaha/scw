package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.service.MenuService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminController {
@Autowired
AdminService adminService;
@Autowired
MenuService menuService;
    //2.访问main页面的请求
    @RequestMapping(value = {"/main","/main.html"})
    public String toMainPage(HttpSession session){
        List<TMenu> pmenus = menuService.getPMenus();
//        System.out.println(pmenus);
        session.setAttribute("pmenus",pmenus);
        return "user/main";
    }

    /*//1.处理登录请求的方法
    @PostMapping("/dologin")
    public String dologin(String loginacct, String userpswd, Model model, HttpSession session){
        TAdmin admin = adminService.dologin(loginacct,userpswd);
        if (admin == null){
            model.addAttribute("errorMsg","账号或密码错误，请重新登录");
            return "login";
        }
        session.setAttribute("admin",admin);
        return "redirect:/main.html";
    }
    //3.退出登录
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:index";
    }*/

    //4.跳转到用户维护页面的方法
    @GetMapping("/admin/index")
    public String listAllAdmin(HttpSession session,@RequestParam(required = false,defaultValue = "") String condition,Model model,@RequestParam(required = false ,defaultValue = "1") Integer pageNumber){
        //启用分页查询
        PageHelper.startPage(pageNumber,3);
        //设置所有用户列表设置到域中
        List<TAdmin> admins = adminService.getAllAdmins(condition);
        //获取详细的分页数据
        PageInfo<TAdmin> pageInfo = new PageInfo<TAdmin>(admins,3);
        session.setAttribute("totalPage",pageInfo.getPages());
        model.addAttribute("pageInfo",pageInfo);
        return "user/user";
    }
    //5.添加管理员
    @PostMapping("/admin/add")
    public String addAdmin(Model model, TAdmin admin,HttpSession session){
        try {
            adminService.addAdmin(admin);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("addMsg",e.getMessage());
            return "/user/add";
        }
        Integer totalPage = (Integer) session.getAttribute("totalPage");
        return "redirect:/admin/index?pageNumber="+(totalPage+1);
    }

    //6.跳转到edit页面的请求
    @GetMapping("/admin/edit.html")
    public String toEditPage(HttpSession session,Model model, Integer id , @RequestHeader(value = "referer")String ref){
        TAdmin admin = adminService.getAdmin(id);
        model.addAttribute("editAdmin" , admin);
        session.setAttribute("ref" , ref);
        return "user/edit";
    }
    //7.更新管理员
    @PostMapping("/admin/edit")
    public String updateAdmin(TAdmin admin,HttpSession session){
        adminService.updateAdmin(admin);
        String ref = (String) session.getAttribute("ref");
        return "redirect:"+ref;
    }
    //8.删除管理员
    @PreAuthorize("hasAnyRole('PM - 项目经理')")
    @GetMapping("/admin/deleteAdmin")
    public String deleteAdmin(Integer id,@RequestHeader("referer") String ref){
        adminService.deleteAdmin(id);
        return "redirect:"+ref;
    }
    //9.批量删除
    @GetMapping("/admin/batchDelAdmins")
    // 浏览器提交  ids=1,2,3  springmvc会自动将ids解析为List集合
    public String batchDelAdmins(@RequestParam("ids") List<Integer> ids,@RequestHeader("referer")String ref){
        adminService.batchDelAdmins(ids);
        return "redirect:"+ref;
    }

}
