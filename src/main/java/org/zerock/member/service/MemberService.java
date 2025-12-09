package org.zerock.member.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

public interface MemberService {
	
	//로그인
	public LoginVO login(LoginVO vo);
	
	//아이디 중복확인
	public String checkID(String id);

	//회원가입
	public Integer write(MemberVO vo);
	
	//회원 정보 보기(페이지 따로 없음)
	public MemberVO view(String id);
	
	//내정보 수정
	public Integer update(MemberVO vo);

	//회원 목록
	public List<MemberVO> list(PageObject pageObject);

	//회원 상태 및 등급 수정 (관리자 로그인 시)
	public void updateStatusAndGrade(String id, String status, int gradeNo) throws Exception;
	
	// 내 정보에서 탈퇴 버튼 클릭 시 탈퇴 처리 (일반 회원 로그인 시) 
	public void updateMemberStatusToQuit(String id);
	
	// 카카오 로그인 관련 추가 메서드
    public MemberVO findByEmail(String email);  // 이메일로 회원 조회
    public void registerMember(MemberVO vo);  // 신규 회원 등록
	

}
