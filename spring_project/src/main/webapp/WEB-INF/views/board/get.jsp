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
                                <sec:authentication property="principal" var = "pinfo"/>
                                <sec:authorize access="isAuthenticated()">
                                <c:if test="${pinfo.username eq board.writer}">
                                <button type="button" class="btn btn-default modifyBtn"><a href = '/board/modify?bno=<c:out value = "${board.bno}"/>' >Modify</a></button>
                        		</c:if>
                                </sec:authorize>
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
            				<sec:authorize access="isAuthenticated()">
            				<button id = "addReplyBtn" class = 'btn btn-primary btn-xs pull-right'> New Reply</button>
            				</sec:authorize>
            			</div>
            		<!-- /.panel-heading -->
            			<div class = "panel-body">
            				<ul class = "chat">
                    			<!-- start reply  -->    	
        	                	<li class = "left clearfix" data-rno = '12'>
        	                		<div>
        	                			<div class = "header">
        	                				<strong class = "primary-font">--------</strong>
        	                				<small class = "pull-right text-muted">---------</small>     			
        	                			</div>
        	                			<p>처음으로 댓글을 등록해보세요!</p>
        	                		</div>
        	                	</li>
        	                	<!-- end reply  -->
            	            </ul>
            	            <!-- ./ end ul  -->
            			</div>
            			<!-- /.pannel .chat-pannel -->
            			<div class = "panel-footer">
            			</div>
            		</div>
				</div>
			</div>
			<div class = 'bigPictureWrapper'>
				<div class = 'bigPicture'>
				</div>
			</div> <!-- /. bigPictureWrapper  -->
			<!-- 첨부파일  -->
			<div class = "row">
				<div class = "col-lg-12">
					<div class = "panel panel-default">
						<div class = "panel-heading">Files</div>
							<!-- /. panel-heading  -->
							<div class = "panel-body">
								<div class = "uploadResult">
									<ul>
									</ul>
								</div>
							</div>
					</div>
				</div>
				<!-- /. end panel  -->
			</div> 
			<!-- /.row  -->
			
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
            		<input class = "form-control" name = 'replyer' value = "replyer!" readonly="readonly">
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
		replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
			if(page == -1){
				pageNum = Math.ceil((replyCnt)/10);
				showList(pageNum);
				return;	
			}
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
			showReplyPage(replyCnt);
			}); //end function
			
	}//end showList
	
	let modal = $(".modal");
	let modalInputReply = modal.find("input[name = 'reply']");
	let modalInputReplyer = modal.find("input[name = 'replyer']");
	let modalInputReplyDate = modal.find("input[name = 'replydate']");
	
	let modalModBtn = $("#modalModBtn");
	let modalRemoveBtn = $("#modalRemoveBtn");
	let modalRegisterBtn = $("#modalRegisterBtn");
	
	let replyer = null;
	<sec:authorize access = "isAuthenticated()">
	replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBTn']").hide();
		modalRegisterBtn.show();
		$(".modal").modal("show");
		
		//ajax spring security header 
		$(document).ajaxSend(function(e,xhr,options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
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
				showList(-1);
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
			let originalReplyer = modalInputReplyer.val();
			let reply = {rno:modal.data("rno"), reply:modalInputReply.val(), replyer:originalReplyer};
			if(!replyer){
				alert("로그인 후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			$(document).ajaxSend(function(e,xhr,options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			let rno = modal.data("rno");
			if(!replyer){
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			let originalReplyer = modalInputReplyer.val();
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			} 
			$(document).ajaxSend(function(e,xhr,options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});
			replyService.remove(rno,originalReplyer,function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
	});
	
	var pageNum = 1;
	let replyPageFooter = $(".panel-footer");
	function showReplyPage(replyCnt){
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		let prev = startNum != 1;
		let next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil((replyCnt)/10);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		let str = "<ul class = 'pagination pull-right'>";
		if (prev){
			str += "<li class = 'page-item'><a class = 'page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		for (var i = startNum ; i <= endNum ; i++){
			let active = pageNum == i? "active":"";
			str += "<li class = 'page-item " + active + "'><a class = 'page-link' href='"+i+"'>"+i+"</a></li>";
			
		}
		if (next){
			str+= "<li class = 'page-item'><a class = 'page-link' href = '"+(endNum + 1) + "'>Next</a></li>";
		}
		str += "</ul></div>";
		console.log(str);
		replyPageFooter.html(str);
		
	}
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		let targetPageNum = $(this).attr("href");
		console.log("targetPageNum : " + targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
	(function(){
		let bno = '<c:out value = "${board.bno}"/>';
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
			console.log(arr);
			let str = "";
			$(arr).each(function(i, attach){
				if(!attach.filetype){
					str += "<li data-path ='"+attach.uploadpath+"' data-uuid ='"+attach.uuid+"' data-filename ='"+attach.filename+"' data-type ='"+attach.filetype+"'><div>";
					str += "<span>" +attach.filename + "</span>";
					str += "<img src = '/resources/img/attach.png'></a>";
					str += "</div></li>"
				//image type
				}else{
					let fileCallPath = encodeURIComponent(attach.uploadpath + "/s_" + attach.uuid + "_" + attach.filename);
					str += "<li data-path ='"+attach.uploadpath+"' data-uuid ='"+attach.uuid+"' data-filename ='"+attach.filename+"' data-type ='"+attach.filetype+"' ><div>";
					str += "<img src = '/display?fileName="+ fileCallPath + "'></a>";
					str += "</li></div>"
				}
			});
			$(".uploadResult ul").html(str);
		});
	})();
	
	$(".uploadResult").on("click", "li", function(e){
		console.log("view image");
		let liObj = $(this);
		let path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			//download
			self.location = "/download?fileName="+path
		}
	});
	
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture")
			.html("<img src = '/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height : '100%'}, 1000) 
	}
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width: "0%", height: "0%"}, 1000);
		setTimeout(()=>{
			$(this).hide();
		},1000);
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