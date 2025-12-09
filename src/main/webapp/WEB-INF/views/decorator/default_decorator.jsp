<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>
        COTTON: <decorator:title />
    </title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Roboto:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <link rel="stylesheet" href="/resources/css/decorator/default_decorator.css">
    
    <script>
    // 페이지 이동을 위한 JavaScript 함수
    function goToCategory(cateCode) {
        window.location.href = "/goods/list.do?cate_code1=" + cateCode;
    }
    
        document.addEventListener("DOMContentLoaded", function() {
            const profileIcon = document.querySelector(".nav-icons .profile-icon"); // 네비 바에 있는 프로필 아이콘
            const rightSidebar = document.getElementById("rightSidebar");
            const closeSidebarButtons = document.querySelectorAll(".close-sidebar");
            const body = document.body;

            // 사이드바 상태 토글 함수
            function toggleSidebar() {
                if (rightSidebar.classList.contains("open")) {
                    closeSidebar();
                } else {
                    openSidebar();
                }
            }

            // 사이드바 열기 함수
            function openSidebar() {
                rightSidebar.classList.add("open");
                body.classList.add("no-scroll");
            }

            // 사이드바 닫기 함수
            function closeSidebar() {
                rightSidebar.classList.remove("open");
                body.classList.remove("no-scroll");
            }

            // 프로필 아이콘 클릭 시 사이드바 열기/닫기
            if (profileIcon) {
                profileIcon.addEventListener("click", function(event) {
                    event.preventDefault(); // 기본 동작 방지
                    toggleSidebar();
                });
            }

            // 사이드바 닫기 버튼 클릭 시 사이드바 닫기
            closeSidebarButtons.forEach(button => {
                button.addEventListener("click", function(event) {
                    event.preventDefault(); // 기본 동작 방지
                    closeSidebar();
                });
            });

           /*  // 바깥 클릭 시 사이드바 닫기
            document.addEventListener("click", function(event) {
                if (!rightSidebar.contains(event.target) && !profileIcon.contains(event.target) && rightSidebar.classList.contains("open")) {
                    closeSidebar();
                }
            }); */

            // 창 크기 조정 시 사이드바 닫기
            window.addEventListener("resize", function() {
                if (window.innerWidth > 768) {
                    closeSidebar();
                }
            });
        });
        // 데코레이터에 있는 검색바를 서치했을떄 해당 category로 url을 보내주는 처리
        function validateSearchForm() {
		    var category = document.getElementById('categorySelect').value.trim();
		    var goodsName = document.getElementById('searchInput').value.trim();
		
		    // 유효성 검사: 둘 중 하나라도 비어 있으면 경고 메시지 표시
		    if (!category || !goodsName) {
		    	$('#msgModal .modal-body').text("카테고리와 제품명을 모두 입력해주세요."); // 모달 메시지 업데이트
	            $('#msgModal').modal('show'); // 모달 표시
		        return false; // 폼 제출 중지
		    }
		
		    return true; // 폼 제출 허용
		}
		
		function performSearch() {
		    // 기본 유효성 검사 호출
		    if (!validateSearchForm()) return;
		
		    var category = document.getElementById('categorySelect').value.trim();
		    var goodsName = document.getElementById('searchInput').value.trim();
		
		    var url = '/goods/list.do';
		    url += '?cate_code1=' + encodeURIComponent(category);
		    url += '&goods_name=' + encodeURIComponent(goodsName);
		
		    window.location.href = url;
		}
		
		function reset() {
		    document.getElementById('categorySelect').value = '';
		    document.getElementById('searchInput').value = '';
		}
    </script>
    
    <decorator:head/>
    <!-- 로그인 정보가 담긴 div 추가 -->
