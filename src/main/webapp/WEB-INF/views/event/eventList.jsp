<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	
});
</script>
</head>
<body>
<div class="container">
	<!-- event/eventList.jsp -->
<c:if test="${empty eventList}">
    <h4>데이터가 존재하지 않습니다.</h4>
</c:if>
<c:if test="${!empty eventList}">
    <div class="dataRow row">
        <c:forEach var="vo" items="${eventList}">
            <div class="col-md-4 promotion-card" data-eno="${vo.eno}">
                <div class="card">
                    <img src="${vo.imageName}" class="card-img-top" alt="${vo.title}">
                    <div class="card-body">
                        <h5 class="card-title">${vo.title}</h5>
                        <p class="card-text">${vo.content}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>
</div>
</body>
</html>
