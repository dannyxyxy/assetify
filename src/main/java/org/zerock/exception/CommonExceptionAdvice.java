package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

// 자동 생성 어노테이션
// @Controller, @RestController
// @Service
// @Repository
// @Component
// @~~~Advice

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	// 500번 error
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("Exception....." + ex.getMessage());
		// jsp로 ex 전달
		model.addAttribute("exception", ex);
		
		log.info(model);
		// /WEB-INF/views/ + error_page + .jsp
		return "error/error_page";
	}
	
	
	// 404 오류에 대한 처리
	// 매핑이 안된 URL일때 이곳에서 처리됩니다. -> views/custom404.jsp
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		log.error("Exception....." + ex.getMessage());
		// /WEB-INF/views/ + custom404 + .jsp
		return "error/custom404";
	}
	
	// web.xml에 적힌 404 error는
	// 매핑된 후에 jsp로 forward시 구현된 파일이 없으면 
	// 이동하는 error page입니다. -> views/error/noJSP_404.jsp
}



