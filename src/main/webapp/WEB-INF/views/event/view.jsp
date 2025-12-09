<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>이벤트 및 프로모션 상세페이지</title>
   <jsp:include page="../jsp/webLib.jsp"></jsp:include>
   
   <link rel="stylesheet" href="/resources/css/event/view.css">


<script type="text/javascript">
   $(function(){
      // 글수정버튼(id="updateBtn")을 클릭했을때 
      $("#updateBtn").click(function() {
         location = "updateForm.do?eno=${vo.eno}";
      });
      
      // 글삭제버튼(id="deleteBtn")을 클릭했을때
      // 모달창의 pw내용을 지운다.
      $("#deleteBtn").click(function() {
         $("#pw").val("");
      });
      
      // 리스트버튼(id="listBtn")을 클릭했을때
      // list.do 로 이동한다.
      // param. 으로 되어있는 값은 url에서 같이 넘어온 값(적혀있는값) - get
      $("#listBtn").click(function() {
         //alert("리스트 버튼 클릭");
         location = "list.do?page=${param.page}"
            + "&perPageNum=${param.perPageNum}"
            + "&key=${param.key}"
            + "&word=${param.word}";
      });
   });
</script>

</head>
<body>
   <div class="container">
        <div class="titleBox">
             <p>${vo.title }</p>
          </div>
        <div class="event-info">
            <span>이벤트 기간 : <fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/> </span>
            <span>작성일 : <fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/></span>
        </div>
        
        <div class="image-container">
            <img src="${vo.imageName }" alt="가을 신제품 이미지" style="width: 900px;">
        </div>
        
        <div class="content">
            <p>${vo.content }</p>
        </div>
        
        <div class="backBtnBox">
           <button class="backBtn" onclick="history.back()" id="cancelBtn">뒤로가기</button>
        </div>
        
        <div class="buttons">
           <c:if test="${login.gradeNo==9 }">
               <a href="updateForm.do?perPageNum=${pageObject.perPageNum }&eno=${vo.eno}" class="button updateBtn">수정</a>
               <form action="${pageContext.request.contextPath}/event/delete.do" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                <input type="hidden" name="eno" value="${vo.eno}">
                <button type="submit" class="button deleteBtn">이벤트 삭제</button>
            </form>
           </c:if>
        </div>
    </div>
</body>
</html>