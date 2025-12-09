<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${login.gradeNo == 9 ? "사용자 리뷰 관리" : "내 리뷰보기"}</title>
    
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
    
    <link rel="stylesheet" href="/resources/css/review/list.css">

<script type="text/javascript">
$(document).ready(function() {
    $(".likeBtn").click(function() {
        const rno = $(this).data("rno");
        const $likeCountSpan = $(this).find("span");

        $.ajax({
            url: "${pageContext.request.contextPath}/review/like.do",
            type: "POST",
            data: { rno: rno },
            success: function(response) {
                const currentLikeCount = parseInt($likeCountSpan.text(), 10);
                $likeCountSpan.text(currentLikeCount + 1);
            },
            error: function() {
                alert("이미 좋아요를 누르셨습니다.");
            }
        });
    });
});
</script>

<script type="text/javascript">
   
   $(function(){
       $(".updateBtn").click(function() {
           let rno = $(this).data("rno");
           location.href = "updateForm.do?rno=" + rno;
       });
   
       $("#perPageNum").change(function(){
           $("#searchForm").submit();
       });
   
       $("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
       $("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
   });
   
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
    
    
   document.addEventListener("DOMContentLoaded", () => {
       // 버튼 페이지 처리 시작
       const cardsPerPage = 5; // 한 페이지에 표시할 리뷰 수
       let currentPage = 1; // 현재 페이지
       const reviews = document.querySelectorAll(".review"); // DOM 로드 후 선택
       const totalCards = reviews.length; // 전체 리뷰 수
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
       showPage(currentPage);
   });
</script>



</head>
<body>
   <div class="container">
    <!-- JSTL 변수를 사용하여 내 리뷰 개수 초기화 -->
    <c:set var="myReviewCount" value="0" scope="page" />

    <!-- 로그인한 사용자의 등급이 관리자(gradeNo 9)인지 확인 -->
    <c:choose>
        <c:when test="${login.gradeNo == 9}">
            <h4>사용자 리뷰 관리</h4>
        </c:when>
        <c:otherwise>
            <!-- 내 리뷰 보기 설정 -->
            <h4>내 리뷰보기</h4>
            <c:forEach var="vo" items="${list}">
                <c:if test="${vo.id == login.id}">
                    <c:set var="myReviewCount" value="${myReviewCount + 1}" scope="page" />
                </c:if>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    
        <div style="display: flex;">
            <p>${login.gradeNo == 9 ? "모든 사용자 리뷰를 관리할 수 있습니다." : "내가 쓴 리뷰를 한눈에 확인하세요!"} &nbsp;</p>
            <c:if test="${login.gradeNo != 9}">
                <span>총 리뷰수 : ${myReviewCount}</span>
            </c:if>
        </div>

        <c:if test="${empty list}">
            <h4>작성한 리뷰가 없습니다.</h4>
        </c:if>

        <c:if test="${!empty list}">
            <div class="review-container">
                <c:forEach var="vo" items="${list}">
                    <c:if test="${login.gradeNo == 9 || vo.id == login.id}">
                        <div class="review" data-goods_no="${vo.goods_no}">
                     <div class="review-left" onclick="toggleReviewText(this)">
                              <p class="review-title">${fn:split(vo.status, ',')[0]}</p>
                              <p class="product">
                        <p class="product-option">${vo.title}</p>
<%--                                   <span class="product-option">[${vo.goods_name}]</span> ${vo.title} --%>
                              <p class="review-text">${vo.content}</p>
                          </div>
                          
                          <div class="review-right">
                              <p class="reviewer">${vo.id}</p>
                              <p class="date"><fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" /></p>
                              <div class="button-group">
                                 <button type="button" class="likeBtn" data-rno="${vo.rno}">
                                     <i class="fa fa-heart"></i><span>${vo.likeCount}</span>
                                 </button>
<%--                               <c:if test="${login.gradeNo==1 }"> --%>
<%--                                    <button type="button" class="likeBtn" data-rno="${vo.rno}">좋아요 <span>${vo.likeCount}</span></button> --%>
<%--                                 </c:if> --%>
                           <div class="updel">
                                      <c:if test="${login.gradeNo==1 }">
                                           <a href="updateForm.do?perPageNum=${pageObject.perPageNum}&rno=${vo.rno}" class="updateBtn" data-rno="${vo.rno}">
                                    <i class="fa fa-pencil"></i>
                                 </a>
                                      </c:if>
                                      <form action="${pageContext.request.contextPath}/review/delete.do" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?')" style="float:right;">
                                          <input type="hidden" name="rno" value="${vo.rno}">
                                          <button type="submit" class="deleteBtn" data-rno="${vo.rno}"><i class="fa fa-trash"></i></button>
                                      </form>
                                   </div>
                                </div>
                          </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>
    </div>
    
    <!-- 페이지 내비게이션 -->
   <div class="pageNav" id="pagination"></div>
   
</body>
</html>
