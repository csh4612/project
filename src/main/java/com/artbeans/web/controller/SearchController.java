package com.artbeans.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.artbeans.web.entity.ExhibitionInfo;
import com.artbeans.web.service.ExhibitionService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SearchController {
	
	@Autowired
	private ExhibitionService eService;
	
	@GetMapping("/search")
	public String search(@RequestParam (value = "keyword") String keyword, Model model) {
		log.info("search=>{}", keyword);
		model.addAttribute("keyword",keyword);
		log.info("model=>{}", model);
		return "/views/search/searchResults";
	}
	
	@GetMapping("/exhibition-search")
	public @ResponseBody List<ExhibitionInfo> getExhibitionInfoList(ExhibitionInfo exhibitionInfo){
		log.info("exhibitionList=>{}",exhibitionInfo);
		return eService.getExhibitionInfos(exhibitionInfo);
	}
	
	
	
}
