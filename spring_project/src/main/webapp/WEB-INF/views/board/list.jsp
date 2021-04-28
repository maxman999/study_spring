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
                                        <td><a class = 'move' href= '<c:out value="${board.bno}"/>'>${board.title}</a></td>
                                        <td>${board.writer}</td>
                                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${board.regdate}"/></td>
                                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${board.updatedate}"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            <form id = 'searchForm' action="/board/list" method="get">
                            	<select name = "type">
                            		<option value = "" ${pageMaker.cri.type == null? "selected" : "" }>----</option>
                            		<option value = "T" ${pageMaker.cri.type eq 'T'? "selected" : "" }>제목</option>
                            		<option value = "C" ${pageMaker.cri.type eq 'C'? "selected" : "" }>내용</option>
                            		<option value = "W" ${pageMaker.cri.type eq 'W'? "selected" : "" }>작성자</option>
                            		<option value = "TC" ${pageMaker.cri.type eq 'TC'? "selected" : "" }>제목/내용</option>
                            		<option value = "TCW" ${pageMaker.cri.type eq 'TCW'? "selected" : "" }>제목/내용/작성자</option>
                            	</select>
                            	<input type = "text" name = 'keyword' value = ${pageMaker.cri.keyword}>
                            	<input type="hidden" name = "pageNum" value = "${pageMaker.cri.pageNum}">
                            	<input type="hidden" name = "amaunt" value = "${pageMaker.cri.amount}">
                            	<input type="hidden" name = "startNum" value = "${pageMaker.cri.startNum}">
                            	<button class = 'btn btn-default'>search</button> 
                            </form>
                            <div class = 'pull-right'>
                            	<ul class="pagination">
                            		<c:if test="${pageMaker.prev}">
	                            		<li class="page-item">
	     								 	<a class="page-link" href="${pageMaker.startPage - 1}" tabindex="-1">Previous</a>
	  									</li>
  									</c:if>
                            		<c:forEach begin="${pageMaker.startPage}" end = "${pageMaker.endPage}" var = "num">
                            			<li class="page-item ${pageMaker.cri.pageNum == num?"active":""}"><a class="page-link" href="${num}">${num}</a></li>
                            		</c:forEach>
                            		<c:if test="${pageMaker.next}">
	                            		<li class="page-item">
									      <a class="page-link" href="${pageMaker.endPage + 1}" tabindex="-1">Next</a>
									    </li>
								    </c:if>
                            	</ul>
                            </div>
                            <form id = "actionForm" action="/board/list" method="get">
                            	<input type="hidden" name = "pageNum" value = "${pageMaker.cri.pageNum}">
                            	<input type="hidden" name = "amaunt" value = "${pageMaker.cri.amount}">
                            	<input type="hidden" name = "startNum" value = "${pageMaker.cri.startNum}">
                            	<input type="hidden" name = "type" value = "${pageMaker.cri.type}">
                            	<input type="hidden" name = "keyword" value = "${pageMaker.cri.keyword}">
                            </form>
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
		
		/* 브라우저에 저장된 데이터 초기화(뒤로가기 문제 해결) */
		history.replaceState({}, null, null);	
		
		function checkModal(result){
			if (result === '' || history.state){
				return;
			}
			
			if (parseInt(result) > 0){
				 document.getElementById("modal-text").innerText = "게시글" + parseInt(result) + "번이 등록되었습니다.";
			}else if (result === 'success'){
				 document.getElementById("modal-text").innerText = "정상적으로 처리 되었습니다.";
			}
			$("#myModal").modal("show");
		}
		
		document.getElementById("regBtn").addEventListener('click', () => {
			location.href="/board/register";
		});
		
		let actionForm = $("#actionForm");
		$(".page-link").on("click", function(e){
			e.preventDefault();
			let targetPage = $(this).attr("href");
			console.log(targetPage);
			actionForm.find("input[name='pageNum']").val(targetPage);
			actionForm.find("input[name='startNum']").val((targetPage-1)*10);
			actionForm.submit();
		});
		
		/* 게시물을 조회 했을 때 해당 게시글의 위치를 url에 따라 붙게 해주는 작업.  */
		$(".move").on("click", function(e){
			e.preventDefault();
			var targetBno = $(this).attr("href");
			console.log(targetBno);
			actionForm.append("<input type = 'hidden' name = 'bno' value = '" + targetBno + "'>'" );
			actionForm.attr("action", "/board/get")
			actionForm.submit();
		})
		
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			e.preventDefault();
			searchForm.find("input[name='pageNum']").val(1);
			searchForm.submit();
		})
	
	};
</script>
          		  
          		  
<%@ include file="../includes/footer.jsp" %>