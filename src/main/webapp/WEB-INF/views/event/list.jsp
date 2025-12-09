<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<!-- 데이터는 DispatcherServlet에 담겨있다(request) -->
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>상품 리스트</title>
   
   <link rel="stylesheet" href="/resources/css/event/list.css">


<script type="text/javascript">
   $(function(){
      $(".promotion-card").click(function() {
          let eno = $(this).data("eno");
          console.log("eno =", eno);
          if (eno) {
              location = "view.do?eno=" + eno + "&${pageObject.pageQuery}&${goodsSearchVO.searchQuery}";
          } else {
              console.error("eno가 정의되지 않았습니다.");
          }
      });
      
//       $(".dataRow").click(function() {
//          // tag에 적힌 data-eno="${vo.eno}"
//          let eno = $(this).data("eno");
//          //alert(eno);
//          location = "view.do?eno=" + eno + "&inc=1"
//             + "&${pageObject.pageQuery}";
//             // pageObject의 getPageQuery()를 가져와서
//             // page, perPageNum, key, word를 붙인다.
//       });
   
       
      $("#perPageNum").change(function(){
         $("#searchForm").submit();
      });
      // 검색데이터 세팅
      $("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
      $("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
   
      
      $("#cate_code1").change(function(){
          let cate_code1 = $(this).val();
          $.ajax({
              type: "get",
              url: "/goods/getCategory.do?cate_code1=" + cate_code1,
              dataType: "json", // JSON 형식의 데이터를 기대
              success: function(result){
                  console.log(result);
                  let subCategorySelect = $("#cate_code2");
                  subCategorySelect.empty(); // 기존 옵션 제거
                  $.each(result, function(index, category){
                      subCategorySelect.append(
                          $("<option></option>").attr("value", category.cate_code2).text(category.cate_name)
                      );
                  });
              },
              error: function(xhr, status, err){
                  console.log("중분류 가져오기 오류");
                  console.log("xhr : " + xhr);
                  console.log("status : " + status);
                  console.log("err : " + err);
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
      <h2>진행중인 이벤트 및 프로모션</h2>
      <h5>현재 진행중인 이벤트 및 프로모션을 확인해보세요!</h5>
      <c:if test="${empty list }">
         <h4>데이터가 존재하지 않습니다.</h4>
      </c:if>
      <c:if test="${!empty list }">
           <div class="dataRow row">
               <c:forEach var="vo" items="${list}">
                   <div class="col-md-4 promotion-card" data-eno="${vo.eno }">
                       <div class="card">
                           <img src="${vo.imageName}" class="card-img-top" alt="${vo.imageName}">
                           <div class="card-body">
                               <h5 class="card-title">${vo.title}</h5>
                               <p class="card-text">${vo.content}</p>
                           </div>
                       </div>
                   </div>
               </c:forEach>
           </div>
            <!-- 이미지 데이터 반복 표시 끝 -->
      </c:if>
      <!-- 데이터 존재했을때 처리 끝 -->
      
      <div class="navRegbtnBox">
         <!-- 페이지 내비게이션 -->
          <div class="pageNav" id="pagination"></div>
   
         <!-- 로그인이 되어있으면 등록버튼이 보이게 처리 -->
         <div class="buttons regBtn" style="">
            <c:if test="${login.gradeNo==9 }">
               <a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="registerBtn">등록</a>
            </c:if>
         </div>
      </div>
   </div>
</body>

</html>