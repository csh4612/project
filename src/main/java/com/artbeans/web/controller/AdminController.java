package com.artbeans.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.artbeans.web.entity.Admin;
import com.artbeans.web.service.AdminService;
import com.artbeans.web.api.SearchAPI;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@PostMapping("/admin/login")
	public @ResponseBody Admin login(@RequestBody Admin admin, HttpServletRequest req) {
		Admin ad = adminService.login(admin); 
		if(ad!=null) {
			log.info("ad=>{}",ad);
			HttpSession session = req.getSession();
			session.setAttribute("admin", ad);
		}
		return ad;
	}
	
	@PostMapping("/admin/logout")
	public @ResponseBody boolean logout(HttpServletRequest req) {
		HttpSession hs = req.getSession();
		hs.invalidate();
		return true;
	}
	
	@GetMapping("/admin/hidden-search")
	public @ResponseBody String searchSomething(@RequestParam String search,String pageNum) {
		log.info("search=>{}",search);
		log.info("pageNum=>{}",pageNum);
		return SearchAPI.resultSearch(search,pageNum);
	}
	
}
