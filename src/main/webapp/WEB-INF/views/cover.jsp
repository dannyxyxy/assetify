<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cotton Cover</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Roboto:wght@300&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden; /* 스크롤 제거 */
        }

        /* Container for the cover */
        .cover-container {
            position: relative;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            z-index: 2;
        }

        /* Title and subtitle text */
        .cover-container h1 {
            font-size: 4rem;
            font-weight: bold;
            color: white;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.7);
            font-family: 'Noto Sans KR', sans-serif;
        }

        .cover-container h2 {
            font-size: 1.5rem;
            color: white;
            margin-top: 10px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: bold;
        }
        
        .cover-container p {
        	font-size: 1rem;
        	color:white;
        	margin-top: 10px;
        	text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        	font-family: 'Noto Sans KR', sans-serif;
        	font-weight: slim;
        }

        /* Background image slider */
        .background-slider {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            display: flex;
            z-index: 1;
            background-color:  #C9B89E; /* 배경 색 지정 */
            filter: brightness(0.8); /* 배경 밝기 낮추기 */
            
        }

        /* Styling for each slide */
        .background-slider .slide {
            position: absolute;
            top: 100%; /* 시작 위치: 화면 아래 */
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0; /* Initially invisible */
            animation: slideUp 56s infinite;
            filter: brightness(0.8); /* 배경 밝기 낮추기 */
            
        }

        /* Timing for each slide */
        .background-slider .slide:nth-child(1) { animation-delay: 0s; }
        .background-slider .slide:nth-child(2) { animation-delay: 7s; }
        .background-slider .slide:nth-child(3) { animation-delay: 14s; }
        .background-slider .slide:nth-child(4) { animation-delay: 21s; }
        .background-slider .slide:nth-child(5) { animation-delay: 28s; }
        .background-slider .slide:nth-child(6) { animation-delay: 35s; }
        .background-slider .slide:nth-child(7) { animation-delay: 42s; }
        .background-slider .slide:nth-child(8) { animation-delay: 49s; }
        .background-slider .slide:nth-child(9) { animation-delay: 56s; }
        .background-slider .slide:nth-child(10) { animation-delay: 63s; }

        /* Animation for slide up effect */
        @keyframes slideUp {
            0% {
                top: 100%; /* 화면 아래 시작 */
                opacity: 0;
                z-index: 0;
            }
            5%, 25% {
                top: 0; /* 화면 중앙 */
                opacity: 1;
                z-index: 1;
            }
            30%, 100% {
                top: -100%; /* 화면 위로 사라짐 */
                opacity: 0;
                z-index: 0;
            }
        }

        /* Slide content for images */
        .slide img {
            width: 50%; /* Each image takes half the width */
            height: 100%; /* Each image takes full height */
            object-fit: cover;
            float: left; /* Place images side by side */
        }

        /* Close button styling */
        .close-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            z-index: 1002; /* Ensure the close button is on top */
        }
        .close-btn:hover {
            color: #ccc;
        }
    </style>
</head>
<body>
    <!-- Background Slider -->
    <div class="background-slider">
        <div class="slide">
            <img src="/upload/cover/cover1.png" alt="Background 1">
            <img src="/upload/cover/cover2.png" alt="Background 2">
        </div>
        <div class="slide"></div> <!-- Empty background slide -->
        <div class="slide">
            <img src="/upload/cover/cover3.png" alt="Background 3">
            <img src="/upload/cover/cover4.png" alt="Background 4">
        </div>
        <div class="slide"></div> <!-- Empty background slide -->
        <div class="slide">
            <img src="/upload/cover/cover5.png" alt="Background 5">
            <img src="/upload/cover/cover6.png" alt="Background 6">
        </div>
        <div class="slide"></div> <!-- Empty background slide -->
        <div class="slide">
            <img src="/upload/cover/cover7.png" alt="Background 7">
            <img src="/upload/cover/cover8.png" alt="Background 8">
        </div>
        <div class="slide"></div> <!-- Empty background slide -->
        <div class="slide">
            <img src="/upload/cover/cover9.png" alt="Background 9">
            <img src="/upload/cover/cover10.png" alt="Background 10">
        </div>
        <div class="slide"></div> <!-- Empty background slide -->
    </div>

    <!-- Close Button -->
    <a href="javascript:void(0);" class="close-btn" aria-label="Close" onclick="closeCover()">
    	close
	</a>

    <!-- Main Content (overlay) -->
    <div class="cover-container">
        <div>
            <h1 class="display-4">cotton</h1>
            <h2 class="lead">cotton's goal</h2>
            <p>Our ultimate goal is comfortable and convenient shopping for customers<br>
			and the growth of collaborators. Thank you for visit cotton, and enjoy!</p>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function closeCover() {
        // 부모 페이지의 closeCover 함수 호출
        parent.closeCover();
    }
</script>
</body>
</html>
