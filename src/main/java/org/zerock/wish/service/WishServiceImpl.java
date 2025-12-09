package org.zerock.wish.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.wish.mapper.WishMapper;
import org.zerock.wish.vo.WishVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("wishServiceImpl")
public class WishServiceImpl implements WishService {

    @Setter(onMethod_ = @Autowired)
    private WishMapper mapper;
    
 // 사용자의 위시리스트 조회
    public List<WishVO> getWishList(String userId) {
        return mapper.getWishListByUserId(userId);
    }

    // 위시리스트에 상품 추가
    public boolean addWishItem(Long goodsNo, String userId) {
        WishVO wishVO = new WishVO();
        wishVO.setGoods_no(goodsNo);
        wishVO.setId(userId);
        wishVO.setTotal(1); // 처음 추가할 때 개수는 1로 설정
        return mapper.insertWishItem(wishVO);
    }

    public void removeWishItem(Long wishNo) {
        mapper.deleteWishItemByWishNo(wishNo);
    }
}
