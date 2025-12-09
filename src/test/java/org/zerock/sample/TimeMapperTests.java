package org.zerock.sample;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.TimeMapper2;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TimeMapperTests {

	// 자동DI
	@Setter(onMethod_ = @Autowired)
	private TimeMapper2 timeMapper;
	
	@Test
	public void testGetTime() {
		log.info("-------[Mapper 어노테이션 테스트]-----------");
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime());
	}
	
	@Test
	public void testGetTime2() {
		log.info("-------[Mapper mapper.xml 테스트]-----------");
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime2());
	}
}







