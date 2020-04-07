package com.atguigu.scw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispatcherController {

    @RequestMapping(value = {"/","/index","index.html"})
    public String index(){

        return "index";
    }
    @RequestMapping(value = {"/login.html"})
    public String login(){

        return "login";
    }
    @RequestMapping(value = {"/add.html"})
    public String toAddUser(){

        return "user/add";
    }
}
