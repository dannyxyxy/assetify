package org.zerock.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.vo.LoginVO;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.zerock.cart.service.CartService;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.CartSummaryVO;
import org.zerock.cart.vo.CartVO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart")
public class CartController {

    @Autowired
    @Qualifier("cartServiceImpl")
    private CartService service;
    
 // 로그인된 사용자의 위시리스트를 가져오는 메서드
    @GetMapping("/list")
    public String getCartList(@RequestParam("id") String userId, Model model) {
        List<CartVO> cartList = service.getCartList(userId);
        int total = cartList.size(); // 위시리스트에 담긴 상품 수
     // 예시로 장바구니 총 수량과 총 가격 계산
        model.addAttribute("cartList", cartList);
        model.addAttribute("total", total); // 총 상품 수를 모델에 추가
        // Redirect to cartList.jsp with id parameter
        return "cart/list";
    }

    // 위시리스트에 상품을 추가하는 메서드
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addcartItem(HttpSession session,
                                          @RequestParam("goods_no") Long goodsNo, 
                                          @RequestParam("userId") String userId) {
        // 로그인 정보 확인
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        // 로그인되지 않은 상태일 경우
        if (loginVO == null || !loginVO.getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                                 .body(Map.of("success", false, "message", "로그인된 사용자만 위시리스트에 상품을 추가할 수 있습니다."));
        }

        // 위시리스트에 상품 추가
        boolean result = service.addCartItem(goodsNo, userId);

        // 결과 반환
        if (result) {
            return ResponseEntity.ok(Map.of("success", true, "message", "위시리스트에 상품이 추가되었습니다."));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("success", false, "message", "상품 추가에 실패했습니다."));
        }
    }

    @PostMapping("/remove")
    public ResponseEntity<String> removeCartItem(@RequestParam("cart_no") Long cartNo) {
        try {
            // 서비스 계층에서 cart_no를 이용해 해당 상품을 삭제
            service.removeCartItem(cartNo);
            return ResponseEntity.ok("위시리스트에서 상품이 제거되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("위시리스트 항목 삭제 중 오류가 발생했습니다.");
        }
    }
    
   
    
}
