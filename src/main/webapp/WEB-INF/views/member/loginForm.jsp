<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
  <!--   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

    <link rel="stylesheet" href="/resources/css/member/loginForm.css"><script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script>
        // Kakao SDK 초기화
        Kakao.init('57e24252af6fa3d0de49862a5dd70653'); // Kakao Developers에서 발급받은 JavaScript 키

        function kakaoLogin() {
            Kakao.Auth.authorize({
                redirectUri: 'http://localhost/member/kakaoCallback'
            });
        }
    </script>


</head>
<body>

    <div class="container loginAll">
        <h3 class="loginText">로그인</h3>
        <form action="login.do" method="post" class="loginInput">
            <div class="form-group">
                <input type="text" class="form-control id" name="id" id="id" placeholder="아이디" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control pw" name="pw" id="pw" placeholder="비밀번호" required>
            </div>
            <button class="btn btn-primary mt-2 loginBtn">로그인</button>
            <!-- 카카오 간편로그인 버튼 -->
        <div style="display: flex; justify-content: center; align-items: center;">
		  <button onclick="kakaoLogin()" style="border: none; background: none;">
		    <img src="/upload/member/kakao.png" alt="Kakao Login" style="display: block;">
		  </button>
		</div>

        </form>
        <div class="signup-link">
            아직 회원이 아니신가요? <a href="writeForm.do">회원가입</a> 해주세요.
        </div>
        
    </div>
    
    
    
    
    
</body> 
</html>

