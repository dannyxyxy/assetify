<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main</title>
    <link rel="stylesheet" href="/resources/css/main/main.css">
    <script type="text/javascript">    
    document.addEventListener('DOMContentLoaded', function() {
        fetch('/event/main')  // GET 요청을 통해 이벤트 리스트를 가져옴
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();  // 응답을 텍스트로 변환
            })
            .then(data => {
                // 이벤트 리스트만을 eventListContainer에 삽입
                const eventListContainer = document.getElementById('eventListContainer');
                eventListContainer.innerHTML = data;

                // 삽입된 카드에 클릭 이벤트 추가
                const cards = eventListContainer.querySelectorAll('.promotion-card');
                cards.forEach(card => {
                    card.addEventListener('click', function() {
                        const eno = card.getAttribute('data-eno');  // data-eno 값을 추출
                        if (eno) {
                            window.location.href = "/event/view.do?eno=" + eno;  // 해당 eno로 이동
                        }
                    });
                });
            })
            .catch(error => console.error('Error:', error));
    });

    </script>
</head>
<body>
	<!-- cover.jsp를 iframe으로 띄우기 -->
	<iframe src="/main/cover" id="cover-frame" style="width:100%; height: 100vh; border:none; overflow: hidden;
	position:fixed; top:0; left:0; display:none; z-index:1000;"></iframe>
	<!-- 커버 화면 다시 보기 버튼 -->
	<button onclick="resetCover()" style="position: fixed; bottom: 20px; right: 20px; z-index: 100;
	 background-color:  #C9B89E; color:#FFF; border-radius: .25rem; width:150px; height:40px; border:none;">
	    커버화면 보러가기
	</button>

    <!-- iframe으로 캐러셀 삽입 -->
	<div class="container">
	    <iframe src="/main/carouselPage" width="100%" height="500" style="border: none; overflow: hidden;"></iframe>
	</div>
    <div class="container">
    	<div class="visualImageText">
	    	<div><h4>공간별 쇼핑하기</h4></div>
	    	<div><b>cotton</b>이 디자인한 공간에서<br>맘에드는 제품을 편리하게 살펴보세요!</div>
    	</div>
    	<div>
	    	<div><h4>진행중인 이벤트 및 프로모션</h4></div>
	    	<div><b>cotton</b>이 자신있게 제시하는<br>이벤트와 프로모션을 살펴보세요!</div>
    	</div>
    <div id="eventListContainer" style="height:370px;overflow:hidden;"></div>	
    </div>
    <script>
    // iframe 숨기고 상태 저장하는 함수 (X 버튼 클릭 시 호출)
    function closeCover() {
        var coverFrame = document.getElementById('cover-frame');

        // iframe 숨기기
        coverFrame.style.display = 'none';

        // localStorage에 상태 저장
        localStorage.setItem('coverClosed', 'true');
    }

    // 커버 화면 다시 보기 함수
    function resetCover() {
        var coverFrame = document.getElementById('cover-frame');

        // iframe 다시 표시
        coverFrame.style.display = 'block';

        // localStorage 상태 초기화
        localStorage.removeItem('coverClosed');
    }

    // 페이지 로드 시 커버 표시 여부 결정
    window.onload = function () {
        var coverFrame = document.getElementById('cover-frame');
        var isCoverClosed = localStorage.getItem('coverClosed');

        if (!isCoverClosed) {
            // 커버가 닫히지 않은 상태라면 iframe 표시
            coverFrame.style.display = 'block';
        } else {
            // 이미 닫힌 상태라면 iframe 숨김
            coverFrame.style.display = 'none';
        }
    };
</script>
    
</body>
</html>

