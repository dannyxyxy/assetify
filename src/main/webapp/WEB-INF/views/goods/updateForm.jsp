<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="/resources/css/goods/updateForm.css">
<script type="text/javascript">
   $(function(){
      // 대분류 리스트 변경
      $("#cate_code1").change(function () {
         // alert("대분류 리스트 변경");
         let cate_code1 = $(this).val();
         // alert("cate_code1 = " + cate_code1);
         
         $.ajax({
            type: "get",
            url: "/goods/getCategory.do?cate_code1=" + cate_code1,
            dataType: "json",
            success: function(result, status, xhr) {
               // alert("중분류 가져오기 성공함수");
               console.log(result);
               
               let str = "";
               result.forEach(function(item) {
                  console.log(item.cate_name);
                  str += '<option value="' + item.cate_code2 + '">';
                  str += item.cate_name + '</option>\n';
               });
               
               console.log(str);
               
               $("#cate_code2").html(str);
            },
            error: function (xhr, status, err) {
               console.log("중분류 가져오기 오류 ***********************");
               console.log("xhr : " + xhr);
               console.log("status : " + status);
               console.log("err : " + err);
            }
         });
      });
      // 대분류 리스트 끝변경 
      
      // image 추가 / 삭제
      let imageTagCnt = 1;
      
      $("#appendImageBtn").click(function () {
         // alert("add Image Button");""
         
         if (imageTagCnt >= 5) return;
         
         let addImageTag = "";
         
         addImageTag += '<div class="input-group mb-3">';
         addImageTag += '<input type="file" class="form-control" name="imageFiles">';
         addImageTag += '<div class="input-group-append">';
         addImageTag += '<button class="btn btn-danger removeImageBtn" type="button">';
         addImageTag += '<i class="fa fa-close"></i>';
         addImageTag += '</button>';
         addImageTag += '</div>';
         addImageTag += '</div>';
         
         $(".imageForm").append(addImageTag);
         imageTagCnt++;
      });
      
      $(".imageForm").on("click", ".removeImageBtn", function () {
         // alert("remove Image Button");
         $(this).closest(".input-group").remove();
         imageTagCnt--;
      });
      
      
      
      
   });
</script>
</head>
<body>
   <div class="container">
     <h4>제품정보 수정하기</h4>
     <form action="update.do" method="post" enctype="multipart/form-data">
     <input type="hidden" name="goods_no" value="${goodsVO.goods_no}" />
     <input type="hidden" name="goods_price_no" value="${goodsVO.goods_price_no }">
        <input type="hidden" name="page" value="${pageObject.page}"/>
           <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}"/>
         <label for="name" style="color: #999;">제품정보 수정</label>
          <div class="form-group">
            <input type="text" class="form-control ipt" id="goods_name" pattern="^[^ .].{2.99}$" required
                  title="맨앞에 공백문자 불가, 3~100자 입력" value="${goodsVO.goods_name }" name="goods_name" style="float: left;">
            <input type="text" class="form-control ipt" id="goods_code" pattern="^[^ .].{2.99}$" required
                  title="맨앞에 공백문자 불가, 3~100자 입력" value="${goodsVO.goods_code }" name="goods_code" style="float: right;">
          </div>
            <label for="name" style="margin: 16px 0 -4px 0;">카테고리</label>
          <div class="form-group">
            <select class="form-control ipt" name="cate_code1" style="float: left; width: 560px; height: 38px; padding-left: 10px; color: black;">
                <option value="1">의자</option>
                <option value="2">소품</option>
                <option value="3">침구</option>
                <option value="4">테이블</option>
                <option value="5">수납</option>
                <option value="6">커튼</option>
                <option value="7">러그</option>
                <option value="8">조명</option>
            </select>
             <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
                value="${goodsVO.company }" name="company" style="float: right;">
          </div>
          <div class="form-group" style="margin-top: 60px;">
             <textarea class="form-control ipt" rows="7" id="content" name="content" placeholder="${goodsVO.content }" required></textarea>
          </div>
          <div class="form-group">
            <label for="imageMain">대표이미지 변경하기</label>
            <input type="file" class="form-control ipt" id="imageMain" name="profileImage" required>   
         </div>
          <div class="form-group">
             <input type="text" class="form-control ipt" id="price" pattern="^[A-Z0-9].{3.20}$" required
                title="대문자와 숫자만 입력 3~20자 입력" value="${goodsVO.price }" name="price" style="float: left;">
             <input type="text" class="form-control ipt" id="sale_price" pattern="^[A-Z0-9].{3.20}$" required
                title="대문자와 숫자만 입력 3~20자 입력" value="${goodsVO.sale_price }" name="sale_price" style="float: right;">
          </div>
          <div class="form-group">
             <input type="text" class="form-control ipt" id="delivary_charge" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
                  placeholder="배송비" name="delivary_charge" style="float: right; margin-top: 16px;" value="무료배송(설치비별도)">
             <input type="text" class="form-control ipt" id="discount_rate" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
                value="${goodsVO.discount_rate }" name="discount_rate" style="float:left; margin-top: 16px;">
          </div>
        <div class="buttonGroup">
           <button type="submit" class="btn2">수정</button>
           <button type="button" class="btn1" onclick="history.back()" id="cancelBtn">취소</button>
        </div>
     </form>
   </div>


</body>
</html>