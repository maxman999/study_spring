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
                               	<button type="submit" class="btn btn-default"><a href = '/board/list'>List</a></button>
                                <button type="reset" class="btn btn-default"><a href = '/board/modify?bno=<c:out value = "${board.bno}"/>' >Modify</a></button>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
          		  </div>
<%@ include file="../includes/footer.jsp" %>