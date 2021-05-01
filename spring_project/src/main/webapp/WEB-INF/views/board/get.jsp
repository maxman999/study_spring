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
            <div class = 'row'>
            	<div class = "col-lg-12">
            		<!-- /.pannel  -->
            		<div class = "panel panel-default">
            			<div class = "panel-heading">
            				<i class = "fa fa-comments fa-fw"></i> Reply
            				<button id = "addReplyBtn" class = 'btn btn-primary btn-xs pull-right'> New Reply</button>
            			</div>
            		<!-- /.panel-heading -->
            			<div class = "panel-body">
            				<ul class = "chat">
                    			<!-- start reply  -->    	
        	                	<li class = "left clearfix" data-rno = '12'>
        	                		<div>
        	                			<div class = "header">
        	                				<strong class = "primary-font">user00</strong>
        	                				<small class = "pull-right text-muted">2018-01-01</small>     			
        	                			</div>
        	                			<p>Good Job!</p>
        	                		</div>
        	                	</li>
        	                	<!-- end reply  -->
            	            </ul>
            	            <!-- ./ end ul  -->
            			</div>
            			<!-- /.pannel .chat-pannel -->
            		</div>
				</div>
			</div>
				<!-- ./ end row  -->
          		  </div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
            </div>
            <div class="modal-body">
            	<div class = "form-group">
            		<label> Reply </label>
            		<input class = "form-control" name = 'reply' value = "new reply!">
             	</div>
             	<div class = "form-group">
            		<label> Replyer </label>
            		<input class = "form-control" name = 'replyer' value = "replyer!">
             	</div>
             	<div class = "form-group">
            		<label> Reply Date </label>
            		<input class = "form-control" name = 'replydate' value = "">
             	</div>
            </div>
            <div class="modal-footer">
            	<button id = 'modalModBtn' type = "button" class = "btn btn-warning">Modify</button>
            	<button id = 'modalRemoveBtn' type = "button" class = "btn btn-warning">Remove</button>
                <button id = 'modalRegisterBtn' type="button" class="btn btn-default" data-dismiss="modal">Register</button>
                <button id = 'modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script src="/resources/js/reply.js"></script>


<script>
$(document).ready(function(){
	let bnoValue = '<c:out value = "${board.bno}"/>';
	let replyUL = $(".chat");
	
	showList(1);
	
	function showList(page){
		replyService.getList({bno:bnoValue, page:page||1}, function(list){
			let str = "";
			if(list == null || list.length == 0){
				replyUL.html("");
				return;
			}
			for (var i = 0, len = list.length || 0; i < len; i++){
				str += "<li class = 'left clearfix' data-rno = '"+list[i].rno+"'>";
				str += "	<div><div class = 'header'><strong class = 'primary-font'>"+list[i].replyer+"</strong>";
				str += "<small class = 'pull-right text-muted'>" + replyService.displayTime(list[i].replydate)+"</small></div>"
				str += "	<p>"+list[i].reply + "</p></div></li>";
			}
			replyUL.html(str);
			}); //end function
		
	}//end showList
	
	let modal = $(".modal");
	let modalInputReply = modal.find("input[name = 'reply']");
	let modalInputReplyer = modal.find("input[name = 'replyer']");
	let modalInputReplyDate = modal.find("input[name = 'replydate']");
	
	let modalModBtn = $("#modalModBtn");
	let modalRemoveBtn = $("#modalRemoveBtn");
	let modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBTn']").hide();
		
		modalRegisterBtn.show();
		$(".modal").modal("show");
		
		modalRegisterBtn.on("click", function(e){
			let reply = {
					reply: modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(1);
			});
		});
	});
	
	$(".chat").on("click", "li", function(e){
		let rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply)
			modalInputReplyer.val(reply.replyer)
			modalInputReplyDate.val(replyService.displayTime(reply.replydate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
		
		modalModBtn.on("click", function(e){
			let reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			let rno = modal.data("rno");
			replyService.remove(rno,function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		
		
	});
	
	
	
});	
</script>


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