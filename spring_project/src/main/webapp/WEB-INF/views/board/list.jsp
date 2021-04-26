<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
                <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            DataTables Advanced Tables
                            <button id = 'regBtn' type = "button" class = "btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>BNO</th>
                                        <th>Title</th>
                                        <th>Writer</th>
                                        <th>RegDate</th>
                                        <th>UpdateDate</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items = "${boardList}" var = "board">
                                    <tr class="odd gradeX">
                                        <td>${board.bno}</td>
                                        <td>${board.title}</td>
                                        <td>${board.writer}</td>
                                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${board.regdate}"/></td>
                                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${board.updatedate}"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
          		  </div>

<!-- modal  -->
<div id="myModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id = "modal-text">Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- /modal  -->

<script>
	window.onload = function(){
		let result = '<c:out value = "${result}" />'
		
		checkModal(result);
		
		function checkModal(result){
			if (result === ''){
				return;
			}
			if (parseInt(result) > 0){
				 document.getElementById("modal-text").innerText = "게시글" + parseInt(result) + "번이 등록되었습니다."
			}
			$("#myModal").modal("show");
		}
		
		document.getElementById("regBtn").addEventListener('click', () => {
			location.href="/board/register";
		});
	};
</script>
          		  
          		  
<%@ include file="../includes/footer.jsp" %>