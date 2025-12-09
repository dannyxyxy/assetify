package org.zerock.wish.vo;

import lombok.Data;

@Data
public class WishVO {
	
	private Long wish_no;
	private String id;
    private String goods_name;
    private String content;
    private Integer price;
    private Integer sale_price;
    private Integer discount_rate;
    private String image_name;
    private Integer total;
    private Long goods_no;
	
}
