package org.zerock.cart.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.zerock.cart.vo.CartVO;

@Mapper
public interface CartMapper {

	 // 사용자의 위시리스트 조회
    List<CartVO> getCartListByUserId(@Param("id") String id);

    // 위시리스트 상품 추가
    boolean insertCartItem(CartVO cartVO);

	void deleteCartItemByCartNo(Long cartNo);
	
	
}

