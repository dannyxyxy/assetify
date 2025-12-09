<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category List</title>
<style type="text/css">
.editDiv{
	display:none;
}
</style>
<script type="text/javascript">
$(function(){
	$(".bigCateData").click(function(){
		let cate_code1=$(this).data("cate_code1");
		if(!$(this).hasClass("active")){
			location="list.do?cate_code1="+cate_code1;		//다른탭 선택시 중분류카테고리 불러오기	
		}
	});
	
	$(".cate_edit").click(function(){
		$(".editDiv").hide();
		$(this).next(".editDiv").slideDown();
		return false;
	});
	
	$("#writeBigBtn").click(function(){
		return categoryProcess("대분류등록",0,0,"","write.do","등록");
	});
	
	$("#writeMidBtn").click(function(){
		return categoryProcess("중분류등록",${cate_code1},0,"","write.do","등록");
	});
	
	$(".updateBigBtn").click(function(){
		let cate_code1=$(this).closest("a").data("cate_code1");
		let cate_name=$(this).closest("a").find(".cate_name").text();
		return categoryProcess("대분류수정",cate_code1,0,cate_name,"update.do","수정");
	});
	
	$(".updateMidBtn").click(function(){
		let cate_code1=$(this).closest("li").data("cate_code1");
		let cate_code2=$(this).closest("li").data("cate_code2");
		let cate_name=$(this).closest("li").find(".midCateName").text();
		return categoryProcess("중분류수정",cate_code1,cate_code2,cate_name,"update.do","수정");
	});
	
	$(".deleteBigBtn").click(function(){
		let cate_code1=$(this).closest("a").data("cate_code1");
		let cate_name=$(this).closest("a").find(".cate_name").text();
		return categoryProcess("대분류삭제",cate_code1,0,cate_name,"delete.do","삭제");
	});
	
	$(".deleteMidBtn").click(function(){
		let cate_code1=$(this).closest("li").data("cate_code1");
		let cate_code2=$(this).closest("li").data("cate_code2");
		let cate_name=$(this).closest("li").find(".midCateName").text();
		return categoryProcess("중분류삭제",cate_code1,cate_code2,cate_name,"delete.do","삭제");
	});
	
	function categoryProcess(title,cate_code1,cate_code2,cate_name,url,btnName){
		$("#categoryModal").find(".modal-title").text(title);
		$("#modalCateCode1").val(cate_code1);
		$("#modalCateCode2").val(cate_code2);
		$("#modalCateName").val(cate_name);
		$("#modalForm").attr("action",url);
		$("#submitBtn").text(btnName);
		$("#submitBtn").removeClass("btn-primary");
		$("#submitBtn").removeClass("btn-success");
		$("#submitBtn").removeClass("btn-danger");
		
		if(btnName=="수정"){
			$("#submitBtn").removeClass("btn-success");
		} else if(btnName=="삭제"){
			$("#submitBtn").removeClass("btn-danger");
		} else{
			$("#submitBtn").removeClass("btn-primary");
		}
		
		$("#categoryModal").modal("show");
		
		return false;
	}
	
});
</script>
</head>
<body>
	<div class="container">
		<div class="card">
  			<div class="card-header"><h2>Category manage</h2></div>
  			<div class="card-body">
  				<ul class="nav nav-tabs">
  					<c:forEach items="${listBig }" var="vo">
  						<li class="nav-item">
					      <a class="nav-link bigCateData ${(vo.cate_code1==cate_code1) ? 'active' : ''}"
					       data-toggle="tab" href="#mid_category" data-cate_code1="${vo.cate_code1 }">
					       <span class="cate_name">${vo.cate_name }</span><i class="fa fa-edit cate_edit"></i>
					       <div class="editDiv">
					       	<button class="btn btn-primary btn-sm updateBigBtn">수정</button>
					       	<button class="btn btn-danger btn-sm deleteBigBtn">삭제</button>
					       </div>
					       </a>
					    </li>
  					</c:forEach>
  					<li class="nav-item">
					  <a class="nav-link" data-toggle="tab" href="#mid_category"
					  id="writeBigBtn" data-cate_code1="${vo.cate_code1 }"><i class="fa fa-plus"></i></a>
					</li>
				  </ul>
				  <!-- Tab panes -->
				  <div class="tab-content">
				  	<div id="mid_category" class="container tab-pane active"><br>
					  <h3>Category   <button class="btn btn-primary btn-sm"
					  id="writeMidBtn" data-cate_code1="${vo.cate_code1 }"><i class="fa fa-plus"></i></button></h3>
					      <ul class="list-group">
					      	<c:forEach items="${listMid }" var="vo">
					      		<li class="list-group-item" data-cate_code1="${vo.cate_code1 }" data-cate_code2="${vo.cate_code2 }">
					      			<span class="float-right">
						      			<button class="btn btn-success updateMidBtn">수정</button>
						      			<button class="btn btn-danger deleteMidBtn">삭제</button>
					      			</span>
					      			<span class="midCateName">${vo.cate_name }</span>
					      		</li>
					      	</c:forEach>
					      </ul>
					 </div>
				  </div>
  			</div>
  			<div class="card-footer">
  				
  			</div>
		</div>
	</div>
	<div class="modal fade" id="categoryModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <form id="modalForm" method="post" action="">
        	<input type="hidden" name="cate_code1" id="modalCateCode1" value="0">
        	<input type="hidden" name="cate_code2" id="modalCateCode2" value="0">
	        <div class="modal-body">
	          <input name="cate_name" class="form-control" id="modalCateName">
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button class="btn btn-primary" id="submitBtn">등록</button>
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>