package org.zerock.qna.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class QnAVO {
	
	// QnA 테이블 필드
    private int no;                // 글 번호
    private String id;             // 작성자 ID
    private String title;          // 제목
    private String content;        // 내용
    private String replyContent;   // 답변 내용
    private String goods_code;      // 상품 코드
    private Date writeDate;        // 작성일
    private Date replyDate;        // 답변일
    private String qna_image_name; // 사진 저장 경로
    
    // Goods 테이블 필드
    private String goods_name;      // 상품 이름
    private String image_name;      // 상품 이미지 경로
}
