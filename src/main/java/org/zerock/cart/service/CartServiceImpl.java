package org.zerock.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.cart.mapper.CartMapper;
import org.zerock.cart.vo.CartSummaryVO;
import org.zerock.cart.vo.CartVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("cartServiceImpl")
public class CartServiceImpl implements CartService{

	@Setter(onMethod_ = @Autowired)
    private CartMapper cartMapper;
	// 사용자의 위시리스트 조회
    public List<CartVO> getCartList(String userId) {
        return cartMapper.getCartListByUserId(userId);
    }

    // 위시리스트에 상품 추가
    public boolean addCartItem(Long goodsNo, String userId) {
        CartVO CartVO = new CartVO();
        CartVO.setGoods_no(goodsNo);
        CartVO.setId(userId);
        CartVO.setTotal(1); // 처음 추가할 때 개수는 1로 설정
        return cartMapper.insertCartItem(CartVO);
    }

    public void removeCartItem(Long CartNo) {
    	cartMapper.deleteCartItemByCartNo(CartNo);
    }

}
