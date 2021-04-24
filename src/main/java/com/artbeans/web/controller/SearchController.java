package com.artbeans.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.artbeans.web.dto.UserSession;
import com.artbeans.web.entity.ExhibitionInfo;
import com.artbeans.web.entity.GalleryInfo;
import com.artbeans.web.service.ExhibitionService;
import com.artbeans.web.service.GalleryService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SearchController {
	
	@Autowired
	private ExhibitionService eService;
	@Autowired
	private GalleryService gService;
	
	@GetMapping("/search") //헤더 검색창 단순 화면전환 및 keyword 키밸류 이동
	public String search(@RequestParam (value = "keyword") String keyword, Model model) {
		log.info("search=>{}", keyword);
		model.addAttribute("keyword",keyword);
		log.info("model=>{}", model);
		return "/views/search/searchResults";
	}
	
	@GetMapping("/Gallery-lists")// 통합검색 갤러리 위와 동일하게 name like로 가져옴
	public @ResponseBody List<GalleryInfo> getGalleryInfoList(@ModelAttribute GalleryInfo galleryInfo){
		return gService.getGalleryInfos(galleryInfo);
	}
	
	@GetMapping("/getExhibition") //로그인후 update 들어갈시 uiNum으로 전시회 가져옴
	public @ResponseBody List<ExhibitionInfo> getUserExhibition(UserSession userSession) {
		log.info("업데이트=>{}",eService.getExhibitionFindByUiNum(userSession));
		return eService.getExhibitionFindByUiNum(userSession);
	}
	
	
	
	
	
}
