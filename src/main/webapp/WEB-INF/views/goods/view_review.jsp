<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>




<!DOCTYPE html>
<html lang="ko">
	<div class="container">
        <!-- 리뷰 목록 -->
        <div class="review-container">
            <c:forEach var="review" items="${reviewList}">
                <div class="review">
                    <div class="review-left" onclick="toggleReviewText(this)">
                        <p class="review-title">${fn:split(review.status, ',')[0]}</p>
                        <p class="product">
                            <span class="product-option">[${vo.goods_name}]</span> ${review.title}
                        </p>
                        <p class="review-text">${review.content}</p>
                    </div>
                    <div class="review-right">
                        <p class="reviewer">${review.id}</p>
                        <p class="date"><fmt:formatDate value="${review.writeDate}" pattern="yyyy-MM-dd" /></p>
                        <button type="button" class="likeBtn" data-rno="${review.rno}">
                         <i class="fa fa-heart"></i><span>${review.likeCount}</span>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 페이지 내비게이션 -->
        <div class="pageNav" id="pagination"></div>

        <!-- 리뷰 작성 폼 -->
        <div class="review-section">
            <h4>리뷰 남기기</h4>
            <form action="${pageContext.request.contextPath}/review/write.do" method="post">
                <input type="hidden" name="goods_no" value="${vo.goods_no}">
                <div class="form-group">
                    <label for="sel1">해당제품을 평가해주세요.</label>
                    <select class="appraisal" name="status" id="sel1">
                        <option>아주 만족해요</option>
                        <option>만족해요</option>
                        <option>보통이에요</option>
                        <option>별로에요</option>
                    </select>
                </div>
                <div class="titleBox">
                    <label class="rtitle" for="rtitle">리뷰 제목</label>
                    <input class="ipt" type="text" name="title" pattern="([가-힣a-zA-Z0-9\s\W]{0,150})"
                        placeholder="제목을 입력해주세요. 한글 최대 50자, 영문 최대 90자만 입력 가능합니다." required>
                </div>
                <div>
                    <label class="rConTit" for="content">리뷰내용</label>
                    <textarea class="ipt" id="content" name="content" rows="4" placeholder="상품 구매 후기를 입력해주세요." required></textarea>
                </div>
                <div class="buttons">
                    <button type="submit" class="submit-button">등록</button>
                </div>
            </form>
        </div>
    </div>


<script type="text/javascript">
	
// 	window.addEventListener('load', function() {
// 		// URL에 #review-tab이 포함된 경우 리뷰 탭을 활성화
// 		if (window.location.hash === '#review-tab') {
// 			// 예: Bootstrap 탭 구조라면 다음과 같이 리뷰 탭을 활성화
// 			document.querySelector('#review-tab-button').click();
// 		}
// 	});
	
	function toggleReviewText(element) {
	    // 현재 상태를 토글
	    const isExpanded = element.classList.toggle('expanded');
	
	    if (isExpanded) {
	        // 확장 상태: scrollHeight로 높이 계산
	        const scrollHeight = element.scrollHeight;
	        element.style.height = scrollHeight + 'px';
	    } else {
	        // 축소 상태: 초기 높이로 복구
	        element.style.height = '4.8em'; // 2줄 기준 높이
	    }
	}
	
	$(document).ready(function() {
		$(".likeBtn").click(function() {
			const rno = $(this).data("rno");
			const $likeCountSpan = $(this).find("span");
			// 이미 좋아요를 누른 경우
			if ($(this).hasClass("liked")) {
				alert("이미 좋아요를 누르셨습니다.");
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/review/like.do",
				type : "POST",
				data : {rno : rno},
				success : function(response) {
					let currentLikeCount = parseInt(
						$likeCountSpan.text(),10);
					if (isNaN(currentLikeCount))
						currentLikeCount = 0;
					$likeCountSpan.text(currentLikeCount + 1);
					$(".likeBtn[data-rno='" + rno + "']").addClass("liked").prop("disabled", true);
				},
				error : function(response) {
					if (response.status === 401) { // 로그인 필요 응답
						alert("로그인이 필요합니다. 로그인 후 다시 시도해주세요.");
					} else {
						alert("이미 좋아요를 누르셨습니다.");// "이미 좋아요를 누르셨습니다." 등의 다른 오류 메시지
					}
				}
			});
		});
	});
	
	// 버튼 페이지 처리 시작
	const cardsPerPage = 5; // 한 페이지에 표시할 리뷰 수
	let currentPage = 1; // 현재 페이지
	const totalCards = document.querySelectorAll(".review").length; // 전체 리뷰 수
	const totalPages = Math.ceil(totalCards / cardsPerPage); // 총 페이지 수
	const maxPageButtons = 10; // 한 번에 표시할 최대 페이지 버튼 수

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

	// 현재 페이지의 리뷰를 표시
	function showPage(page) {
	    const reviews = document.querySelectorAll(".review");

	    // 모든 리뷰 숨기기
	    reviews.forEach((review) => (review.style.display = "none"));

	    // 현재 페이지의 리뷰만 표시
	    const startIndex = (page - 1) * cardsPerPage;
	    const endIndex = page * cardsPerPage;
	    for (let i = startIndex; i < endIndex && i < reviews.length; i++) {
	        reviews[i].style.display = "flex"; // 스타일 충돌 방지: 'flex'로 설정
	    }

	    // 페이지 버튼 업데이트
	    renderPagination();
	}

	// 초기 로드 시 첫 페이지 표시
	document.addEventListener("DOMContentLoaded", () => {
	    showPage(currentPage);
	});
	// 버튼 페이지 처리 끝
	
</script>
</html>
