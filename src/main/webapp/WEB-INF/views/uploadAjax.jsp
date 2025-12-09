<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- uploadAjax.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<style type="text/css">
.show {
	width:100%;
	background-color:gray;
}

.uploadResult {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult li {
	list-style: none;
	padding: 10px;
}

.uploadResult li img {
	width: 100px;
}

.bigPictureWrapper {
	position: absolute;
	display: none; /* 처음에는 안보여준다. */
	justify-content: center; /* 가로축 기준 : center */
	align-items: center; /* 세로축 기준 : center */
	top: 0%; /* div의 최상단 */
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100; /* 여러 구성요소 중 화면 중복 우선순위 클수록 위로 */
	background:rgba(255,255,255,0.5);
}
.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}

</style>
<script type="text/javascript">


let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)");
let maxSize = 1024 * 1024 * 5; //5MB (5242880)

function checkExtension(fileName, fileSize) {
	// 파일 용량 체크
	if (fileSize > maxSize) {
		alert("화일용량초과 - 업로드 할 수 없습니다.");
		return false;
	}
	// 확장자 체크
	if (regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드 할 수 없습니다.")
		return false;
	}
	return true;
}


function showUploadFile(list) {
	let str = "";
	
	$(list).each(function(i, obj) {
		
		if (!obj.image) {
			let fileCallPath = obj.uploadPath
				+ "/" + obj.uuid + "_" + obj.fileName;
			let filePath = fileCallPath.replaceAll("\\", "/");
			filePath = filePath.substring(9);
			
			str += "<li><a href='/download?fileName=" + filePath +"'>"
				+ "<img src='/upload/image/attach.png'>" +
				obj.fileName + "</a></li>";
		}
		else {
			//str += "<li>" + obj.fileName + "</li>";
			// thumbnail 이미지
			let fileCallPath = obj.uploadPath
				+ "/s_" + obj.uuid + "_" + obj.fileName;
			// windows os에서 폴더사이가 \로 되어있어서
			// url에서 사용하려면 /로 변경하여야 합니다.
			let filePath = fileCallPath.replaceAll("\\", "/"); 
			// vo에 c:/upload/~~~로 저장이 되어있어서
			// 'c:/upload'를 제거하고 하위경로에서 파일이름까지만 저장
			filePath = filePath.substring(9);
			console.log(filePath);
			
			// 오리지널 이미지
			let originalPath = obj.uploadPath
				+ "/" + obj.uuid + "_" + obj.fileName;
			
			originalPath = originalPath.replaceAll("\\", "/");
			originalPath = originalPath.substring(9);
			
			console.log(originalPath);
			
			str += "<li><a href='javascript:showImage(\""
				+ originalPath + "\")'><img src='/display?fileName="
				+ filePath + "'></a></li>";
		}
	});
	console.log(str);
	
	$(".uploadResult").html(str);
}

function showImage(fileCallPath) {
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	
	let str = '<img src="/display?fileName=' + fileCallPath + '">';
	$(".bigPicture").html(str).animate({width:'100%', height:'100%'}, 1000);
}
</script>

<script type="text/javascript">
$(function(){
	// body가 올라오고 난 이후 들어옵니다.
	console.log("jquery 확인");
	
	// body에 있는 부분을 복제하는 것이라 이곳에 있어야 합니다. 
	let cloneObj = $(".uploadDiv").clone();
	
	// 이벤트 처리
	$("#uploadBtn").click(function(){
		let formData = new FormData();// 가상의 폼
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;
		
		console.log(files);
		
		for (let i = 0 ; i < files.length ; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			type: "post",
			url: "/uploadAjaxAction",
			processData: false,
			contentType: false,
			data: formData,
			dataType: 'json',
			success: function(result) {
				//alert("업로드가 되었습니다.")
				console.log(result);
				
				// 파일 업로드 후 초기화
				$(".uploadDiv").html(cloneObj.html());
				
				showUploadFile(result);
			}
		});
	});// end of $("#uploadBtn").click()
	
	// 큰 이미지 클릭시 닫는 처리
	$(".bigPictureWrapper").on("click", function() {
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout(()=>{$(this).hide();}, 1000);
	});
});
</script>
</head>
<body>
<h2>Upload with Ajax</h2>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<button id="uploadBtn">Upload</button>

<div class="show">
	<ul class="uploadResult">
		<li>이미지파일이 없습니다.</li>
	</ul>
</div>

<!-- 원본이미지를 보여줄 공간 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
		<!-- 이 부분을 javascript로 구현 -->
		
	</div>
</div>
</body>
</html>



