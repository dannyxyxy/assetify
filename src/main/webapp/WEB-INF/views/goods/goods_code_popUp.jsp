<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 코드 선택</title>
    	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	   	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	   	<link rel="stylesheet" href="/resources/css/goods/goods_code_popUp.css">
</head>
<body>
<div class=container>
    <h2>상품 코드 선택</h2>
	<form action="/goods/goods_code_popUp" method="get"
		class="search-container">
		<select name="cate_code1" class="form-control searchDrop">
			<option value="">카테고리</option>
			<c:forEach var="category" items="${categories}">
				<option value="${category.cate_code1}"
					<c:if test="${goodsSearchVO.cate_code1 == category.cate_code1}">selected</c:if>>
					${category.cate_name}</option>
			</c:forEach>
		</select>

		<!-- 검색어 입력창 -->
		<div class="search-bar-container">
			<span class="search-icon">
				<button type="submit" class="searchBtn" onclick="performSearch()">
					<i class="fa fa-search icon"></i>
				</button>
			</span> <span class="cancel-icon">
				<button type="button" class="resetBtn" onclick="reset()">
					<i class="fa fa-times times"></i>
				</button>
			</span> <input class="form-control search-bar" type="text" id="searchInput"
				name="goods_name" placeholder="상품명 검색"
				value="${goodsSearchVO.goods_name}">
		</div>
	</form>

	<!-- 검색한 조건에 해당하는 데이터가 없을시 -->
		<c:if test="${empty list}">
		    <p>상품 데이터가 없습니다.</p>
		</c:if>
		<c:if test="${!empty list}">
		    <c:forEach var="goods" items="${list}">
<%-- 		        <p>${goods.goods_name}</p> --%>
		    </c:forEach>
		</c:if>



			<!-- 상품 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th>상품 이미지</th>
					<th>상품 이름</th>
					<th>선택</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="goods" items="${list}">
					<tr>
						<td width="250px"><img src="${goods.image_name}" style="height: 170px"></img></td>
						<td width="150px">${goods.goods_name}</td>
						<td>
							<button onclick="selectGoods('${goods.goods_code}')">선택</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>
	
	<span class="paginationBox"> 
		<pageNav:adminPageNav listURI="goods_code_popUp" pageObject="${pageObject}"></pageNav:adminPageNav>
	</span>
    <script>
        // 선택된 상품 코드를 부모 창으로 전달
        function selectGoods(code) {
            opener.document.getElementById('goods_code').value = code; // 부모 창 input에 값 설정
            window.close(); // 팝업 닫기
        }
        function reset() {
            // 검색어 입력 필드 초기화
            document.getElementById('searchInput').value = '';

            // 드롭다운 선택 초기화 (예: 카테고리)
            const dropdown = document.querySelector('select[name="cate_code1"]');
            if (dropdown) dropdown.value = '';

            // 폼을 초기화하거나 필요한 동작 추가
            // document.querySelector('form.search-container').reset(); // 전체 폼 초기화
        }
    </script>
</body>
</html>