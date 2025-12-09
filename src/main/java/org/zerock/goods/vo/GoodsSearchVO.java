package org.zerock.goods.vo;

import lombok.Data;

@Data
public class GoodsSearchVO {

    
    private Integer cate_code1; // 카테고리 코드 1을 String으로 변경
    private String goods_name; // 상품 이름
    private Integer min_price; // 최소 가격
    private Integer max_price; // 최대 가격

    public String getSearchQuery() {
        StringBuilder query = new StringBuilder();
        query.append("cate_code1=").append(toStr(cate_code1))
             .append("&goods_name=").append(toStr(goods_name))
             .append("&min_price=").append(toStr(min_price))
             .append("&max_price=").append(toStr(max_price));
        return query.toString();
    }

    // Null 체크를 위한 toStr 메소드
    public String toStr(Object obj) {
        return (obj == null) ? "" : obj.toString();
    }

    // 유효성 검사 메소드
    public boolean isValid() {
        // 여기에 추가적인 유효성 검사 로직을 삽입할 수 있습니다.
        if (min_price != null && max_price != null && min_price > max_price) {
            return false; // 최소 가격이 최대 가격보다 클 수 없음
        }
        
        return true; // 유효성 검사 통과
    }


}
