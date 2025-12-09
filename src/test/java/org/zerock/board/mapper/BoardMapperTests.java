//package org.zerock.board.mapper;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.zerock.board.vo.BoardVO;
//import org.zerock.util.page.PageObject;
//
//import lombok.Setter;
//import lombok.extern.log4j.Log4j;
//
//// Mapper 메서드 단위 동작 테스트(쿼리테스트)
//// Test를 위해 사용되는 메서드
//@RunWith(SpringJUnit4ClassRunner.class)
//// 설정화일지정
//@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//// 로그객체생성
//@Log4j
//public class BoardMapperTests {
//
//	// 자동 DI
//	// 1. Lombok의 setter와 spring의 autowired 이용
//	// 2. spring의 autowired
//	// 3. inject이용
//	@Setter(onMethod_ = @Autowired)
//	private BoardMapper mapper;
//	
//	// 일반게시판 list() 테스트 - OK
//	//@Test   
//	public void testList() {
//		log.info("[일반게시판 리스트 (list()) 테스트] =====================");
//		
//		// 필요한 데이터(파라매타로 넘겨지는 데이터)는 하드코딩한다.
//		// pageObject 생성
//		PageObject pageObject = new PageObject();
//		log.info(mapper.list(pageObject));
//	}
//	
//	// 일반게시판 getTotalRow() 테스트 - OK
//	//@Test
//	public void testGetTotalRow() {
//		log.info("[일반게시판 리스트 총개수 (getTotalRow()) 테스트]===============");
//		
//		PageObject pageObject = new PageObject();
//		log.info(mapper.getTotalRow(pageObject));
//	}
//	
//	// 일반게시판 글보기
//	// increase // no = 42 - OK
//	//@Test
//	public void testIncrease() {
//		log.info("[일반게시판 글보기 조회수 1증가 (increase())테스트]");
//		// 필요한 파라매터는 하드코딩
//		// no = 42
//		Long no = 42L;
//		log.info(mapper.increase(no));
//	}
//	// view // no = 42 - OK
//	//@Test
//	public void testView() {
//		log.info("[일반게시판 글보기 (view()) 테스트]==========================");
//		Long no = 42L;
//		log.info(mapper.view(no));
//	}
//	
//	// 일반게시판 글등록 테스트 - OK
//	//@Test
//	public void testWrite() {
//		log.info("[일반게시판 글쓰기 처리 (write()) 테스트]=====================");
//		// 글쓰기에는 BoardVO 필요 - 하드코딩
//		BoardVO vo = new BoardVO();
//		vo.setTitle("글등록 테스트 JUint");
//		vo.setContent("글등록 데스트중 - 하드코딩");
//		vo.setWriter("이현진");
//		vo.setPw("1111");
//		log.info(mapper.write(vo));
//	}
//	
//	// 일반게시판 글수정 테스트 - no = 42 - ok
//	//@Test
//	public void testUpdate() {
//		log.info("[일반게시판 글수정 처리 (update()) 테스트]=====================");
//		// 글수정에 BoardVO 필요 - 하드코딩
//		BoardVO vo = new BoardVO();
//		vo.setNo(42L);
//		vo.setPw("1111");
//		vo.setTitle("junit 글수정 테스트");
//		vo.setContent("글수정 데스트중 - 하드코딩");
//		vo.setWriter("이현진");
//		
//		log.info(mapper.update(vo));
//	}
//	
//	// 일반게시판 글삭제 테스트 - ok
//	@Test
//	public void testDelete() {
//		log.info("[일반 게시판 글삭제 (delete()) 테스트]==========================");
//		// 글삭제에는 no 와 pw 가 필요합니다.
//		// BoardVO에 한번에 담아서 넘깁니다.
//		BoardVO vo = new BoardVO();
//		vo.setNo(42L);
//		vo.setPw("1111");
//		log.info(mapper.delete(vo));
//	}
//}
//
//
//
//
//
//
//
//
//
//
//
//
