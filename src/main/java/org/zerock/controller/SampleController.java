package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.apache.catalina.tribes.util.Arrays;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.vo.SampleVO;
import org.zerock.vo.SampleVOList;
import org.zerock.vo.TodoVO;

import lombok.extern.log4j.Log4j;

// @Controller, @RestController - url
// @Service - 처리
// @Repository - 데이터 (DB)
// @Component - 일반적인 클래스
// @~~Advice - 예외처리
@Controller
// servlet-context.xml에 base-package 가 정의되어있는지 확인
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	// Return이 없을시 (void type) 들어온 uri이름으로 jsp경로가 생성됩니다.
	// Return이 String
	// 1. redirect: 이 앞에 있으면 redirect 한다.(주어진경로)
	// 2. redirect가 없으면 forword 시킨다.
	@RequestMapping("/")
	public void basic() {
		log.info("basic...........");
		// "/WEB-INF/views/ + 매핑된 uri + .jsp"
	}
	
	// uri 매핑을 Get, Post를 허용
	// Default는 GET 방식
	@RequestMapping(value = "/basic",
			method = {RequestMethod.GET, RequestMethod.POST})
	// method가 하나만 있을때는 {}생략가능 합니다.
	public void basicGet() {
		log.info("basic get or post ---------");
	}
	
	// get방식 매핑 어노테이션
	@GetMapping("basicGetOnly")
	public void bosicGetOnly() {
		log.info("basic get only ---------");
	}
	
	// get방식 매핑
	@GetMapping("/ex01")
	// property(VO)로 넘어오는 데이터 받기
	// (setter이름과 name이 같으면 자동으로 받는다.)
	public String ex01(SampleVO vo) {
		log.info("get vo : " + vo);
		return "ex01";
	}

	// get방식 매핑
	@GetMapping("/ex02")
	// defaultValue에 적는 값은 반드시 String으로 적어야 한다.
	public String ex02(String name,
			@RequestParam(defaultValue = "0") int age) {
		log.info("get name=" + name + ",age=" + age);
		return "ex02_1234";
	}
	
	// get방식 매핑
	@GetMapping("/ex03")
	// defaultValue에 적는 값은 반드시 String으로 적어야 한다.
	public String ex03(@RequestParam("name") String name,
			@RequestParam(name = "age", defaultValue = "0") int age) {
		log.info("get name=" + name + ",age=" + age);
		return "ex03";
	}
	
	// get방식 매핑
	@GetMapping("/ex04List")
	// List타입의 변수는 @RequestParam 으로 name을 정의해 주어야 합니다.
	public String ex04List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ex04List : " + ids);
		return "ex04List";
	}
	
	// get방식 매핑
	@GetMapping("/ex05Array")
	// String[] 는 @RequestParam이 없으면 name이 같은곳으로 자동으로 저장된다.
	public String ex05Array(String[] ids) {
		log.info("ex05Array : " + Arrays.toString(ids));
		return "ex05Array";
	}
	
	// get방식 매핑
	@GetMapping("/ex06Bean")
	public String ex06Bean(SampleVOList list) {
		log.info("ex06Bean : " + list);
		return "ex06Bean";
	}
	
	//@InitBinder
	// 들어오는 데이터형식을 확인 할 때 사용하는 어노테이션
	// 방법1. @InitBinder로 구현
	// 방법2. 선언변수에 @DateTimeFormat(pattern = "yyyy-MM-dd") 으로 사용하기
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(java.util.Date.class, 
//				new CustomDateEditor(dateFormat, false));
//	}
	
	// get방식 매핑
	@GetMapping("/ex07")
	public String ex07(TodoVO vo) {
		log.info("ex07 : TodoVO : " + vo);
		return "ex07";
	}
	
	// get방식 매핑
	@GetMapping("/ex08")
	public String ex08(SampleVO vo, 
			@ModelAttribute("page") int page) {
		log.info("vo : " + vo);
		log.info("page : " + page);
		// "/WEB-INF/views + /sample/ex08 + .jsp"
		return "/sample/ex08";
	}
	
	// get매핑
	@GetMapping("/ex09")
	public @ResponseBody  SampleVO ex09() {
		SampleVO vo = new SampleVO();
		vo.setName("홍길동");
		vo.setAge(30);
		
		return vo;
	}
	
	// ResponseEntity 타입
	@GetMapping("/ex10")
	public ResponseEntity<String> ex10() {
		log.info("ex10---------------");
		String msg = "{\"name\": \"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
	}
	
	// get방식 - 파일 올리기 폼
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("exUpload------------------");
		//void type은
		// /WEB-INF/views/ + sample/exUpload + .jsp
	}
	
	// post방식 매핑 - 파일 올리기 처리(저장제외)
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		log.info("exUploadPost-----------------------");
		for (MultipartFile file: files) {
			log.info("-----------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
		}
	}
	
	// get 매핑
	@GetMapping("/ex11")
	public void ex11() {
		log.info("ex11 ------------");
		int num = 10 / 0;
	}
	
}









