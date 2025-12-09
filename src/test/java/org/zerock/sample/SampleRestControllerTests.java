package org.zerock.sample;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.vo.SampleVO;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
// 설정 파일 지정 -> 서버와 상관이 있다. : root-context.xml, servlet-context.xml
@WebAppConfiguration //웹 테스트시 설정해야 하는 어노테이션
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class SampleRestControllerTests {

	// 웹테스트를 위해서 WebApplicationContext의 자동생성과 DI하기위해 객체를 전달 : 자동DI
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	// servlet 테스트를 위한 변수
	private MockMvc mockMvc; // Spring의 WebMVC테스팅을 위한 가짜 MVC
	
	// mockMvc를 세팅하는 메서드
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testConvert() throws Exception {
		SampleVO vo = new SampleVO("홍길동", 10);
		
		String jsonStr = new Gson().toJson(vo);
		
		log.info(jsonStr);
		
		mockMvc.perform
				(
					post("/sampleRest/sample")
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonStr)
				).andExpect(status().is(200));
		
	}
}




