<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
                <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
							Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<form id = "registForm" action="/board/register" method = "post">
								 <input type = "hidden" name = "${_csrf.parameterName}" value = "${_csrf.token}" />
								 <div class="form-group">	
	                                  <label>Title</label>
	                                  <input class="form-control" name = "title">
                                 </div>
                                 <div class="form-group">
	                                <label>Content</label>
	                                <textarea class="form-control" rows="5" cols="50" name = "content"></textarea>
                                 </div>
                                 <div class="form-group">
                                 	<label>Writer</label>
                                 	<input class="form-control" name = "writer" value = '<sec:authentication property="principal.username"/>' readonly="readonly" >
                                 </div>
                                 	<button type="submit" class="btn btn-default">Submit Button</button>
                                    <button type="reset" class="btn btn-default">Reset Button</button>
							</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row  -->
            <div class = "row">
            	<div class = "col-lg-12">
    				<div class = "panel panel-default">
						<div class = "panel-heading">File Attach</div>
						<!-- /.panel-heading  -->
						<div class = "panel-body">
							<div class = "form-group uploadDiv">
								<input id = "inputFile" type ="file" name = "uploadFile" multiple>
							</div>
							<div class = "uploadResult">
								<ul>
								</ul>
							</div>
						</div>    				
    				</div>        	
            	</div>
            </div>
            <!-- /.row -->
          		  </div>
          		  
<script>
$(document).ready(function(e){
	var formObj = $("#registForm");
	$("button[type = 'submit']").on("click", function(e){
		e.preventDefault();
		let str = "";
		$(".uploadResult ul li").each(function(i, obj){
			let jobj = $(obj);
			str += "<input type = 'hidden' name = 'attachList["+i+"].filename' value = '" + jobj.data("filename") + "'>"
			str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '" + jobj.data("uuid") + "'>"
			str += "<input type = 'hidden' name = 'attachList["+i+"].uploadpath' value = '" + jobj.data("path") + "'>"
			str += "<input type = 'hidden' name = 'attachList["+i+"].filetype' value = '" + jobj.data("type") + "'>"
		});
		formObj.append(str).submit();
		
	})
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; // 5MB
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
	
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	let cloneObj = $("#inputFile").clone(true);
	$("input[type='file']").on("change",function(e){
		let formData = new FormData();
		let inputFile = $("input[name='uploadFile']");
		let files = inputFile[0].files;
		
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
			// 스프링 시큐리티 적용 후 ajax에서 post 전송을 위한 처리
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : formData,
			type : "POST",
			dataType : 'json',
			success : function(result){
				console.log(result);
 				showUploadedFile(result);
				$("#inputFile").html(cloneObj.html());
			}
		}); //$.ajax
	});
	
	let uploadResult = $(".uploadResult ul");
	function showUploadedFile(uploadResultArr){
		let str = "";
		$(uploadResultArr).each(function(i, obj){
			if(!obj.image){
				let fileCallPath = encodeURIComponent(obj.uploadPath +"/"+ obj.uuid + "_" + obj.fileName);
				str += "<li data-path ='"+obj.uploadPath+"' data-uuid ='"+obj.uuid+"' data-filename ='"+obj.fileName+"' data-type ='"+obj.image+"'><div>";
				str += "<span>" +obj.fileName + "</span>";
				str += "<button type = 'button' data-file = \'" + fileCallPath + "\' data-type = 'file' class = 'btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src = '/resources/img/attach.png'></a>";
				str += "</div></li>"
			}else{
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				// str += "<li>" + obj.fileName + "</li>";
				let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				str += "<li data-path ='"+obj.uploadPath+"' data-uuid ='"+obj.uuid+"' data-filename ='"+obj.fileName+"' data-type ='"+obj.image+"' ><div>";
				str += "<span>" +obj.fileName + "</span>";
				str += "<button type = 'button' data-file =\'" + fileCallPath + "\' data-type = 'image' class = 'btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src = '/display?fileName="+ fileCallPath + "'></a>";
				str += "</li></div>"
			}
		});
		uploadResult.append(str);
	}
	
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		let targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName : targetFile, type:type},
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'text',
			type : "POST",
			success : function(result){
				targetLi.remove();
			}
		})
	});
	
})

</script>
<%@ include file="../includes/footer.jsp" %>