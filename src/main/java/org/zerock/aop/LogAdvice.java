package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

// 자동생성 어노테이션
// @Controller, @RestController
// @Service, @Repository
// @Component, @~~Advice

@Component
@Log4j
@Aspect	// AOP 프로그램으로 지정하는 어노테이션
public class LogAdvice {

	// servlet에서 execute() 함수에서 했던 처리를 대신 하도록 만들었다. 
	// PreceedingJoinPoint - 실행객체, 넘어가는 데이터
	// - 실행해야할 객체 : ~~~~ServiceImpl
	// - 넘어가는 데이터(parameter - no, pageObject, vo...)
	// @Around 는 실행객체 양쪽에 표시
	// '*' 는 모든 값을 의미하는 기호
	@Around("execution(* org.zerock.*.service.*ServiceImpl.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {
		
		// 결과 저장 변수 선언
		Object result = null;
		
		// 시작시간
		long start = System.currentTimeMillis(); // 단위 : msec 
		
		log.info("++ **********************  [AOP 실행 전 로그 출력]  *******************************");
		
		// 실행되는 객체의 이름을 출력
		log.info("++ 실행 객체 : " + pjp.getTarget());
		// 실행되는 매서드 출력
		log.info("++ 실행 매서드 : " + pjp.getSignature());
		// 전달 되는 파라메터 출력
		// pjp.getArgs() -> 배열로 되어있다.
		// 이때 배열을 문자열로 바꿔주는 것은 Arrays.toString(pjp.getArgs());
		log.info("++ 전달 되는 데이터 : " + Arrays.toString(pjp.getArgs()));
		
		log.info("++ *****************************************************************************);");
		
		// 실행 되는 부분
		result = pjp.proceed();
		
		log.info("++ **********************  [AOP 실행 후 로그 출력]  *******************************");
		// 실행 결과 출력
		log.info("++ 결과 데이터 : " + result);
		
		// 종료시간
		long end = System.currentTimeMillis();
		// 실행한 시간 출력 - 단위 : 1/1000 초
		log.info("++ 소요시간 : " + (end - start) + " msec");
		log.info("++ *****************************************************************************);");
		
		return result;
	}
}









