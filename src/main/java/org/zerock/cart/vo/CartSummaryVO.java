package org.zerock.cart.vo;

import lombok.Data;

@Data
public class CartSummaryVO {
	
	private Integer totalQuantity;  // 총 수량
    private Integer totalPrice;     // 총 금액
	
}
