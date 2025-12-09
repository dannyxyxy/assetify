package org.zerock.cart.service;

import java.util.List;


import org.zerock.cart.vo.CartVO;


public interface CartService {

	public List<CartVO> getCartList(String userId);
	public boolean addCartItem(Long goodsNo, String userId);
	public void removeCartItem(Long cartNo);
	
}
