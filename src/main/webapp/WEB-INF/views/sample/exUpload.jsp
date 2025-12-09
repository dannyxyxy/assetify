<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- exUpload.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
<body>
<h2>파일 업로드</h2>
<form action="exUploadPost" method="Post"
	enctype="multipart/form-data">
	<!-- spring에서 name이 같은 것으로 전송하면
		하나의 List에 담을 수 있다. -->
	첨부파일1 : <input type="file" name="files"><br>
	첨부파일2 : <input type="file" name="files"><br>
	첨부파일3 : <input type="file" name="files"><br>
	첨부파일4 : <input type="file" name="files"><br>
	첨부파일5 : <input type="file" name="files"><br>
	<!-- form태그 안의 button type은 submit 이 default이다. -->
	<button>전송</button>
</form>

</body>
</html>