</head>
<body>
    <div class="navbar">
        <a href="/main.do" class="logo">cotton</a>
        <form action="/goods/list.do" method="get" class="search-container" onsubmit="return validateSearchForm();">
	    <select class="form-control searchDrop" id="categorySelect" name="cate_code1" style="font-size: 14px;">
	        <option value="" disabled selected>카테고리 선택</option>
	        <option value="1">의자</option>
	        <option value="2">소품</option>
	        <option value="3">침구</option>
	        <option value="4">테이블</option>
	        <option value="5">수납</option>
	        <option value="6">커튼</option>
	        <option value="7">러그</option>
	        <option value="8">조명</option>
	    </select>
	    <div class="search-bar-container">
	        <span class="search-icon">
	            <button type="button" class="searchBtn" onclick="performSearch()">
	                <i class="fa fa-search icon"></i>
	            </button>
	        </span>
	        <span class="cancel-icon">
	            <button type="button" class="resetBtn" onclick="reset()">
	                <i class="fa fa-times times"></i>
	            </button>
	        </span>
	        <input class="form-control search-bar" type="text" id="searchInput" name="goods_name" placeholder="제품명 검색">
	    </div>

	</form>
        
        <div class="nav-icons">
            <a href="/event/list.do">이벤트 및 프로모션</a>
            <a href="#" onclick="<c:choose>
                <c:when test='${empty login}'>window.location.href='/member/loginForm.do';</c:when>
                <c:otherwise>window.location.href='/qna/list.do?id=${login.id }';</c:otherwise>
            </c:choose>">
            	나의 고객문의
            </a>
            <c:if test="${ empty login }">
                <a href="/member/loginForm.do"><i class="fa fa-user"></i></a>
            </c:if>      
            <c:if test="${ !empty login }">
                <a class="nav-link logoutBtn" href="/member/logout.do">로그아웃</a>              
                <span class="nav-link">
                    <c:if test="${ empty login.photo }">
                        <a href="#" class="profile-icon" style="font-size: 16px;"><i class="fa fa-user"></i></a>
                    </c:if>
                    <c:if test="${ !empty login.photo }">
                        <img src="${login.photo }" class="profile-icon" style="width:30px; height:30px; border-radius:30px;">
                    </c:if>
                </span>          
           </c:if>
            <a href="#" onclick="<c:choose>
                <c:when test='${empty login}'>window.location.href='/member/loginForm.do';</c:when>
                <c:otherwise>window.location.href='/wish/list.do?id=${login.id }';</c:otherwise>
            </c:choose>">
                <i class="fa fa-heart"></i>
            </a>
            <a href="#" onclick="<c:choose>
                <c:when test='${empty login}'>window.location.href='/member/loginForm.do';</c:when>
                <c:otherwise>window.location.href='/cart/list.do?id=${login.id }';</c:otherwise>
            </c:choose>">
                <i class="fa fa-shopping-cart"></i>
            </a>
        </div>
    </div>
    
    <div class="right-sidebar" id="rightSidebar">
        <button class="close-sidebar float-right" aria-label="Close Sidebar"><i class="fa fa-close closeBtn"></i></button>
        <c:if test="${!empty login.photo}">
        	<div class="profile-container">
	            <img src="${login.photo}" class="profile-pic">	
        	</div>
        </c:if>
        <c:if test="${empty login.photo}">
        	<div class="profile-container">
        		<div class="default-icon" aria-label="Default Profile Icon">&#128100;</div>
        	</div>
        </c:if>
        
        <div class="username">
            <c:if test="${!empty login.id}">
                ${userId}
            </c:if>
            <c:if test="${empty login.id}">
                Guest
            </c:if>
        </div>
        <hr>
	        <a href="/cart/list.do?id=${login.id }" style="font-size:15px;">쇼핑카트</a>
	        <a href="/wish/list.do?id=${login.id }" style="font-size:15px;">위시리스트</a>
	        <c:if test="${login.gradeNo==1 }">
	        	<a href="/review/list.do?id=${login.id }" style="font-size:15px;">내가 쓴 리뷰</a>
	        </c:if>
	        <a href="/member/logout.do" style="font-size:15px;">로그아웃</a>
	        <hr>
	        <a href="/member/updateForm.do" style="font-size:15px;">회원정보</a>
	        <c:if test="${login.gradeNo==9 }">
	        	<a href="/member/adminPage.do" style="font-size:15px;">회원관리</a>
	        </c:if>
	        <c:if test="${login.gradeNo==9 }">
	        	<a href="/review/list.do?id=${login.id }" style="font-size:15px;">리뷰관리</a>
        </c:if>
    </div>
   
    <div class="category-bar">
    <!-- 각 카테고리 항목에서 <a> 태그 제거하고 onclick 이벤트 추가 -->
    <div class="category-item" onclick="goToCategory(1)">
        <img src="/upload/goods/chair.png" alt="Chair">
        <p>의자</p>
    </div>
    <div class="category-item" onclick="goToCategory(2)">
        <img src="/upload/goods/etc.png" alt="Accessories">
        <p>소품</p>
    </div>
    <div class="category-item" onclick="goToCategory(3)">
        <img src="/upload/goods/bed.png" alt="Bed">
        <p>침구</p>
    </div>
    <div class="category-item" onclick="goToCategory(4)">
        <img src="/upload/goods/table.png" alt="Table">
        <p>테이블</p>
    </div>
    <div class="category-item" onclick="goToCategory(5)">
        <img src="/upload/goods/storage.png" alt="Storage">
        <p>수납</p>
    </div>
    <div class="category-item" onclick="goToCategory(6)">
        <img src="/upload/goods/curtain.png" alt="Curtain">
        <p>커튼</p>
    </div>
    <div class="category-item" onclick="goToCategory(7)">
        <img src="/upload/goods/rug.png" alt="Rug">
        <p>러그</p>
    </div>
    <div class="category-item" onclick="goToCategory(8)">
        <img src="/upload/goods/light.png" alt="Light">
        <p>조명</p>
    </div>
