package org.zerock.main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	@GetMapping(value = {"/", "/main.do"})
	public String goMain() {
		log.info("redirect main---------------");
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/main/main.do")
	public String main(Model model, HttpSession session) {
		log.info("/main/main.do =================");
		session.setAttribute("mainPage", "mainPage");
		return "main/main";
	}
	
	@RequestMapping("/main/cover")
	public String showCoverPage() {
	    return "cover"; 
	}
	
	@GetMapping("/main/carouselPage")
    public String carouselPage() {
        return "carouselPage"; // /WEB-INF/views/carouselPage.jsp를 반환
    }
}
