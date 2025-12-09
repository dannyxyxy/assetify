package org.zerock.util.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zerock.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthrityInterceptor extends HandlerInterceptorAdapter {
	
	// 권한 정보가 들어있는 map<uri, 등급정보>
	private Map<String, Integer> authMap = new HashMap<String, Integer>();
	
	// 권한 정보를 등록하는 초기화 블럭
	{
		// 등급이 1: 로그인이 필요, 등급이 9: 로그인 & 관리자 권한
		// 댓글
		authMap.put("/boardreply/write.do", 1);
		authMap.put("/boardreply/update.do", 1);
		authMap.put("/boardreply/delete.do", 1);
		
		// 회원관리
		authMap.put("/member/logout.do", 1);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// 권한 처리 진행
		log.info("==== 권한 처리 Interceptor ============================");
		
		// 로그인 했는지? - 사용자 권한(등급번호 : login<session>), 페이지권한(AuthMap)
		// 페이지 권한
		String uri = request.getRequestURI();
		Integer pageGrade = authMap.get(uri);
		
		// 로그인이 필요하다.
		if (pageGrade != null) {
			HttpSession session = request.getSession();
			LoginVO vo = (LoginVO) session.getAttribute("login");
			// 로그인 안한 경우
			if (vo == null) {
				// 권한 오류 JSP로 이동시킨다.
				request.getRequestDispatcher("/WEB-INF/views/error/loginError.jsp")
					.forward(request, response);
				
				return false;
			}
			
			// 로그인이 되어있다.
			// 사용자의 페이지 권한 확인
			Integer userGrade = vo.getGradeNo();
			if (pageGrade > userGrade) {
				// 권한 오류 JSP로 이동시킨다.
				request.getRequestDispatcher("/WEB-INF/views/error/authError.jsp")
					.forward(request, response);
				
				return false;
			}
		}
		
		return super.preHandle(request, response, handler);
	}

}
