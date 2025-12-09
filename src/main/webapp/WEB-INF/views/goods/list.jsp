<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트</title>
<link rel="stylesheet" href="/resources/css/goods/list.css">
<script type="text/javascript">
$(document).ready(function() {
		// 상품 상세보기 이동 (검색 아이콘 클릭)
		$(".btn-search").click(function() {
		    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
		    let goods_no = $(this).closest(".promotion-card").data("goods_no"); 
		    console.log("상품 상세보기로 이동: goods_no =", goods_no);
		    if (goods_no) {
		        // 상품 상세 페이지로 이동
		        location.href = "view.do?goods_no=" + goods_no + "&${pageObject.pageQuery}&${goodsSearchVO.searchQuery}";
		    } else {
		        console.error("goods_no가 정의되지 않았습니다.");
		    }
		});
		
		function appendCateCode() {
		    // cate_code1 값을 가져와서 URL에 추가
		    var cateCode1 = document.querySelector('input[name="cate_code1"]').value;
		    // 폼의 액션 URL을 수정
		    var form = document.getElementById('searchForm');
		    form.action = 'list.do?cate_code1=' + cateCode1;
		    return true; // 폼 제출을 계속 진행
		}		
		
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
<div class="container p-3 my-3" >
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>카테고리별 제품 보러가기</h4></div>
        <div>카테고리별 제품을 만나보세요!</div>
    </div>
    <div class="visualImage">
    <!-- 상단 이미지와 텍스트 -->
    <c:if test="${param.cate_code1==1 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/chair_visual.png)">
            <h2 class="category-title">의자</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==2 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/etc_visual.png)">
            <h2 class="category-title">소품</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==3 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/bed_visual.png)">
            <h2 class="category-title">침구</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==4 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/table_visual.png)">
            <h2 class="category-title">테이블</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==5 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/storage_visual.png)">
            <h2 class="category-title">수납</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==6 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/curtain_visual.png)">
            <h2 class="category-title">커튼</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==7 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/lug_visual.png)">
            <h2 class="category-title">러그</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==8 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/light_visual.png)">
            <h2 class="category-title">조명</h2>
        </div>
    </c:if>
    <!-- 하단 서치 폼 -->
    <form action="list.do" id="searchForm" class="visualImage-form">
    <!-- cate_code1 값을 저장할 hidden 필드 추가 -->
    <input type="hidden" name="cate_code1" value="${goodsSearchVO.cate_code1}">

    <div class="input-group mb-3">
        <input type="text" class="form-control" placeholder="상품명검색" id="goods_name"
            name="goods_name" value="${goodsSearchVO.goods_name }">
        <input type="text" class="form-control" placeholder="최저가격입력" id="min_price"
            name="min_price" value="${goodsSearchVO.min_price }">
        <input type="text" class="form-control max-price-input" placeholder="최고가격입력" id="max_price"
            name="max_price" value="${goodsSearchVO.max_price }">
    </div>
    <div class="input-group-prepend">
        <button type="submit" class="btn btn-primary">
            <i class="fa fa-search"></i>
        </button>
    </div>
</form>
</div>

<c:if test="${empty list }">
    <h4 style="text-align:center; height: 200px;">데이터가 존재하지 않습니다.</h4>
</c:if>
<c:if test="${!empty list }">
	<div class="container p-3 my-3">
    <div class="dataRow row" id="cardContainer">
        <c:forEach items="${list}" var="vo" varStatus="vs">
        <c:if test="${vs.index % 3 == 0 && vs.index != 0}">
    </div> <!-- 이전 row 닫기 -->
     <div class="dataRow row"> <!-- 새로운 row 시작 -->
            </c:if>
            <div class="col-md-4 promotion-card" data-goods_no="${vo.goods_no}">
                <div class="card">
                    <img src="${vo.image_name}" class="card-img-top">
                    <div class="overlay">
                        <button class="btn btn-wishlist" onclick="addToWishlist(${vo.goods_no})">
						    <i class="fa fa-heart"></i>
						</button>
                        <button class="btn btn-addcart" onclick="addToCartlist(${vo.goods_no})">
                        	<i class="fa fa-shopping-cart"></i>
                        </button>
                        <button class="btn btn-search"><i class="fa fa-search"></i></button>
                    </div>
                    <div class="card-body">
                        <div class="card-title">${vo.goods_name}</div>
                        <div class="simple-content">${vo.content }</div>
                        <p class="card-text">
                            <span class="original-price float-left"><fmt:formatNumber value="${vo.price}"/></span>
                            <span class="discount_rate">${vo.discount_rate}%</span>
                            <span class="sale_price float-right"><fmt:formatNumber value="${vo.sale_price}"/></span>
                        </p>
                        <div class="review_count">총 리뷰 수 ${vo.reviewCount}개</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div> <!-- 마지막 row 닫기 -->
</div>
</c:if>

<!-- 페이지 내비게이션 -->
          <div class="pageNav" id="pagination"></div>
          
<div class="buttons regBtn" style="text-align: right;">
	<c:if test="${login.gradeNo==9 }">
			<a href="writeForm.do?perPageNum="${pageObject.perPageNum } class="registerBtn">제품등록</a>
	</c:if>
</div>

<script type="text/javascript">
function addToWishlist(goods_no) {
    // AJAX 요청 보내기 (userId를 클라이언트에서 보내지 않음)
    var userId = '${login.id}'; // 이 부분이 실제로 정상적으로 로그인된 id를 담고 있는지 확인
		if (!userId) {
			$('#msgModal .modal-body').text("로그인 후 위시리스트에 추가할 수 있습니다."); // 모달 메시지 업데이트
            $('#msgModal').modal('show'); // 모달 표시
		    return;
		}
    $.ajax({
        url: '/wish/add',  // 위시리스트 추가를 처리하는 서버 경로
        type: 'POST',
        data: {
            goods_no: goods_no,  // 상품 번호만 서버로 전송
            userId : userId
        },
        success: function(response) {
        	$('#msgModal .modal-body').text("상품이 위시리스트에 추가되었습니다!"); // 모달 메시지 업데이트
            $('#msgModal').modal('show'); // 모달 표시
           loadWishList(); // 위시리스트 갱신 함수 호출 (다시 로드)   
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}
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
</script>


</body>
</html>

