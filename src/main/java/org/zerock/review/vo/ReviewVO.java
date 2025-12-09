package org.zerock.review.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	private Long rno;		// 리뷰 번호 - PK
	private Long goods_no;	// 상품 번호 - goods 테이블의 goods_no 를 가져와서 사용. FK
	private String title;	// 리뷰 제목
	private String content;	// 리뷰 내용
	private String id;		// 리뷰 작성자 id - member 테이블의 id 을 가져와서 사용. FK
	private Date writeDate;	// 리뷰 작성일
	private Long likeCount;	// 리뷰 좋아요 개수
	private String status;	// 리뷰 상태
}
