<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
   xmlns:f="http://java.sun.com/jsf/core"
   xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>adminPage</title>

<link rel="stylesheet" href="/resources/css/member/adminPage.css">

<script>
document.addEventListener("DOMContentLoaded", () => {
    // 한 페이지에 표시할 멤버 수
    const cardsPerPage = 10; 
    let currentPage = 1; 
    const members = Array.from(document.querySelectorAll(".member-row")); // 모든 멤버 행 선택
    const totalCards = members.length; // 전체 멤버 수
    const totalPages = Math.ceil(totalCards / cardsPerPage); // 총 페이지 수
    const maxPageButtons = 10; // 한 번에 보여줄 페이지 버튼 수

    console.log("전체 멤버 수:", totalCards); // 디버깅: 전체 멤버 수 확인
    console.log("총 페이지 수:", totalPages); // 디버깅: 총 페이지 수 확인

    // 페이지 버튼 생성 및 렌더링
    function renderPagination() {
        const pagination = document.getElementById("pagination");
        pagination.innerHTML = ""; // 기존 버튼 제거

        // 이전 버튼
        const prevBtn = document.createElement("a");
        prevBtn.href = "#";
        prevBtn.innerHTML = "&laquo;";
        prevBtn.className = currentPage === 1 ? "disabled" : "";
        prevBtn.addEventListener("click", (e) => {
            e.preventDefault();
            if (currentPage > 1) {
                showPage(currentPage - 1);
            }
        });
        pagination.appendChild(prevBtn);

        // 시작 페이지와 끝 페이지 계산
        const startPage = Math.floor((currentPage - 1) / maxPageButtons) * maxPageButtons + 1;
        const endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

        // 이전 그룹으로 이동 버튼 (startPage > 1이면 표시)
        if (startPage > 1) {
            const morePrev = document.createElement("a");
            morePrev.href = "#";
            morePrev.innerHTML = "...";
            morePrev.addEventListener("click", (e) => {
                e.preventDefault();
                showPage(startPage - 1); // 이전 그룹의 마지막 페이지로 이동
            });
            pagination.appendChild(morePrev);
        }

        // 숫자 버튼 생성
        for (let i = startPage; i <= endPage; i++) {
            const pageBtn = document.createElement("a");
            pageBtn.href = "#";
            pageBtn.textContent = i;
            pageBtn.className = i === currentPage ? "active" : "";
            pageBtn.addEventListener("click", (e) => {
                e.preventDefault();
                showPage(i);
            });
            pagination.appendChild(pageBtn);
        }

        // 다음 그룹으로 이동 버튼 (endPage < totalPages이면 표시)
        if (endPage < totalPages) {
            const moreNext = document.createElement("a");
            moreNext.href = "#";
            moreNext.innerHTML = "...";
            moreNext.addEventListener("click", (e) => {
                e.preventDefault();
                showPage(endPage + 1); // 다음 그룹의 첫 번째 페이지로 이동
            });
            pagination.appendChild(moreNext);
        }

        // 다음 버튼
        const nextBtn = document.createElement("a");
        nextBtn.href = "#";
        nextBtn.innerHTML = "&raquo;";
        nextBtn.className = currentPage === totalPages ? "disabled" : "";
        nextBtn.addEventListener("click", (e) => {
            e.preventDefault();
            if (currentPage < totalPages) {
                showPage(currentPage + 1);
            }
        });
        pagination.appendChild(nextBtn);
    }

    // 현재 페이지의 멤버를 표시
    function showPage(page) {
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        // 모든 멤버 숨기기
        members.forEach((member) => {
            member.style.display = "none";
        });

        // 현재 페이지의 멤버만 표시
        const startIndex = (page - 1) * cardsPerPage;
        const endIndex = page * cardsPerPage;
        for (let i = startIndex; i < endIndex && i < totalCards; i++) {
            members[i].style.display = "grid"; // 'grid'를 유지하여 스타일 깨지지 않음
        }

        currentPage = page; // 현재 페이지 업데이트
        renderPagination(); // 페이지 버튼 업데이트
    }

    // 초기 로드 시 첫 페이지 표시
    showPage(currentPage);
});

</script>


</head>
<body>
   <div class="container">
      <div class="misHeader">
         <h4>회원 리스트 관리</h4>
         <p>관리자용 회원관리 리스트</p>
      </div>

      <div class="misTitleBody">
         <div>
            <!-- <h2>공백</h2> -->
         </div>
         <div class="profileSpace">
            <p>프로필</p>
         </div>
         <div class="idSpace">
            <p>아이디</p>
         </div>
         <div class="nameSpace">
            <p>이름</p>
         </div>
         <div class="birthSpace">
            <p>생년월일</p>
         </div>
         <div class="telSpace">
            <p>연락처</p>
         </div>
         <div class="gradeSpace">
            <p>등급</p>
         </div>
         <div class="statusSpace">
            <p>상태</p>
         </div>
         <div>
            <!-- <h2>공백</h2> -->
         </div>
      </div>

      <c:forEach items="${list}" var="vo">
         <div class="member-row" style="border: none;">
            <form action="/member/updateStatus" method="post" class="styled-form" onclick="setActiveForm(this)">
               <div class="misBody">
                  <input type="hidden" name="id" value="${vo.id}" />
                  <div>
                     <!-- <h2>공백</h2> -->
                  </div>
                  <div class="profileSpace">
                     <c:if test="${!empty vo.photo}">
                        <img src="${vo.photo}" class="rounded-circle" alt="프로필 이미지" />
                     </c:if>
                     <c:if test="${empty vo.photo}">
                        <i class="fa fa-user" style="font-size: 28px;"></i>
                     </c:if>
                  </div>
                  <div class="idSpace" >
                     <p>${vo.id}</p>
                  </div>
                  <div class="nameSpace">
                     <p>${vo.name}</p>
                  </div>
                  <div class="birthSpace">
                     <p>
                        <fmt:formatDate value="${vo.birth}" pattern="yyyy-MM-dd" />
                     </p>
                  </div>
                  <div class="telSpace">
                     <p>${vo.tel}</p>
                  </div>
                  <div class="gradeSpace" style="justify-content: center;">
                     <select class="appraisal" name="gradeNo"> 
                        <option value="1" ${vo.gradeNo == 1 ? "selected" : ""}>일반회원</option>
                        <option value="9" ${vo.gradeNo == 9 ? "selected" : ""}>관리자</option>
                     </select>
                  </div>
                  <div class="statusSpace">
                     <select class="appraisal" name="status">
                        <option value="정상" ${vo.status == "정상" ? "selected" : ""}>정상</option>
                        <option value="탈퇴" ${vo.status == "탈퇴" ? "selected" : ""}>탈퇴</option>
                        <option value="휴면" ${vo.status == "휴면" ? "selected" : ""}>휴면</option>
                        <option value="강퇴" ${vo.status == "강퇴" ? "selected" : ""}>강퇴</option>
                     </select>
                  </div>
                  <div>
                     <!-- <h2>공백</h2> -->
                  </div>

               </div>
            </form>
         </div>
      </c:forEach>
   
         <!-- 페이지 내비게이션 -->
         <div class="pageNav" id="pagination"></div>
         
         <div class="misFooter">
            <div class="misFooterBtnSpace">
               <button type="button" class="cancleBtn" onclick="history.back()">취소</button>
               <button type="button" class="updateBtn" onclick="submitActiveForm()">변경</button>
            </div>
         </div>
   </div>

</body>
</html>