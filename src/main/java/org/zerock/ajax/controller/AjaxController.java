package org.zerock.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class AjaxController {
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	
	@PostMapping("/checkId.do")
	public String checkId(String id, Model model) {
		
		id = service.checkID(id);
		log.info("id = " + id + "====");
		model.addAttribute("id", id);
		
		
		return "member/checkId";
	}
	

 
}
