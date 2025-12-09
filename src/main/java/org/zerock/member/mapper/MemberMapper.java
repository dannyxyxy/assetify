package org.zerock.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

@Repository
public interface MemberMapper {

	//login
	public LoginVO login(LoginVO vo);
	
	// checkId (아이디 중복확인)
	public String checkId(String id);

	// write (회원가입)
	public Integer write(MemberVO vo);
	
	//내 정보 보기(페이지 따로 없음)
	public MemberVO view(String id);

	// update(내 정보 수정)
	public Integer update(MemberVO vo);
	
	//회원 목록 조회
	public Long getTotalRow(PageObject pageObject);
	public List<MemberVO> list(PageObject pageObject);
	
	//회원 상태 및 등급 수정(관리자 로그인 시)
	public int updateStatusAndGrade(@Param("id") String id, 
            @Param("status") String status, 
            @Param("gradeNo") int gradeNo);
	
	// 내 정보에서 탈퇴 버튼 클릭 시 탈퇴 처리 (일반 회원 로그인 시)
	public void updateMemberStatusToQuit(@Param("id") String id, String string);
	
	// 카카오 ID로 사용자 조회
    // 신규 사용자 정보 저장
    void insertMember(MemberVO memberVO);

	public MemberVO findByEmail(String email);
	
}

