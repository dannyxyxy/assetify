package org.zerock.qna.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import org.zerock.qna.vo.QnAVO;
import org.zerock.util.page.PageObject;

@Repository
public interface QnAMapper {

	// 1. QnA게시판 글 목록 조회
	// 관리자용 전체 게시글 개수 조회
    public Long getTotalRowForAdmin();
    // 일반 사용자용 본인 작성 게시글 개수 조회
    public Long getTotalRowForUser(@Param("userId") String userId);
    
	// 관리자용 전체 게시글 조회
    public List<QnAVO> listAll(PageObject pageObject);
    // 일반 사용자용 특정 작성자 게시글 조회
    public List<QnAVO> listByUserId(@Param("userId") String userId, @Param("pageObject") PageObject pageObject);
    //mybatis는 한 개의 객체만 전달할 수 있다.
    //두개 이상의 객체를 전달하고 샆을 때는 @Param 어노테이션을 사용한다.
    // @Param 어노테이션을 사용하면 Map으로 묶여서 전달된다.
    
    
	// 2. QnA게시판 글보기
	public QnAVO view(Long no);
	
	// 3. QnA게시판 글쓰기
	public Integer write(QnAVO vo);
	// 글등록의 트랜젝션 처리 테스트 위한 메서드
	
	// 4. QnA게시판 글 수정
	public Integer update(QnAVO vo);

	// 5. QnA게시판 답변
	public Integer updateReply(QnAVO vo);
	
	// 6. QnA게시판 글 삭제
	public int delete(Long no);
    
}
