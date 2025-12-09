package org.zerock.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.event.vo.EventVO;
import org.zerock.review.mapper.ReviewMapper;
import org.zerock.review.vo.ReviewVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

//	// 자동 DI
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;
	
	// 전체 리뷰 리스트 가져오기
    @Override
    public List<ReviewVO> getReviewAll() {
        return mapper.selectAllReview();
    }
    
    @Override
    public List<ReviewVO> goodsReview(Long goods_no) {
        return mapper.goodsReview(goods_no);
    }
    
    

	@Override
	public Integer write(ReviewVO vo) {
		Integer result = mapper.write(vo); // 시퀀스에서 글번호 받아서 처리
		log.info("write() 실행 - 리뷰 작성 완료, 작성자 ID: " + vo.getId());
		return result;
	}

	@Override
	public Integer update(ReviewVO vo) {
		Integer result = mapper.update(vo);
		log.info("update() 실행 - 리뷰 수정 완료, 리뷰 번호: " + vo.getRno());
		return result;
	}

	@Override
	public Integer delete(ReviewVO vo) {
		log.info("delete() 실행 - 리뷰 삭제 완료, 리뷰 번호: " + vo.getRno());
		return mapper.delete(vo);
	}
	
	// likeCount
	@Override
	public Integer increaseLikeCount(Long rno) {
	    return mapper.increaseLikeCount(rno);
	}
	
	
	
	@Override
	public Integer checkDuplicateLike(String userId, Long reviewRno) {
	    return mapper.checkDuplicateLike(userId, reviewRno);
	}

	@Override
	public Integer insertLike(String userId, Long reviewRno) {
	    return mapper.insertLike(userId, reviewRno);
	}
	
	@Override
	public ReviewVO getReviewByRno(Long rno) {
	    return mapper.getReviewByRno(rno);
	}
	
	
	@Override
	public List<ReviewVO> getReviewsByCategory(Long categoryId) {
	    return mapper.selectReviewsByCategory(categoryId);  // 카테고리별 리뷰 조회
	}

}
