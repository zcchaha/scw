package com.atguigu.security.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class GongfuController {
	@GetMapping("/level1/1")
	public String leve11Page(){
		return "/level1/1";
	}

	@PreAuthorize("hasAnyRole('BZR')")
	@GetMapping("/level1/2")
	public String leve12Page(){
		return "/level1/2";
	}
	@GetMapping("/level1/3")
	public String leve13Page(){
		return "/level1/3";
	}

	@PreAuthorize("hasAnyAuthority('ROLE_BOSS' ,'user:delete') or hasAnyRole('MANAGER','PG - 程序员')")
	@GetMapping("/level2/{path}")
	public String leve2Page(@PathVariable("path")String path){
		return "/level2/"+path;
	}

	@PreAuthorize("hasAnyRole('HUANGSHANG')")
	@GetMapping("/level3/{path}")
	public String leve3Page(@PathVariable("path")String path){
		return "/level3/"+path;
	}

}
