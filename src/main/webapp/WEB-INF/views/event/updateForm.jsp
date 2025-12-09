<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    
    
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>이벤트 및 프로모션 수정하기</title>
   <jsp:include page="../jsp/webLib.jsp"></jsp:include>

   <link rel="stylesheet" href="/resources/css/event/updateForm.css">
   
<script type="text/javascript">
   $("#file").on('change',function(){
     var fileName = $("#file").val();
     $(".upload-name").val(fileName);
   });
</script>


</head>
<body>
   <div class="container">
      <h2>이벤트 및 프로모션 수정하기</h2>
      <form action="update.do" method="post" enctype="multipart/form-data">
         <input type="hidden" name="eno" value="${vo.eno}" />
         <div class="titleBox">
             <label for="eventName">이벤트 이름</label>
             <input class="ipt" type="text" name="title" value="${vo.title }" placeholder="이벤트 이름" required>
         </div>
         
         <div class="writeBox">
             <label for="eventStartDate">작성일</label>
             <input class="ipt" type="date" name="writeDate" value="<fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/>" id="eventWriteDate" placeholder="mm/dd/yyyy" required>
         </div>
          
          <div class="startBox">
             <label for="eventStartDate">이벤트 시작일</label>
             <input class="ipt" type="date" name="startDate" value="<fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd"/>" id="eventStartDate" placeholder="mm/dd/yyyy" required>
          </div>
          
         <div class="endBox">
             <label for="eventEndDate">이벤트 종료일</label>
             <input class="ipt" type="date" name="endDate" value="<fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd"/>" id="eventEndDate" placeholder="mm/dd/yyyy" required>
         </div>
         
          <div>
             <label class="eConTit" for="eventContent">이벤트 내용</label>
             <textarea class="ipt" id="eventContent" name="content" rows="4" placeholder="이벤트 내용을 입력하세요" required>${vo.content }</textarea>
          </div>
          
         <input class="ipt file" type="file" name="file" id="input-file" multiple required>
         
          <div class="buttons">
              <button type="button" class="back-button" onclick="history.back()" id="cancelBtn">돌아가기</button>
              <button type="submit" class="submit-button">수정하기</button>
          </div>
       </form>
   </div>
</body>
</html>