</div>

    
    <div class="main-content">
        <decorator:body />
    </div>
    
	    <div class="footer">
	    	<div style="width: 1140px; display: flex; justify-content: space-between; margin: auto;">
		        <div class="footer-column">
		            <h4>Collaborators</h4>
		            <a href="https://github.com/dannyxyxy"><i class="fa fa-github"></i> @dannyxyxy</a>
		            <a href="https://github.com/luuunana"><i class="fa fa-github"></i> @luuunana</a>
		            <a href="https://github.com/ayger123"><i class="fa fa-github"></i> @ayger123</a>
		            <a href="https://github.com/tomato2kg"><i class="fa fa-github"></i> @tomato2kg</a>
		        </div>
		        <div class="footer-column" style="margin: 0 100px;">
		            <h4>Contact</h4>
		            <a href="https://mail.google.com/"><i class="fa fa-send"></i> cotton@gmail.com</a>      
		           	<a href="https://www.instagram.com/cottonmall/profilecard/?igsh=Y3Rtcjh4ZGw0ODFy"><i class="fa fa-instagram"></i> @cottonmall</a>
		           	<a href="https://github.com/dannyxyxy/cotton"><i class="fa fa-github"></i> @cotton</a>
		           	<a href="https://www.figma.com/design/EmqKq85HvwzRfT08pPEpSW/cotton?node-id=0-1&node-type=canvas&t=wsvuoLmmZaKcl33w-0"><i class="fa fa-paint-brush"></i> @cotton</a>
		        </div>
		        <div class="footer-column">
		            <h4>cotton's goal</h4>
		            <p>Our ultimate goal is<br>
		            comfortable and convenient shopping for customers<br>
		            and the growth of collaborators.<br>
		            Thank you for visit cotton, and enjoy!</p>
		        </div>
	    	</div>
	    </div>
	    
	     <!-- The Modal -->
	  <div class="modal fade" id="msgModal">
	    <div class="modal-dialog">
	      <div class="modal-content">   
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">INFO</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>    
	        <!-- Modal body -->
	        <div class="modal-body">
	          ${msg}
	        </div>   
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-dark" data-dismiss="modal">OK</button>
	        </div>
	        
	      </div>
	    </div>
	  </div>
	<!-- session 담은 msg를 보여주는 모달창 -->
	<c:if test="${!empty msg}">
		<!-- 모달을 보이게하는 javascript -->
		<script type="text/javascript">
			$(function() {
				$("#msgModal").modal("show");
				
			})
		</script>
	</c:if>
</body>
</html>
