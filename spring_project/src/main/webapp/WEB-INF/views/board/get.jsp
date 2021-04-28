<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
                <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
							Board Read
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                       		 <div class="form-group">	
                                <label>BNO</label>
                                <input class="form-control" name = "title" readonly = "readonly" value = '<c:out value = "${board.bno}" />'>
                             </div>
							 <div class="form-group">	
                                <label>Title</label>
                                <input class="form-control" name = "title" readonly = "readonly" value = '<c:out value = "${board.title}" />'>
                             </div>
                             <div class="form-group">
                             	<label>Content</label>
                                <textarea class="form-control" rows="5" cols="50" name = "content" readonly = "readonly"><c:out value = "${board.title}" /></textarea>
                             </div>
                             <div class="form-group">
                               	<label>Writer</label>
                               	<input class="form-control" name = "writer" readonly = "readonly" value='<c:out value = "${board.writer}" />'>
                             </div>
                             	 <form id = "actionForm" action="/board/list" method="get">
                            		<input type="hidden" name = "pageNum" value = "${cri.pageNum}">
                            		<input type="hidden" name = "amaunt" value = "${cri.amount}">
                            		<input type="hidden" name = "startNum" value = "${cri.startNum}">
                            		<input type="hidden" name = "bno" value = "${board.bno}">
                            		<input type="hidden" name = "type" value = "${cri.type}">
                            		<input type="hidden" name = "keyword" value = "${cri.keyword}">
                           		</form>
                               	<button type="button" class="btn btn-default listBtn"><a href = '/board/list'>List</a></button>
                                <button type="button" class="btn btn-default modifyBtn"><a href = '/board/modify?bno=<c:out value = "${board.bno}"/>' >Modify</a></button>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
          		  </div>
<script>
window.onload = function(){
	
	let actionForm = $("#actionForm")
	$(".listBtn").click(function(e){
		e.preventDefault();	
		actionForm.find("input[name = 'bno']").remove();
		actionForm.submit();
	})
	$(".modifyBtn").click(function(e){
		e.preventDefault();	
		actionForm.attr("action", "/board/modify");
		actionForm.submit();
	})
	
	
};
</script>
<%@ include file="../includes/footer.jsp" %>