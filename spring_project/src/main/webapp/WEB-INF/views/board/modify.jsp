<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
                <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify/Delete</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
							Board Modify/Delete
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form>
                       		 <div class="form-group">	
                                <label>BNO</label>
                                <input class="form-control" name = "bno" readonly = "readonly" value = '<c:out value = "${board.bno}" />'>
                             </div>
							 <div class="form-group">	
                                <label>Title</label>
                                <input class="form-control" name = "title" value = '<c:out value = "${board.title}" />'>
                             </div>
                             <div class="form-group">
                             	<label>Content</label>
                                <textarea class="form-control" name = "content" rows="5" cols="50"><c:out value = "${board.content}" /></textarea>
                             </div>
                             <div class="form-group">
                               	<label>Writer</label>
                               	<input class="form-control" name = "writer" readonly = "readonly" value='<c:out value = "${board.writer}" />'>
                             </div>
                             	<!-- data-oper : 커스텀 데이터 속성  -->
                               	<button class="btn btn-default" data-oper = 'modify'>Modify</button>
                                <button class="btn btn-danger" data-oper = 'remove'>Remove</button>
                        		<button class="btn btn-info" data-oper = 'list'>List</button>
                        	</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
          		  </div>
          		  
<script>
$(document).ready(function(){
	var formObj = $("form");
	/* 분기에 따라서 GET 혹은 POST 방식으로 처리하기.  */
	$('.btn').click(function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation === 'list'){
			self.location = "/board/list"
		}else if(operation === 'remove'){
			formObj.attr("action", "/board/remove").attr("method", "post")
			formObj.submit();
		}else if(operation === 'modify'){
			formObj.attr("action", "/board/modify").attr("method", "post")
			formObj.submit();}
		})});
</script>          		  

<%@ include file="../includes/footer.jsp" %>