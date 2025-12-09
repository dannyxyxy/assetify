package org.zerock.event.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

@Repository
public interface EventMapper {

	// 1. 이벤트 게시판 리스트
	// 이벤트 게시판 리스트 페이지 처리를 위한 전체 데이터 개수를 가져온다.
	public Long getTotalRow(PageObject pageObject);
	// 리스트 가져오는 쿼리 실행
	public List<EventVO> list(PageObject pageObject);
	// 1. 드리이버확인
	// 2. DB연결
	// 3. SQL작성
	// 4. 실행객체에 데이터세팅
	// 5. 쿼리실행
	// 6. 데이터 담기
	// 7. DB닫기
	// 위의 7단계를 mybatis가 대신 처리해 준다.
	
	// 2. 이벤트 게시판 글보기
	// 조회수 증가
	public Integer increase(Long eno);
	
	// 글보기 (글정보)
	public EventVO view(Long eno);
	
	// 3. 이벤트 게시판 글쓰기
	public Integer write(EventVO vo);
	// 글등록의 트랜젝션 처리 테스트 위한 메서드
	//public Integer writeTx(EventVO vo);  - 테스트용
	
	// 4. 이벤트 게시판 글수정
	public Integer update(EventVO vo);
	
	// 5. 이벤트 게시판 글삭제
	public Integer delete(EventVO vo);
	
	
	
	
	//메인페이지에 이벤트리스트를 전시하기위한것.
	public List<EventVO> selectAllEvents();
}









