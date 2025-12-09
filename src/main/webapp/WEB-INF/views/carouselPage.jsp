<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carousel Example</title>
<!-- Bootstrap5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<!-- Bootstrap5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    .visualImage {
        width: 100%;
        height: 500px;
        overflow: hidden;
        position: relative;
    }

    .visualImage img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
    }

    .product-icon {
        position: absolute;
        cursor: pointer;
        padding: 5px;
        text-align: center;
        color: white;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 텍스트 그림자 추가 */
    }

    .tooltip-arrow {
        border-top-color: #333; /* 화살표 색상 */
    }
</style>
</head>
<body>
    <div id="carouselExample" class="carousel slide" data-bs-ride="false"> <!-- 수정 -->
        <!-- 왼쪽 및 오른쪽 화살표 -->
        <a class="carousel-control-prev" href="#carouselExample" role="button" data-bs-slide="prev"> <!-- 수정 -->
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span> <!-- 수정 -->
        </a>
        <a class="carousel-control-next" href="#carouselExample" class="carousel-control-next" role="button" data-bs-slide="next"> <!-- 수정 -->
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span> <!-- 수정 -->
        </a>

        <div class="carousel-inner">
            <!-- 첫 번째 이미지 -->
            <div class="carousel-item active visualImage">
                <img src="/upload/goods/bed03.png" class="d-block">
                <div class="product-icon" style="top: 60%; left: 60%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Oak and Gray 오크앤그레이 270,000원" 
                     onclick="viewProduct(1)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 50%; left: 25%;" data-goods_no="1"
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title='Arc Chair 아크체어플라스틱 90,000원' 
                     onclick="viewProduct(2)">
                    <i class="fa fa-plus"></i>
                </div>                
                <div class="product-icon" style="top: 10%; left: 65%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Wood frame 나무액자 27,000원" 
                     onclick="viewProduct(7)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 40%; left: 40%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Light house 라이트하우스 54,000원" 
                     onclick="viewProduct(8)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 48%; left: 15%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Scandiwood 스칸디우드책상 135,000원" 
                     onclick="viewProduct(9)">
                    <i class="fa fa-plus"></i>
                </div>
            </div>

             <!-- 두 번째 이미지 -->
            <div class="carousel-item visualImage">
                <img src="/upload/goods/mainRoom2.png" class="d-block">
                <div class="product-icon" style="top: 56%; left: 80%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Cushion head 침대 280,500원" 
                     onclick="viewProduct(8)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 34%; left: 60%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Beige curtain 베이지암막커튼 63,650" 
                     onclick="viewProduct(9)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 75%; left: 20%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Wood storage 나무수납장 143,740원" 
                     onclick="viewProduct(10)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 85%; left: 37%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="No dust Rug 먼지없는러그 63,240원" 
                     onclick="viewProduct(11)">
                    <i class="fa fa-plus"></i>
                </div>
            </div>

            <!-- 3번째 이미지 -->
            <div class="carousel-item visualImage">
                <img src="/upload/goods/mainRoom3.png" class="d-block">
                <div class="product-icon" style="top: 30%; left: 44%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Mixed color curtain 72,220원" 
                     onclick="viewProduct(12)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 72%; left: 83%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Black stainless chair 35,800원" 
                     onclick="viewProduct(13)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 32%; left: 80%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Mahogany cabinet 마호가니 수납장 270,750원" 
                     onclick="viewProduct(14)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 46%; left: 25%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Urban Retreat 어반 리트릿 침대 389,890원" 
                     onclick="viewProduct(15)">
                    <i class="fa fa-plus"></i>
                </div>
                <div class="product-icon" style="top: 84%; left: 74%;" 
                     data-bs-toggle="tooltip" 
                     data-html="true" 
                     data-bs-placement="top" 
                     title="Calm Texture Rug 촉감좋은러그 85,210원" 
                     onclick="viewProduct(16)">
                    <i class="fa fa-plus"></i>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    // Bootstrap 5 툴팁 활성화
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    function viewProduct(goods_no) {
        // 경로에서 'main'을 빼고, 절대 경로로 'goods'로 이동
        window.parent.location.href = "/goods/view.do?goods_no=" + goods_no;
    }
</script>
</html>
