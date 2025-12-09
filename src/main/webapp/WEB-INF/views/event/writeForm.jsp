<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>이벤트 및 프로모션 등록하기</title>
   <jsp:include page="../jsp/webLib.jsp"></jsp:include>
   
   <link rel="stylesheet" href="/resources/css/event/writeForm.css">

<script type="text/javascript">
   $("#file").on('change',function(){
     var fileName = $("#file").val();
     $(".upload-name").val(fileName);
   });
</script>


</head>
<body>
   <div class="container">
      <h2>이벤트 및 프로모션 등록하기</h2>
      <form action="write.do" method="post" enctype="multipart/form-data">
         <input type="hidden" name="eno" value="${vo.eno}" />
         <div class="titleBox">
             <label for="eventName">이벤트 이름</label>
             <input class="ipt" type="text" name="title" placeholder="이벤트 이름" required>
         </div>
         
         <div class="writeBox">
             <label for="eventStartDate">작성일</label>
             <input class="ipt" type="date" name="writeDate" id="eventWriteDate" placeholder="mm/dd/yyyy" required>
         </div>
          
          <div class="startBox">
             <label for="eventStartDate">이벤트 시작일</label>
             <input class="ipt" type="date" name="startDate" id="eventStartDate" placeholder="mm/dd/yyyy" required>
          </div>
          
         <div class="endBox">
             <label for="eventEndDate">이벤트 종료일</label>
             <input class="ipt" type="date" name="endDate" id="eventEndDate" placeholder="mm/dd/yyyy" required>
         </div>
         
          <div>
             <label class="eConTit" for="eventContent">이벤트 내용</label>
             <textarea class="ipt" id="eventContent" name="content" rows="4" placeholder="이벤트 내용을 입력하세요" required></textarea>
          </div>
          
         <input class="ipt file" type="file" name="file" id="input-file" multiple required>
         
          <div class="buttons">
              <button type="button" class="back-button" onclick="history.back()" id="cancelBtn">뒤로가기</button>
              <button type="submit" class="submit-button">프로모션 등록하기</button>
          </div>
       </form>
   </div>
</body>
</html>