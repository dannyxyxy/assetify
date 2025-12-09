package org.zerock.qna.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.qna.mapper.QnAMapper;
import org.zerock.qna.vo.QnAVO;
import org.zerock.util.page.PageObject;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import lombok.extern.log4j.Log4j;

@Log4j
@Service("qnaServiceImpl")
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper mapper;

	// 1. QnA게시판 글 목록
	// 전체 게시글 조회 (관리자용)
	public List<QnAVO> list(String userId, int gradeNo, PageObject pageObject) {

		// gradeNo에 따라 전체 게시글 개수 조회
		if (gradeNo == 9) {
			pageObject.setTotalRow(mapper.getTotalRowForAdmin());
		} else {
			pageObject.setTotalRow(mapper.getTotalRowForUser(userId));
		}

		// 관리자이면 전체 게시글 조회, 일반 사용자이면 본인 게시글만 조회
		if (gradeNo == 9) {
			return mapper.listAll(pageObject);
		} else {
			return mapper.listByUserId(userId, pageObject);
		}
	}

	// 2. QnA게시판 글 보기
	@Override
	public QnAVO view(Long no) {
		log.info("view() 실행 =====");
		// 조회수 증가
//		if (inc == 1) mapper.increase(eno);
		// 글정보 가져오기
		return mapper.view(no);
	}

	// 3. QnA게시판 글등록
	// 트랜젝션 테스트를 위한 어노테이션 추가
	// @Transactional - 테스트용
	@Override
	public Integer write(QnAVO vo) {
		Integer result = mapper.write(vo); // 시퀀스에서 글번호 받아서 처리
		log.info("write() 실행 =====");
		return result;
	}

	// 4. QnA게시판 글 수정
	@Override
	public void update(QnAVO vo, MultipartFile imageFile, HttpServletRequest request) throws Exception {
		// 로그: 기존 이미지 경로 확인
		log.info("기존 이미지 경로: " + vo.getQna_image_name());

		// 새 이미지가 있는 경우
		if (imageFile != null && !imageFile.isEmpty()) {
			// 기존 이미지 삭제 (새로운 이미지가 있을 때만)
			if (vo.getQna_image_name() != null && !vo.getQna_image_name().isEmpty()) {
				deleteImageFile(vo.getQna_image_name(), request); // 기존 이미지 삭제
			}

			// 새 이미지 파일 처리
			String imagePath = processImageFile(imageFile, request);
			vo.setQna_image_name(imagePath); // 새로운 이미지 경로를 설정
			log.info("새 이미지가 등록되어 기존 이미지가 교체되었습니다.");
		} else {
			// 새 이미지가 없으면 기존 이미지를 그대로 유지
			log.info("새 이미지가 없으므로 기존 이미지 그대로 사용: " + vo.getQna_image_name());
			if (vo.getQna_image_name() == null || vo.getQna_image_name().isEmpty()) {
				// 기존 이미지가 없으면 빈 문자열을 설정할 수도 있음
				vo.setQna_image_name(""); // 또는 null을 그대로 두어도 됨
				log.info("기존 이미지도 없어서 빈 문자열을 설정");
			}
		}

		// QnA 글 정보 업데이트
		mapper.update(vo);
	}

	// 5. QnA게시판답변 기능
	public void updateReply(QnAVO vo) throws Exception {
		// replyContent만 수정하고 나머지 필드는 그대로 둡니다.
		log.info("답변 내용 수정: " + vo.getReplyContent());

		// 수정된 내용만 업데이트
		mapper.updateReply(vo);
	}

	// 이미지 파일 처리 (업로드 및 경로 반환)
	private String processImageFile(MultipartFile imageFile, HttpServletRequest request) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			// 업로드 경로 설정 (디렉토리 확인 및 생성)
			String uploadDir = request.getServletContext().getRealPath("/upload/qna/");
			File directory = new File(uploadDir);
			if (!directory.exists()) {
				directory.mkdirs(); // 디렉토리가 없으면 생성
			}

			// 이미지 파일명 생성 및 업로드
			String fileName = UUID.randomUUID() + "_" + imageFile.getOriginalFilename();
			File newFile = new File(uploadDir + fileName);
			imageFile.transferTo(newFile); // 파일 저장

			return "/upload/qna/" + fileName; // 반환 경로는 상대 경로
		}
		return null; // 이미지가 없으면 null 반환
	}

	// 기존 이미지 삭제 메서드
	private void deleteImageFile(String imagePath, HttpServletRequest request) {
		if (imagePath != null && !imagePath.isEmpty()) {
			// 실제 서버의 경로로 이미지 파일을 찾음
			String fullPath = request.getServletContext().getRealPath(imagePath);
			File imageFile = new File(fullPath);

			// 파일이 존재하면 삭제
			if (imageFile.exists()) {
				imageFile.delete(); // 기존 이미지 삭제
				log.info("기존 이미지 삭제됨: " + fullPath);
			} else {
				log.warn("삭제할 이미지 파일이 존재하지 않습니다: " + fullPath);
			}
		}
	}

	// 게시글 삭제
	@Override
	public int delete(Long no) {
		// 삭제 작업 수행
		return mapper.delete(no);
	}

}
