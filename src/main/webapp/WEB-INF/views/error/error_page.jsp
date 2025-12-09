<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- error_page.jsp (views폴더에) -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지(500)</title>
</head>
<body>
<!-- getMessage() -->
<h3>${exception.message }</h3>
<ul>
	<c:forEach items="${exception.stackTrace }" var="stack">
		<li>${stack }</li>
	</c:forEach>
</ul>
</body>
</html>