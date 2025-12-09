<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 쓰기</title>
<link rel="stylesheet" href="/resources/css/qna/writeForm.css">
</head>
<body>
	<div class="container">
		<h2>문의 글 쓰기</h2>
		<form action="write.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }" />

			<label for="name" style="color: #ccc;">문의사항을 남겨주세요! 순차적으로 확인
				도와드리겠습니다.</label>
			<div class="qnaInfo-container">
				<input type="text" style="width: 69%; margin: 0 10px 0 0;" class="qnaInfo-box" id="title"
					pattern="^[^ .].{2.99}$" required placeholder="글제목" name="title"
					style="float: left;"> 
				<input type="text" style="width: 29%;" class="qnaInfo-box" id="goods_code" 
					pattern="^[^ .].{2.99}$" required 
					placeholder="문의제품찾기" name="goods_code" style="float: right;"
					readonly onclick="openPopup()" 
					title="상품 코드를 선택해주세요." />
			</div>

			<div class="qnaContent-container" style="margin-top: 30px;">
				<textarea class="qnaContent-box" rows="7" id="content"
					name="content" placeholder="문의사항" required></textarea>
			</div>

			<b style="font-size: 14px;">문의 관련 이미지 첨부하기</b> 
			<input type="file" class="form-control" name="imageFile"
				style="height: 100%; margin: 5px 0 20px 0;">

			<div class="form-group btnBox">
				<button type="submit" class="registerBtn">문의 등록하기</button>
				<button type="button" class="cancelBtn" onclick="history.back()"
					id="cancelBtn">돌아가기</button>
			</div>

			<script>
				function openPopup() {
				    const popup = window.open('/goods/goods_code_popUp', '상품 코드 선택', 'width=600,height=750,scrollbars=yes');
				    if (!popup) {
				        alert('팝업이 차단되었습니다. 팝업 설정을 확인해주세요.');
				    }
				}
			</script>

		</form>
	</div>
</body>
</html>
