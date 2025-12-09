<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위시리스트</title>
<link rel="stylesheet" href="/resources/css/wish/list.css">
<script type="text/javascript">
//장바구니에 상품을 추가하는 함수
function addToCartlist(goods_no) {
    // AJAX 요청 보내기 (userId를 클라이언트에서 보내지 않음)
    var userId = '${login.id}'; // 이 부분이 실제로 정상적으로 로그인된 id를 담고 있는지 확인
		if (!userId) {
			$('#msgModal .modal-body').text("로그인 후 장바구니에 추가할 수 있습니다."); // 모달 메시지 업데이트
            $('#msgModal').modal('show'); // 모달 표시
		    return;
		}
    $.ajax({
        url: '/cart/add',  // 위시리스트 추가를 처리하는 서버 경로
        type: 'POST',
        data: {
            goods_no: goods_no,  // 상품 번호만 서버로 전송
            userId : userId
        },
        success: function(response) {
        	$('#msgModal .modal-body').text("상품이 장바구니에 추가되었습니다!"); // 모달 메시지 업데이트
            $('#msgModal').modal('show'); // 모달 표시
           loadCartList(); // 위시리스트 갱신 함수 호출 (다시 로드)   
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}

function removeFromWishlist(wish_no) {
    // AJAX 요청을 통해 wish_no만 전달하여 해당 상품 삭제
    $.ajax({
        url: '/wish/remove', // 상품 삭제를 처리하는 URL
        type: 'POST',
        data: { wish_no: wish_no }, // wish_no만 넘김
        success: function(response) {
        	$('#msgModal .modal-body').text("위시리스트에서 상품이 제거되었습니다."); // 모달 메시지 업데이트
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
	$(function(){
		$(".btn-search").click(function() {
		    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
		    let goods_no = $(this).closest(".promotion-card").data("goods_no"); 
		    console.log("상품 상세보기로 이동: goods_no =", goods_no);
		    if (goods_no) {
		        // 상품 상세 페이지로 이동 (불필요한 파라미터 제거)
		        location.href = "/goods/view.do?goods_no=" + goods_no; 
		    } else {
		        console.error("goods_no가 정의되지 않았습니다.");
		    }
		});
		
	});
});

document.addEventListener("DOMContentLoaded", () => {
    const cardsPerPage = 6; // 한 페이지당 표시할 카드 수
    let currentPage = 1; // 현재 페이지
    const cards = document.querySelectorAll(".promotion-card"); // 모든 카드 선택
    const totalCards = cards.length; // 전체 카드 개수
    const totalPages = Math.ceil(totalCards / cardsPerPage); // 총 페이지 수
    const maxPageButtons = 5; // 한 번에 표시할 최대 페이지 버튼 수

    // 페이지 버튼 생성 및 렌더링
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
                currentPage--;
                showPage(currentPage);
            }
        };
        pagination.appendChild(prevBtn);

        // 숫자 버튼 생성
        const startPage = Math.floor((currentPage - 1) / maxPageButtons) * maxPageButtons + 1;
        const endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

        for (let i = startPage; i <= endPage; i++) {
            const pageBtn = document.createElement("a");
            pageBtn.href = "#";
            pageBtn.textContent = i;
            pageBtn.className = currentPage === i ? "active" : "";
            pageBtn.onclick = (e) => {
                e.preventDefault();
                currentPage = i;
                showPage(currentPage);
            };
            pagination.appendChild(pageBtn);
        }

        // 다음 그룹으로 이동 버튼
        if (endPage < totalPages) {
            const moreBtn = document.createElement("a");
            moreBtn.href = "#";
            moreBtn.innerHTML = "...";
            moreBtn.onclick = (e) => {
                e.preventDefault();
                currentPage = endPage + 1;
                showPage(currentPage);
            };
            pagination.appendChild(moreBtn);
        }

        // 다음 버튼
        const nextBtn = document.createElement("a");
        nextBtn.href = "#";
        nextBtn.innerHTML = "&raquo;";
        nextBtn.className = currentPage === totalPages ? "disabled" : "";
        nextBtn.onclick = (e) => {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        };
        pagination.appendChild(nextBtn);
    }

    // 현재 페이지의 카드만 표시
    function showPage(page) {
        // 모든 카드 숨기기
        cards.forEach((card) => (card.style.display = "none"));

        // 현재 페이지의 카드만 표시
        const startIndex = (page - 1) * cardsPerPage;
        const endIndex = page * cardsPerPage;
        for (let i = startIndex; i < endIndex && i < totalCards; i++) {
            cards[i].style.display = "block"; // 카드 보이기
        }

        // 페이지 버튼 업데이트
        renderPagination();
    }

    // 초기 로드 시 첫 페이지 표시
    showPage(currentPage);
});
</script>
</head>
<body>

<div class="container p-3 my-3">
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>위시리스트</h4></div>
        <div>${login.id }님의 위시리스트로 등록하신 상품들입니다(${total})</div>
    </div>
    <div id="wishlist-container">
            <c:if test="${empty wishList}">
                <p>위시리스트에 추가된 상품이 없습니다.</p>
            </c:if>
	 <!-- 위시리스트 아이템 리스트 -->
    <div class="row">
        <c:forEach items="${wishList}" var="wish">
            <div class="col-md-4 promotion-card" data-goods_no="${wish.goods_no}">
            	<div class="card">
                    <img src="${wish.image_name}" class="card-img-top">
                    <div class="overlay">
                         <button class="btn btn-remove" onclick="removeFromWishlist(${wish.wish_no})">
                         	<i class="fa fa-trash"></i>
                         </button>
                        <button class="btn btn-addcart" onclick="addToCartlist(${wish.goods_no})">
                        	<i class="fa fa-shopping-cart"></i>
                        </button>
                        <button class="btn btn-search"><i class="fa fa-search"></i></button>
                    </div>
                    <div class="card-body">
                        <div class="card-title">${wish.goods_name}</div>
                        <div class="simple-content">${wish.content }</div>
                        <p class="card-text">
                            <span class="original-price float-left"><fmt:formatNumber value="${wish.price}"/></span>
                            <span class="discount_rate">${wish.discount_rate}%</span>
                            <span class="sale_price float-right"><fmt:formatNumber value="${wish.sale_price}"/></span>
                        </p>
                        <div class="review_count">총 리뷰 수 8개</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
	
	<!-- 페이지 내비게이션 -->
          <div class="pageNav" id="pagination"></div>
    
</div>
</body>
</html>

