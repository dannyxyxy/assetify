package org.zerock.event.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.event.mapper.EventMapper;
import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

public interface EventService {
	
	// 1. 이벤트 게시판 리스트
	public List<EventVO> list(PageObject pageObject);
	
	// 2. 이벤트 게시판 글보기
	public EventVO view(Long eno);
	
	// 3. 이벤트 게시판 글등록
	public Integer write(EventVO vo);
	
	// 4. 이벤트 게시판 글수정
	public Integer update(EventVO vo);
	
	// 5. 이벤트 게시판 글삭제
	public Integer delete(EventVO vo);
	
	
	
	// 메인페이지에 이벤트리스트를 전시하기 위한것 만지지말것.
	public List<EventVO> getAllEvents();
}










