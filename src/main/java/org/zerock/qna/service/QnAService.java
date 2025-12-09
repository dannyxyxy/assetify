package org.zerock.qna.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.qna.vo.QnAVO;
import org.zerock.util.page.PageObject;

public interface QnAService {

	//1. QnA게시판 글 목록
	public List<QnAVO> list(String userId, int gradeNo, PageObject pageObject);

	//2. QnA게시판 글 보기
	public QnAVO view(Long no);

	//3. QnA게시판 글 등록
	public Integer write(QnAVO vo);
	
	//4. QnA게시판 글 수정
	public void update(QnAVO vo, MultipartFile imageFile, HttpServletRequest request) throws Exception;
	
	//5. QnA게시판 답변 등록
	public void updateReply(QnAVO vo) throws Exception;
	
	//6. QnA게시판 글 삭제
	public int delete(Long no);
}
