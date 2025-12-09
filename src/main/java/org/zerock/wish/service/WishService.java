package org.zerock.wish.service;

import java.util.List;
import org.zerock.wish.vo.WishVO;

public interface WishService {
	public List<WishVO> getWishList(String userId);
	public boolean addWishItem(Long goodsNo, String userId);
	public void removeWishItem(Long wishNo);
}
