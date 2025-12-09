package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
// 설정 파일 지정 -> 서버와 상관이 없음 : root-context.xml
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// 로그 객체 생성 -> lombok에서 log 이름으로 처리
@Log4j
public class SampleTests {

	// Restaurent의 자동생성과 DI를 하기위해 객체를 전달 : 자동DI
	@Setter(onMethod_ = @Autowired)// 어노테이션이 두개이상을때는 {}안에 ,로 구분하여 사용한다.  
	private Restaurent restaurent;
	
	// junit에서 테스트할 때 @Test 붙인것만 테스트 진행합니다.
	// 테스트 매서드는 여러개 사용가능하고
	// @Test 붙은것은 전부 테스트 합니다.
	@Test
	public void testExist() {
		// not null 확인 메서드
		// not null이 아니면(null이면) 예외발생 -> 프로그램(테스트)중단
		assertNotNull(restaurent);
		
		// 출력해서 확인하기
		// log4j.xml 파일 설정에
		// info -> info, warn, error 모두 출력
		// warn -> warn, error 일때만 출력
		// error -> error 만 출력
		// log.info(), log.warn(), log.error()
		log.info("-------------------------");
		log.info(restaurent);
		log.info(restaurent.getChef());
	}
}






