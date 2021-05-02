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
	<div class = 'uploadResult'>
		<ul></ul>
	</div>
	<div class = "bigPictureWrapper">
		<div class = "bigPicture">
		</div>
	</div>
	<button id = 'uploadBtn'>upload</button>
	

<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" 
crossorigin="anonymous"></script>

<script type="text/javascript">
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display", "flex").show();
	$(".bigPicture")
		.html("<img src = '/display?fileName="+encodeURI(fileCallPath) +"'>")
		.animate({width:'100%', height : '100%'}, 1000) 
	}
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
	
	var uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr){
		var str = "";
		$(uploadResultArr).each(function(i, obj){
			if(!obj.image){
				console.log("! uploadPath : " + obj.uploadPath)
				console.log("! uuid : " + obj.uuid)
				console.log("! fileName : " + obj.fileName)
				var fileCallPath = encodeURIComponent(obj.uploadPath +"/"+ obj.uuid + "_" + obj.fileName);
				str += "<li><a href='/download?fileName="+fileCallPath+"'>"+
						"<img src = '/resources/img/attach.png'>" + obj.fileName + "</a>" +
						"<span data-file = \'" + fileCallPath + "\' data-type = 'file'> x </span>" +
						"</li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				// str += "<li>" + obj.fileName + "</li>";
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				str += "<li><a href = \"javascript:showImage(\'"+originPath+"\')\">"+
					   "<img src = '/display?fileName="+ fileCallPath + "'></a>"+
					   "<span data-file =\'" + fileCallPath + "\' data-type = 'image'> x </span>"+"</li>";
			}
		});
		uploadResult.append(str);
	}
	
	
	var cloneObj = $(".uploadDiv").clone();
	
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
			type : "POST",
			dataType : 'json',
			success : function(result){
				console.log(result);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
				
			}
		});
	
	});	
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width: "0%", height: "0%"}, 1000);
		setTimeout(()=>{
			$(this).hide();
		},1000);
	});
	
	$(".uploadResult").on("click","span",function(e){
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName : targetFile, type:type},
			dataType : 'text',
			type : "POST",
			success : function(result){
				alert(result);
			}
		})
		
		
	})
	
});

</script>


</body>
</html>