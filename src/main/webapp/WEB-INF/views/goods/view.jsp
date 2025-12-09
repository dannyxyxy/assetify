<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세페이지</title>
<link rel="stylesheet" href="/resources/css/goods/view.css">
<link rel="stylesheet" href="/resources/css/goods/view_detail.css">
<link rel="stylesheet" href="/resources/css/goods/view_review.css">

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
	
	
	
	// top버튼 클릭시 html 최상단으로 화면전환
    document.addEventListener("DOMContentLoaded", function() {
        // 스크롤 위치에 따라 버튼 보이기
        window.onscroll = function() {
            const topButton = document.getElementById("topBtn");
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                topButton.style.display = "block";
            } else {
                topButton.style.display = "none";
            }
        };
        // 'Top' 버튼 클릭 시 상단으로 스크롤 이동
        document.getElementById("topBtn").onclick = function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        };
    });
	</script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50">
	<div class="container">
		<div class="row">
			<div class="col-md-6 bigImg">
			    <div id="bigImageDiv" class="img-thumbnail" style="width: 600px; height: 600px;">
			        <img id="bigImage" src="${vo.image_name}" style="width: 100%; height: 100%;">
			    </div>
			    <div id="smallImageDiv" style="display: flex; align-items: center; overflow-x: auto; margin-top: 10px;">
			        <div style="display: flex; gap: 10px;">
			            <c:if test="${!empty imageList}">
			                <c:forEach items="${imageList}" var="imageVO">
			                    <img src="${imageVO.goods_img_name}" class="img-thumbnail smallImage" style="width: 100px; height: 100px; object-fit: cover; cursor: pointer;">
			                </c:forEach>
			            </c:if>
			        </div>
			    </div>
			</div>
			<div class="col-md-6 imgContent" id="goodsDetailDiv">
				<p style="font-size: 12px; color: #999; margin-bottom: -1px;">카테고리 > ${vo.cate_name}</p>
				<div  style="">
					<strong class="tit" style="font-size: 32px;">${vo.goods_name }</strong>
				</div>
				<p style="color: #ccc; width: 100px;">${vo.goods_code }</p>
				<div class="lBox">
					<div class="summary">상품 요약정보</div>
					<div>정가</div>
					<div><span style="font-weight: 900;">판매가</span></div>
					<div>제조사</div>
					<div>배송방법</div>
					<div>배송비</div>
				</div>
				<div class="rBox">
					<div class="summary2" style="margin-top: 0;">${vo.content }</div>
					<div><fmt:formatNumber value="${vo.price}"/></div>
					<div><span style="font-weight: 900;"><fmt:formatNumber value="${vo.sale_price}"/></span></div>
					<div>${vo.company }</div>
					<div>택배배송</div>
					<div>${vo.delivary_charge }</div>
				</div>
				<div class="bBox">
					<img class="bBoxImg" src="${vo.image_name }">
					<div class="bBoxTxt">
						<span>${vo.goods_name }</span><br><span><fmt:formatNumber value="${vo.sale_price}"/>원</span>
					</div>
				</div>
				<div class="add">
					<button class="btn btn-addcart" onclick="addToCartlist(${vo.goods_no})">ADD CART</button>
					<button class="btn btn-wishlist" onclick="addToWishlist(${vo.goods_no})">ADD WISH</button>
					<button class="btn btn-addcart" style="background-color:#333; color:#FFF;" onclick="addToCartlist(${vo.goods_no});
					 window.location.href='/cart/list.do?id=${login.id}';">구매하기</button>
				</div>
				<div class="manage">
					<c:if test="${login.gradeNo==9 }">
						<a class="btn editBtn" href="updateForm.do?goods_no=${vo.goods_no }">제품 수정</a>
						<form action="${pageContext.request.contextPath}/goods/delete.do" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
						    <input type="hidden" name="goods_no" value="${vo.goods_no}">
						    <button type="submit" class="btn deleteBtn">제품 삭제</button>
						</form>
					</c:if>
				</div>
			</div>
			</div>
			
		<nav class="navbar navbar-expand-sm">  
		  <ul class="navbar-nav">
		    <li class="nav-item">
		      <a class="nav-link" href="#section1">상세보기</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#section2">리뷰보기</a>
		    </li>
		    
		  </ul>
		</nav>

<div id="section1" class="container-fluid" style="padding-top:50px;padding-bottom:50px">
  <h4>제품 상세보기</h4>
  	<jsp:include page="view_detail.jsp"></jsp:include>
</div>
<div id="section2" class="container-fluid" style="padding-top:50px;padding-bottom:50px;border-top:0.5px solid #e0e0e0;">
  <h4>제품 리뷰보기</h4>
  	<jsp:include page="view_review.jsp"></jsp:include>
</div>
</div>
<!-- 'Top' 버튼 HTML -->
<button id="topBtn" title="Go to top">Top</button>
<script type="text/javascript">
//smallImageDiv 내에 있는 img 요소에 클릭 이벤트를 연결
$("#smallImageDiv").on("click", "img", function(){
    $("#bigImageDiv img").attr("src", $(this).attr("src"));
});
</script>
</body>
</html>