<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <script src="https://js.tosspayments.com/v2/standard"></script>
<title>장바구니리스트</title>

<link rel="stylesheet" href="/resources/css/cart/list.css">
<script type="text/javascript">
//장바구니 총 수량 및 총 가격 계산 함수
	function calculateCartSummary() {
		 let totalQuantity = 0;
		 let totalPrice = 0;
		
		 // 각 항목의 수량과 가격을 합산
		 $('.item-quantity').each(function () {
		     const quantity = parseInt($(this).val()) || 0;
		     const price = parseFloat($(this).data('price')) || 0;
		     const itemTotalPrice = quantity * price;
		
		     totalQuantity += quantity;
		     totalPrice += itemTotalPrice;
		 });
		
		 // 총 수량 및 총 가격 업데이트
		 $('[data-summary="totalQuantity"]').text(totalQuantity); // 총 수량
		 $('[data-summary="totalPrice"]').text(totalPrice.toLocaleString()); // 총 가격
		
		 // 여러 위치에 업데이트
		 $('.totalPricePlaceholder').text(totalPrice.toLocaleString());
		}
		
	document.addEventListener("DOMContentLoaded", () => {
		calculateCartSummary();
		
	    $('.item-quantity').on('input', function() {
	        calculateCartSummary();
	    });
		
	       const cardsPerPage = 5; // 한 페이지에 표시할 카드 수
	       let currentPage = 1; // 현재 페이지
	       const cards = document.querySelectorAll(".cart-item-card"); // 모든 카드 선택
	       const totalCards = cards.length; // 전체 카드 개수
	       const totalPages = Math.ceil(totalCards / cardsPerPage); // 총 페이지 수
	       const maxPageButtons = 10; // 한 번에 표시할 최대 페이지 버튼 수

	       // 현재 페이지의 카드만 표시
	       function showPage(page) {
	           if (page < 1) page = 1;
	           if (page > totalPages) page = totalPages;

	           // 모든 카드 숨기기
	           cards.forEach((card) => (card.style.display = "none"));

	           // 현재 페이지의 카드만 표시
	           const startIndex = (page - 1) * cardsPerPage;
	           const endIndex = page * cardsPerPage;
	           for (let i = startIndex; i < endIndex && i < totalCards; i++) {
	               cards[i].style.display = "block"; // 카드 보이기
	           }

	           currentPage = page; // 현재 페이지 업데이트
	           renderPagination(); // 페이지 버튼 업데이트
	       }

	       // 페이지네비게이션 렌더링
	       function renderPagination() {
	           const pagination = document.getElementById("pagination");
	           pagination.innerHTML = ""; // 기존 버튼 제거

	           // 이전 버튼
	           const prevBtn = document.createElement("a");
	           prevBtn.href = "#";
	           prevBtn.innerHTML = "&laquo;";
	           prevBtn.className = currentPage === 1 ? "disabled" : "";
	           prevBtn.onclick = (e) => {
	               e.preventDefault();
	               if (currentPage > 1) {
	                   showPage(currentPage - 1);
	               }
	           };
	           pagination.appendChild(prevBtn);

	           // 시작 페이지와 끝 페이지 계산
	           const startPage = Math.floor((currentPage - 1) / maxPageButtons) * maxPageButtons + 1;
	           const endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

	           // 숫자 버튼 생성
	           for (let i = startPage; i <= endPage; i++) {
	               const pageBtn = document.createElement("a");
	               pageBtn.href = "#";
	               pageBtn.textContent = i;
	               pageBtn.className = i === currentPage ? "active" : "";
	               pageBtn.onclick = (e) => {
	                   e.preventDefault();
	                   showPage(i);
	               };
	               pagination.appendChild(pageBtn);
	           }

	           // 다음 버튼
	           const nextBtn = document.createElement("a");
	           nextBtn.href = "#";
	           nextBtn.innerHTML = "&raquo;";
	           nextBtn.className = currentPage === totalPages ? "disabled" : "";
	           nextBtn.onclick = (e) => {
	               e.preventDefault();
	               if (currentPage < totalPages) {
	                   showPage(currentPage + 1);
	               }
	           };
	           pagination.appendChild(nextBtn);
	       }

	       // 초기 로드 시 첫 페이지 표시
	       showPage(currentPage);
	   });
	
	
	
	function removeFromCartlist(cart_no) {
	    // AJAX 요청을 통해 wish_no만 전달하여 해당 상품 삭제
	    $.ajax({
	        url: '/cart/remove', // 상품 삭제를 처리하는 URL
	        type: 'POST',
	        data: { cart_no: cart_no }, // wish_no만 넘김
	        success: function(response) {
	        	$('#msgModal .modal-body').text("장바구니에서 상품이 제거되었습니다."); // 모달 메시지 업데이트
	            $('#msgModal').modal('show'); // 모달 표시
	         // 모달이 표시된 후 2초 후 새로고침
	            setTimeout(function() {
	                location.reload(); // 페이지 새로 고침
	            }, 1000); // 1000ms = 1초
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패:", error);
	            alert("서버와의 연결에 문제가 발생했습니다.");
	        }
	    });
	}
	$(function(){		
			$(".btn-search").click(function() {
			    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
			    let goods_no = $(this).closest(".cart-item-card").data("goods_no"); 
			    console.log("상품 상세보기로 이동: goods_no =", goods_no);
			    if (goods_no) {
			        // 상품 상세 페이지로 이동 (불필요한 파라미터 제거)
			        location.href = "/goods/view.do?goods_no=" + goods_no; 
			    } else {
			        console.error("goods_no가 정의되지 않았습니다.");
			    }
			});
	});
