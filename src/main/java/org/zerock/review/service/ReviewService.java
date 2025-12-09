package org.zerock.review.service;

import java.util.List;

import org.zerock.event.vo.EventVO;
import org.zerock.review.vo.ReviewVO;
import org.zerock.util.page.PageObject;

public interface ReviewService {

	// 전체 리뷰 리스트 가져오기
    List<ReviewVO> getReviewAll();
    
    List<ReviewVO> goodsReview(Long goods_no);
    
	
	// 2. write
	public Integer write(ReviewVO vo);
	
	// 3. update
	public Integer update(ReviewVO vo);
	
	// 4. delete
	public Integer delete(ReviewVO vo);
	
	// 5. likeCount
	public Integer increaseLikeCount(Long rno);
	
	
	public Integer checkDuplicateLike(String userId, Long reviewRno); // 중복 체크 메서드
	public Integer insertLike(String userId, Long reviewRno); // 좋아요 기록 추가 메서드
	ReviewVO getReviewByRno(Long rno);
	
	public List<ReviewVO> getReviewsByCategory(Long categoryId);

}
