package org.zerock.cart.vo;

import lombok.Data;

@Data
public class CartItemVO {
	private Long cart_no;
    private Integer quantity;
    private String id;
}
