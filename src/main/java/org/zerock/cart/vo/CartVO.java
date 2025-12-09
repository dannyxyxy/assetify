package org.zerock.cart.vo;

import lombok.Data;

@Data
public class CartVO {
    private Long cart_no;        // 장바구니 항목 번호
    private String id;           // 사용자 ID
    private String goods_name;   // 상품명
    private String content;      // 상품 설명
    private Integer price;       // 원래 가격
    private Integer sale_price;  // 판매 가격
    private Integer discount_rate; // 할인율
    private String image_name;   // 상품 이미지 파일명
    private Integer total;       // 장바구니 총 수량 (수량 조절 후 업데이트)
    private Long goods_no;       // 상품 번호 (goods 테이블과 연결)
    private Integer quantity;    // 수량 (갯수 증가/감소 버튼 처리 필드)
}
