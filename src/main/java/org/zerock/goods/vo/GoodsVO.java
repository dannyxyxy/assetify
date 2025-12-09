package org.zerock.goods.vo;


import lombok.Data;

@Data
public class GoodsVO {
    // goods
    private Long goods_no;
    private String goods_name;
    private String company;
    private String goods_code;
    private String image_name;
    private String content;
    private Integer cate_code1;
    private String cate_name;
    private String category_images;

    // goods price
    private Integer price;
    private Integer sale_price;
    private Integer discount_rate;
    private String delivary_charge;

    // Add this line to define goods_price_no
    private Long goods_price_no; // Ensure this property is added
    
    private Integer reviewCount;

}

