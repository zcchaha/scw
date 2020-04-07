package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/menu")
@Controller
public class MenuController {
    @Autowired
    MenuService menuService;
    //1.转发到menu菜单页面
    @GetMapping("/index")
    public String toMenuPage(){
        return "menus/menu";
    }
    //2.处理异步查询菜单集合的方法
    @ResponseBody
    @GetMapping("/getMenus")
    public List<TMenu> getMenus(){
        List<TMenu> pMenus = menuService.getPMenus();
        return pMenus;
    }
    //3.处理异步查询菜单集合的方法
    @ResponseBody
    @GetMapping("/delMenu")
    public String delMenu(Integer id){
        menuService.delMenu(id);
        return "ok";
    }
    //4.处理异步添加菜单的方法
    @ResponseBody
    @PostMapping("/addMenu")
    public String addMenu(TMenu tMenu){
        menuService.addMenu(tMenu);
        return "ok";
    }
    //5.处理异步修改查询菜单的方法
    @ResponseBody
    @GetMapping("/getMenu")
    public TMenu getMenu(Integer id){
        TMenu tMenu = menuService.getMenu(id);
        return tMenu;
    }
    //6.处理异步修改菜单的方法
    @ResponseBody
    @PostMapping("/updateMenu")
    public String updateMenu(TMenu tMenu){
        menuService.updateMenu(tMenu);
        return "ok";
    }
}
