package org.zerock.event.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.event.mapper.EventMapper;
import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

// @Controller, RestController - uri
// @Service
// @Repository
// @Component
// @~~Advice
@Service
@Log4j
@Qualifier("eventServiceImpl")
public class EventServiceImpl implements EventService {
	
	// 자동 DI @Setter+ spring, @Autowired (spring), @Inject (라이브러리) 
	@Inject
	private EventMapper mapper;

	// 1. 이벤트 게시판 리스트
	@Override
	public List<EventVO> list(PageObject pageObject) {
		log.info("list() 실행 =====");
		// 전체 데이터 개수 구해서(startRow와 endRow가 세팅된다) controller 에 넘긴다.
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 2. 이벤트 게시판 글보기
	@Override
	public EventVO view(Long eno) {
		log.info("view() 실행 =====");
		// 조회수 증가
//		if (inc == 1) mapper.increase(eno);
		// 글정보 가져오기
		return mapper.view(eno);
	}
	
	// 3. 이벤트 게시판 글등록
	// 트랜젝션 테스트를 위한 어노테이션 추가
	//@Transactional - 테스트용
	@Override
	public Integer write(EventVO vo) {
		Integer result = mapper.write(vo); // 시퀀스에서 글번호 받아서 처리
		log.info("write() 실행 =====");
	//	vo.setNo(10000L);  - 테스트용
	//	mapper.writeTx(vo); // 위에서 사용한 글번호(PK) 재사용 -> PK 예외 발생  - 테스트용
		return result;
	}
	
	// 4. 이벤트 게시판 글수정
//	@Override
//	public Integer update(EventVO vo) {
//		log.info("update() 실행 =====");
//		return mapper.update(vo);
//	}
	// 4. 이벤트 게시판 글수정
	@Override
	public Integer update(EventVO vo) {
		Integer result = mapper.update(vo);
		log.info("update() 실행 =====");
		return result;
	}
	
	// 5. 이벤트 게시판 글삭제
	@Override
	public Integer delete(EventVO vo) {
		log.info("delete() 실행 =====");
		return mapper.delete(vo);
	}
	
	
	
	
	
	
	
	
	
	//메인페이지에 이벤트리스트를 전시하기 위해 만든것.
	@Override
	public List<EventVO> getAllEvents() {
		 List<EventVO> list = mapper.selectAllEvents();
		System.out.println("list" + list); // 출력 확인
	    return mapper.selectAllEvents(); // 이 메서드를 Mapper에서 구현
	}
}










