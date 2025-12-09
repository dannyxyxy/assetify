package org.zerock.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.event.vo.EventVO;
import org.zerock.review.vo.ReviewVO;
import org.zerock.util.page.PageObject;

@Repository
public interface ReviewMapper {

	// 1-1  getTotalRow
	// mybatis에서 데이터 베이스 처리로 파라메터를 넘기는 개수는 1개입니다.
	// 2개의 자료형을 넘기고 싶을 때 하나로 만드는 작업이 필요합니다.
	// 그때 사용하는 어노테이션은 @Param 입니다.
	// @Param 은 자료형을 map (key, value) 으로 만들어 줍니다.
	// 로그인한 사용자가 본인이 작성한 리뷰만 확인하는 경우, rno 가 아닌 로그인한 회원의 id가 필요.
	public Long getTotalRow(
		@Param("pageObject") PageObject pageObject,
		@Param("rno") Long rno);
	
	// 1-2. list
	// 전체 리뷰 리스트 가져오기
    List<ReviewVO> selectAllReview();
    
    List<ReviewVO> goodsReview(Long goods_no);

	
	// 2. write
	public Integer write(ReviewVO vo);
	
	// 3. update
	public Integer update(ReviewVO vo);
	
	// 4. delete
	public Integer delete(ReviewVO vo);
	
	// 5. likeCount
	public Integer increaseLikeCount(Long rno);
	
	
	// 좋아요 중복 확인 메서드
	public Integer checkDuplicateLike(@Param("userId") String userId, @Param("reviewRno") Long reviewRno);

	// 좋아요 기록 추가 메서드
	public Integer insertLike(@Param("userId") String userId, @Param("reviewRno") Long reviewRno);

	public ReviewVO getReviewByRno(Long rno);

	public List<ReviewVO> selectReviewsByCategory(Long categoryId);

	public List<ReviewVO> selectUserReviews(String userId);
	
	
	
}
