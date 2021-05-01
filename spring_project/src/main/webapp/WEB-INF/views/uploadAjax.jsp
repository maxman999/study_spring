<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> Upload Ajax</h1>
<div class = 'uploadDiv'>
	<input type = "file" name = "uploadFile" multiple="multiple">
</div>
	<button id = 'uploadBtn'>upload</button>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" 
crossorigin="anonymous"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB
	
	function checkExtention(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 크기 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
	
		// add filedate to formdata
		for(var i = 0; i < files.length; i++){
			
			if(!checkExtention(files[i].name, files[i].size)){
				return false
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false, // false로 지정해줘야 전송이 됨!
			contentType : false, // false로 지정해줘야 전송이 됨!
			data : formData,
			type : 'post',
			success : function(result){
				alert("Upload");
			}
		});
	
	});	
});

</script>


</body>
</html>