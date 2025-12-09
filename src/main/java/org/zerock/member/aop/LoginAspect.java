package org.zerock.member.aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.zerock.member.vo.LoginVO;

@Aspect
@Component
public class LoginAspect {

    @Autowired
    private HttpSession session;

    // 로그인 처리 전, 로그인 정보를 세션에서 가져오는 메서드
    @Before("execution(* org.zerock.member.controller.MemberController.login(org.zerock.member.vo.LoginVO))")
    public void beforeLoginCheck() {
        // 세션에서 LoginVO 객체를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        
        if (loginVO != null) {
            // 로그인된 상태에서만 실행
            session.setAttribute("login", loginVO);  // 로그인 정보 세션에 재설정
        }
    }
}
