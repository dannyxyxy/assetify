<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    
    
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>리뷰 수정하기</title>
   <jsp:include page="../jsp/webLib.jsp"></jsp:include>

   <link rel="stylesheet" href="/resources/css/review/updateForm.css">
   
<script type="text/javascript">
   $("#file").on('change',function(){
     var fileName = $("#file").val();
     $(".upload-name").val(fileName);
   });
</script>


</head>
<body>
   <div class="container">
      <h2>리뷰 수정하기</h2>
      <form action="update.do" method="post" enctype="multipart/form-data">
         <input type="hidden" name="rno" value="${param.rno}" />
         <input type="hidden" name="id" value="${login.id}" />
         <div class="form-group">
           <label for="sel1">해당제품을 평가해주세요.</label>
           <select class="form-control" name="status" id="sel1">
             <option value="아주 만족해요" ${vo.status == '아주 만족해요' ? 'selected' : ''}>아주 만족해요</option>
              <option value="만족해요" ${vo.status == '만족해요' ? 'selected' : ''}>만족해요</option>
              <option value="보통이에요" ${vo.status == '보통이에요' ? 'selected' : ''}>보통이에요</option>
              <option value="별로에요" ${vo.status == '별로에요' ? 'selected' : ''}>별로에요</option>
           </select>
         </div>
         
         <div class="titleBox">
             <label for="rtitle">리뷰 제목</label>
             <input class="ipt" type="text" name="title" value="${vo.title}" placeholder="리뷰 제목" required>

         </div>
         
          <div>
             <label class="rConTit" for="content">리뷰 내용</label>
             <textarea class="ipt" id="content" name="content" rows="4" placeholder="리뷰 내용을 입력하세요" required>${vo.content }</textarea>
          </div>
          
          <div class="buttons">
              <button type="button" class="back-button" onclick="history.back()" id="cancelBtn">뒤로가기</button>
              <button type="submit" class="submit-button">수정하기</button>
          </div>
       </form>
   </div>
</body>
</html>