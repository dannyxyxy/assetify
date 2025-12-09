<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>문의글 리스트</title>
<link rel="stylesheet" href="/resources/css/qna/list.css" />
</head>
<body>
	<div class="container">
    <h4>나의 고객문의</h4>
    <p>문의사항을 작성해주세요.</p>
    
    <c:choose>
        <c:when test="${not empty list}">
            <c:forEach items="${list}" var="vo">
                	<div class="card cart-item-card flex-row" data-no="${vo.no}">
				        <!-- Left section: Product Image -->
				        <div class="cart-image-wrapper">
				            <img src="${vo.image_name}" class="img-fluid cart-image">
				        </div>
				        <!-- Right section: Product Details -->
				        <div class="card-body d-flex flex-column justify-content-between">
				            <div>
				                <!-- Product Title -->
				                <div class="card-title">${vo.title}<span class="goods_code" style="float:right; margin-top:5px;">[${vo.goods_code}]</span>
				                	<span style="float:right; margin-right: 5px; font-size: 14px; color:#888; margin-top:5px;">${vo.goods_name}</span></div>
				                <div style="margin-left:15px;">
				                	
				                </div>
				                
				                <!-- Product Content Description -->
				                <p class="simple-content">${vo.content}</p>
				                <!-- Price and Discount -->
				                <div class="section">
				                    
				                    <span class="id">${vo.id}</span> 
				                    <span class="writeDate"><fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" /></span>        
				                </div>
				            </div>
				        </div>
				    </div>
            </c:forEach>       
        </c:when>
        
        <c:otherwise>
            <p>문의사항이 없습니다.</p>
        </c:otherwise>
    </c:choose>
    
    <!-- 페이지 내비게이션 -->
    <div class="pageNav" id="pagination"></div>
    
	    <div class="btnBox">
	        <a href="writeForm.do" class="btn writeBtn" style="margin-left: auto;">글쓰기</a>
	    </div>
	</div>
	<SCRIPT type="text/javascript">
	$(".cart-item-card").click(function() {
        let no = $(this).data("no");
        if (no) {
            location = "view.do?no=" + no;
        } else {
            console.error("no가 정의되지 않았습니다.");
        }
    });
	
	document.addEventListener("DOMContentLoaded", () => {
	    console.log("DOMContentLoaded 실행됨");

	    const cards = document.querySelectorAll(".cart-item-card");
	    console.log("선택된 카드들:", cards);
	    console.log("총 카드 수:", cards.length);

	    if (cards.length === 0) {
	        console.error("카드가 선택되지 않았습니다. .cart-item-card 클래스 확인 필요");
	        return;
	    }

	    const cardsPerPage = 5; // 한 페이지에 표시할 카드 수
	    let currentPage = 1; // 현재 페이지
	    const totalCards = cards.length; // 전체 카드 개수
	    const totalPages = Math.ceil(totalCards / cardsPerPage); // 총 페이지 수
	    const maxPageButtons = 10; // 한 번에 표시할 최대 페이지 버튼 수

	    console.log("총 카드 수:", totalCards);
	    console.log("총 페이지 수:", totalPages);

	    // 현재 페이지의 카드만 표시
	    function showPage(page) {
	        if (!page || isNaN(page)) {
	            console.error("잘못된 페이지 값:", page);
	            page = 1; // 기본값 설정
	        }

	        console.log(`showPage 함수 호출됨. 현재 페이지: ${page}`);
	        if (page < 1) page = 1;
	        if (page > totalPages) page = totalPages;

	        // 모든 카드 숨기기
	        cards.forEach((card, index) => {
	            card.style.display = "none";
	            console.log(`카드 ${index + 1} 숨김`);
	        });

	        // 현재 페이지의 카드만 표시
	        const startIndex = (page - 1) * cardsPerPage;
	        const endIndex = page * cardsPerPage;
	        console.log(`현재 페이지: ${page}, 시작 인덱스: ${startIndex}, 끝 인덱스: ${endIndex}`);
	        for (let i = startIndex; i < endIndex && i < totalCards; i++) {
	            cards[i].style.display = "block";
	            console.log(`카드 ${i + 1} 보임`);
	        }

	        currentPage = page;
	        renderPagination();
	    }

	    // 페이지네비게이션 렌더링
	    function renderPagination() {
	        console.log("renderPagination 함수 호출됨");
	        const pagination = document.getElementById("pagination");
	        if (!pagination) {
	            console.error("#pagination 요소를 찾을 수 없습니다.");
	            return;
	        }

	        pagination.innerHTML = ""; // 기존 버튼 제거
	        console.log("페이지네비게이션 초기화 완료");

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
	        const startPage = Math.floor((currentPage - 1) / maxPageButtons) * maxPageButtons + 1 || 1;
	        const endPage = Math.min(startPage + maxPageButtons - 1, totalPages || 1);
	        console.log(`시작 페이지: ${startPage}, 끝 페이지: ${endPage}`);

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
	    console.log("첫 페이지 표시 호출");
	    showPage(currentPage);
	});



	</SCRIPT>
</body>
</html>
