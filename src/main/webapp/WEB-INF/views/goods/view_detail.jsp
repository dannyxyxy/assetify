<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <div class="container">
    	<div class="detail_content">
    		<div id="output" style="margin-top: 20px; white-space: pre-wrap;">${vo.content }</div>
    	</div>
        <div class="row" style="margin-top: 150px;">
            <c:if test="${!empty imageList}">
                <c:forEach items="${imageList}" var="imageVO" varStatus="status">
                    <div class="col-md-6 mb-4">
                        <img src="${imageVO.goods_img_name}" class="img-thumbnail w-100" style="height: 500px; object-fit: cover;">
                    </div>
                    <c:if test="${(status.index + 1) % 2 == 0 && !status.last}">
                        </div><div class="row">
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>

</html>
