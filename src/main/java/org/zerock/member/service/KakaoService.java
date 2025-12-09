package org.zerock.member.service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.http.*;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.MemberVO;

@Service
public class KakaoService {

    @Value("${kakao.client.id}")
    private String clientId;

    @Value("${kakao.client.secret}")
    private String clientSecret;

    private final String KAKAO_API_URL = "https://kauth.kakao.com/oauth/token";
    private final String KAKAO_USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";

    private final MemberMapper memberMapper;

    public KakaoService(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    public String getAccessToken(String code) {
        String redirectUri = "http://localhost/member/kakaoCallback"; // 카카오 로그인 리다이렉트 URI

        // 카카오 API URL 및 파라미터 설정
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("https://kauth.kakao.com/oauth/token")
                .queryParam("grant_type", "authorization_code")
                .queryParam("client_id", clientId) // 클라이언트 ID
                .queryParam("client_secret", clientSecret) // 클라이언트 시크릿
                .queryParam("redirect_uri", redirectUri)
                .queryParam("code", code); // 받은 인증 코드

        // HTTP 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate을 사용하여 HTTP POST 요청
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.POST, entity, String.class);

        // 응답에서 access_token 추출
        return extractAccessToken(response.getBody());
    }

    private String extractAccessToken(String responseBody) {
        // JSON 파싱하여 access_token 추출
        JSONObject jsonObject = new JSONObject(responseBody);
        return jsonObject.getString("access_token");
    }
   
    
    public MemberVO getUserInfo(String accessToken) {
        String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        try {
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, String.class);
            
            System.out.println("Response status: " + response.getStatusCode());
            System.out.println("Response body: " + response.getBody());
            
            return parseUserInfo(response.getBody());
        } catch (HttpClientErrorException e) {
            System.out.println("Error status code: " + e.getStatusCode());
            System.out.println("Error response body: " + e.getResponseBodyAsString());
            throw e;
        }
    }

    private MemberVO parseUserInfo(String responseBody) {
        // JSON 파싱하여 사용자 정보 추출
        JSONObject jsonObject = new JSONObject(responseBody);
        MemberVO memberVO = new MemberVO();
        memberVO.setId(jsonObject.getString("id"));
        memberVO.setEmail(jsonObject.getString("email"));
        memberVO.setName(jsonObject.getString("name"));
        memberVO.setPhoto(jsonObject.getString("profile_image"));
        return memberVO;
    }

    // 회원 가입 또는 로그인 처리
    public boolean loginOrRegisterUser(MemberVO userInfo) {
        MemberVO existingUser = memberMapper.findByEmail(userInfo.getId());

        if (existingUser == null) {
            // 신규 사용자이면 회원가입 처리
            memberMapper.insertMember(userInfo);
            return true;  // 신규 사용자
        } else {
            // 기존 사용자이면 로그인 처리
            return false;  // 기존 사용자
        }
    }


}

