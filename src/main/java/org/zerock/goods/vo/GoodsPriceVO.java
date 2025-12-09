package org.zerock.goods.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsPriceVO {
	
	private Long goods_price_no;
	private Integer price;

	private Integer sale_price;
	private Integer discount_rate;
	private String delivary_charge;
	private String delivary_type;
	private Long goods_no;

	
}
