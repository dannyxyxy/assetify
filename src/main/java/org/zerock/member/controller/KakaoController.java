package org.zerock.member.controller;

import org.zerock.member.service.KakaoService;
import org.zerock.member.vo.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class KakaoController {

    private final KakaoService kakaoService;

    public KakaoController(KakaoService kakaoService) {
        this.kakaoService = kakaoService;
    }

    @GetMapping("/member/kakaoCallback")
    public ModelAndView kakaoCallback(@RequestParam("code") String code) {
        // 1. 카카오 인증 코드로 Access Token을 받아오기
        String accessToken = kakaoService.getAccessToken(code);

        // 2. Access Token을 사용하여 사용자 정보 가져오기
        MemberVO userInfo = kakaoService.getUserInfo(accessToken);

        // 3. 사용자 정보를 DB에 저장하거나 로그인 처리
        boolean isNewUser = kakaoService.loginOrRegisterUser(userInfo);

        // 4. 로그인/회원가입 후 리다이렉트 처리
        ModelAndView mav = new ModelAndView();
        if (isNewUser) {
            mav.setViewName("redirect:/member/writeForm"); // 신규 사용자면 welcome 페이지로 리다이렉트
        } else {
            mav.setViewName("redirect:/main/main.do"); // 기존 사용자면 홈 페이지로 리다이렉트
        }

        return mav;
    }
}
