package org.zerock.member.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private  MemberMapper mapper;
	
	//로그인
	@Override
	public LoginVO login(LoginVO vo) {	
		return mapper.login(vo);
	}

	//회원가입
	@Override
	public Integer write(MemberVO vo) {		
		return mapper.write(vo);
	}

	
	//아아디 중복체크
	@Override
	public String checkID(String id) {
		return mapper.checkId(id);
	}

	//회원 정보 보기(페이지 따로 없음)
	@Override
	public MemberVO view(String id) {		
		return mapper.view(id);
	}

	//회원정보수정
	@Override
	public Integer update(MemberVO vo) {
	    return mapper.update(vo);
	}
	
    // 회원 목록 조회
    @Override
    public List<MemberVO> list(PageObject pageObject) {
        log.info("list() 실행 =====");
        pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(pageObject);
    }

    // 회원 상태 및 등급 업데이트
    @Override
    public void updateStatusAndGrade(String id, String status, int gradeNo) {
    	
        log.info("회원 상태 및 등급 업데이트: ID=" + id + ", Status=" + status + ", GradeNo=" + gradeNo);

        try {
            int rowsAffected = mapper.updateStatusAndGrade(id, status, gradeNo);
            if (rowsAffected == 0) {
                throw new IllegalArgumentException("해당 ID의 회원을 찾을 수 없습니다: " + id);
            }
            log.info("회원 상태 및 등급 업데이트 성공, 변경된 행 수: " + rowsAffected);
        } catch (Exception e) {
            log.error("회원 상태 및 등급 업데이트 실패: ", e);
            throw e;
        }
    	
        mapper.updateStatusAndGrade(id, status, gradeNo); // 여기서 mapper 인스턴스 사용
    }

	@Override
	public void updateMemberStatusToQuit(String id) {
		 mapper.updateMemberStatusToQuit(id, "탈퇴");
		
	}
	
	// 카카오 로그인 관련 메서드
    @Override
    public MemberVO findByEmail(String email) {
        return mapper.findByEmail(email);
    }

    @Override
    public void registerMember(MemberVO vo) {
        mapper.insertMember(vo);
    }


}
