package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.vo.SampleVO;

import lombok.extern.log4j.Log4j;

// 자동생성 어노테이션
// @Controller, @RestController - url과 관련되어있습니다.
// @Service - 처리
// @Repository - 데이터
// @Component - 일반 객체
// @~~Advice - 예외처리
// @RestController 는 리턴형의 기본이 @ResponseBody 이므로 생략한다.
// @ResponseBody 라는 것은 순수한 데이터라는 의미
@RestController
@RequestMapping("/sampleRest")
@Log4j
public class SampleRestController {
// 객체를 JSON, XML 변환하기 위한 라이브러리
// jackson-databind(JSON), jackson-dataformat-xml(XML)
// 추가로 gson : java인스턴스를 JSON으로 변환하는 라이브러리
	
	// response 처리 : (서버 -> 클라이언트) 
	@GetMapping(value = "/getText", 
		produces = "text/plane; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	// vo객첼르 json과 xml 데이터로 처리(제공)
	@GetMapping(value = "/getSample", 
		produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
		})
	public SampleVO getSample() {
		return new SampleVO("홍길동", 10);
	}
	
	// produces 속성 생략이 가능하다.
	// 기본은 xml이다. json으로 받으려면 uri에 .json을 붙여서 호출한다.
	@GetMapping("/getSample2")
	public SampleVO getSample2() {
		return new SampleVO("홍길동", 10);
	}
	
	// List객체를 xml or Json으로 넘기기
	@GetMapping("/getList")
	public List<SampleVO> getList() {
		List<SampleVO> list = new ArrayList<SampleVO>();
		list.add(new SampleVO("홍길동", 10));
		list.add(new SampleVO("이순신", 20));
		list.add(new SampleVO("손흥민", 30));
		return list;
	}
	
	// Map 객체를 xml or json으로 데이터 제공
	@GetMapping("/getMap")
	public Map<String, Object> getMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		//1.
		map.put("vo", new SampleVO("김유신", 40));
		
		List<SampleVO> list = new ArrayList<SampleVO>();
		list.add(new SampleVO("홍길동", 10));
		list.add(new SampleVO("이순신", 20));
		list.add(new SampleVO("손흥민", 30));
		
		//2.
		map.put("list", list);
		
		return map;
	}
	
	// request 처리 (클라이언트 -> 서버)
	
	// URI 안에 데이터를 포함시켜서 전달하기
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
		@PathVariable("cat") String cat,
		@PathVariable("pid") Integer pid
		) {
		return new String[] {"category: " + cat, "productId: " + pid};
	}
	
	// JS의 JSON 데이터를 만들어서 문자열로 보내면 받을 수 있다.
	@PostMapping("/sample")
	public SampleVO convert(@RequestBody SampleVO vo) {
		log.info("convert...... vo: " + vo);
		return vo;
	}
}