</script>
</head>
<body>
<div class="container p-3 my-3">
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>장바구니</h4></div>
        <div style="margin-bottom:50px;">${login.id }님의 장바구니에 등록하신 상품들입니다(${total})</div> 
    </div>
    <div id="cartlist-container">
            <c:if test="${empty cartList}">
                <p>장바구니에 추가된 상품이 없습니다.</p>
            </c:if>
	 <!-- 위시리스트 아이템 리스트 -->
    <div class="row">
        <c:forEach items="${cartList}" var="cart">
		    <div class="card cart-item-card flex-row" data-goods_no="${cart.goods_no}">
		        <!-- Left section: Product Image -->
		        <div class="cart-image-wrapper">
		            <img src="${cart.image_name}" class="img-fluid cart-image">
		        </div>
		        <!-- Right section: Product Details -->
		        <div class="card-body d-flex flex-column justify-content-between">
		            <div>
		                <!-- Product Title -->
		                <h5 class="card-title">${cart.goods_name}</h5>
		                <!-- Product Content Description -->
		                <p class="simple-content">${cart.content}</p>
		                <!-- Price and Discount -->
		                <div class="price-section">
		                    <span class="original-price"><fmt:formatNumber value="${cart.price}"/></span>
		                    <span class="discount-rate">${cart.discount_rate}%</span>
		                    <span class="sale-price"><fmt:formatNumber value="${cart.sale_price}"/></span>
			                <span class="total-adjust float-right">
							    <input type="number" class="total-input item-quantity"
							     value="1" min="1" data-price="${cart.sale_price}">
							</span>
		                </div>
		            </div>
		            <!-- Action Buttons -->
		            <div class="overlay">
		                <button class="btn btn-remove" onclick="removeFromCartlist(${cart.cart_no})"> 
		                   <i class="fa fa-trash"></i> 
		                </button>
		                <button class="btn btn-search"><i class="fa fa-search"></i></button> 
		            </div> 
		        </div>
		    </div>
        </c:forEach>
    </div>
    <!-- 페이지 내비게이션 -->
    <div class="pageNav" id="pagination"></div>
    
    <!-- 장바구니 총합 -->
	<h4 style="margin-top:50px;">결제내역</h4>
	<div class="cart-summary card mt-4 p-4 shadow-sm" style="border-radius: 10px; border: none;">
	<table class="table table-borderless">
    <thead>
      <tr>
        <th>선택된 수량</th>
        <th>선택된 금액</th>       
        <th></th>
        <th>배송비</th>        
        <th>총 결제금액</th>
        <th></th>     
      </tr>
    </thead>
    <tbody>
      <tr>
        <td data-summary="totalQuantity"></td>
        <td data-summary="totalPrice"></td>
        <td><i class="fa fa-plus"></i></td>       
        <td id="delivary_charge">무료배송(설치비용별도)</td>      
        <td class="totalPricePlaceholder"></td>
        <td><button class="buy-btn" onclick="requestPayment()">결제하기</button></td>
      </tr>
    </tbody>
  </table>
  </div> 
</div>
</div>
 <script>
 
	//첫 번째 상품의 goods_name 추출
	 function getFirstGoodsName() {
	     // 첫 번째 상품 카드의 제목 (goods_name) 요소를 찾음
	     const firstGoodsNameElement = document.querySelector(".cart-item-card .card-title");
	     if (firstGoodsNameElement) {
	         return firstGoodsNameElement.textContent.trim(); // 텍스트 내용 반환
	     } else {
	         console.error("첫 번째 상품의 goods_name을 찾을 수 없습니다.");
	         return null;
	     }
	 }
	
	 // 예시로 콘솔에 출력
	 const firstGoodsName = getFirstGoodsName();
	 console.log("첫 번째 상품 이름:", firstGoodsName);
	 
      // ------  SDK 초기화 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
      const clientKey = "test_ck_24xLea5zVA9mANkp5xLKVQAMYNwW";
      const customerKey = "pk1F4A-tjLiMEd3pVfZtp";
      const tossPayments = TossPayments(clientKey);
      // 회원 결제
      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
      const payment = tossPayments.payment({ customerKey });
      // 비회원 결제
      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})

      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
      async function requestPayment() {
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        // 총 가격 값 추출
	    const totalPrice = parseFloat($('[data-summary="totalPrice"]').text().replace(/,/g, '')) || 0;
	    if (totalPrice <= 0) {
	        alert("결제할 금액이 없습니다.");
	        return;
	    }
        await payment.requestPayment({
          method: "CARD", // 카드 결제
          amount: {
            currency: "KRW",
            value: totalPrice,
          },
          orderId: "mtEYOGQ1ZXssCimYUjkBO", // 고유 주분번호
          orderName: firstGoodsName + " 외 ${total-1}개",
          successUrl: window.location.origin + "/success", // 결제 요청이 성공하면 리다이렉트되는 URL
          failUrl: window.location.origin + "/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
          customerEmail: "${login.email}",
          customerName: "${login.name}",
          customerMobilePhone: "01012341234",
          // 카드 결제에 필요한 정보
          card: {
            useEscrow: false,
            flowMode: "DEFAULT", // 통합결제창 여는 옵션
            useCardPoint: false,
            useAppCardOnly: false,
          },
        });
      }
    </script>
</body>
</html>

