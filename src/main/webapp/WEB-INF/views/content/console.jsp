<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="sleep_console"/>
<c:set var="page_seq" value="console_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<script>


$(function(){
	 $(document).on("click", ".save-btn", function(){
		var title = $("input[name=title]");
		//var content = CKEDITOR.instances['content'].getData();
		var content = $("textarea[name=content]").val();
		var write_by = $("input[name=write_by]");
	
		var param = {
			"title" : title.val(),
			"content" : content,
			"write_by": write_by.val()
		}
		
 	  	ajaxCallPost("/supervise/admin/v1/content/console_create", param, function(res){
				if(res.success){
					showSwal('success-insert-reload');
				}
		
		},function(){})   
	})
	$(document).on("click", ".update-set-btn", function(){
		var seq = $(this).attr("data-seq");
	
 	  	ajaxCallGet("/supervise/admin/v1/content/console_detail?seq="+seq, function(res){
				if(res.success){
					var data = res.data;
					$("input[name=update_title]").val(data.title);
					$("input[name=console_seq]").val(data.console_seq);
					$("textarea[name=update_content]").val(data.content);
					//CKEDITOR.instances['update_content'].setData(data.content);
				}
		
		},function(){})   
	})
	$(document).on("click", ".save-update-btn", function(){
		var console_seq = $("input[name=console_seq]");
		var title = $("input[name=update_title]");
		//var content = CKEDITOR.instances['content'].getData();
		var content = $("textarea[name=update_content]").val();
		var write_by = $("input[name=write_by]");
		
		var param = {
				"title" : title.val(),
				"content" : content,
				"console_seq" : console_seq.val(),
				"write_by": write_by.val()
			}
			
		ajaxCallPost("/supervise/admin/v1/content/console_update", param, function(res){
			if(res.success){
				showSwal('success-update-reload');
			}
		},function(){})   
	})
})




</script>

  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
               <span class="page-title"> 수면위로 컨텐츠 관리 </span>
					<input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
          		 <button type="button" class="btn btn-info btn-rounded btn-fw" data-toggle="modal" data-target="#content_create">+ 추가하기</button>
            </div>
            <div class="card">
              <div class="card-body">
               <!--  <h4 class="card-title">공지사항 / 이벤트</h4> -->
                <div class="row">
                  <div class="col-12">
                    <div class="table-responsive">
                      <table id="order-listing" class="table">
                        <thead>
                          <tr>
                            <th>No.</th>
                        <!--     <th>제목</th> -->
                            <th>내용</th>
                            <th>관리</th>
                          </tr>
                        </thead>
                        <tbody>
        				  <c:forEach var="item" items="${list }">
                          <tr style="width: 100%">
                            <td style="width: 8%;"><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                        <%--     <td style="width: 15%;">${item.title }</td> --%>
                            <td style="height: 100px; max-height: 100px;overflow-y: scroll; display: block">${item.content }</td>
                            <td style="width: 10%; max-width: 100px">
                              <button class="btn btn-info update-set-btn" data-toggle="modal" data-target="#content_update" data-seq="${item.console_seq}">수정</button>
                              <button class="btn btn-danger remove-btn" data-seq="${item.console_seq}">삭제</button>
                            </td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
      <div class="modal fade" id="content_create" tabindex="-1" role="dialog" aria-labelledby="#content_create" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="#content_create">수면 위로 컨텐츠 추가</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                     
                     <div class="form-group">
                        <label class="login-label" for="sub_content"> 내용 </label>
                 			<c:set var="text_content" value="content"/>
							<c:set var="height" value="20"/>
                      		<%@ include file="/WEB-INF/views/common/ckEditor.jsp" %>
                      </div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-success save-btn">등록</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                 <div class="modal fade" id="content_update" tabindex="-1" role="dialog" aria-labelledby="#content_update" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="#content_create">컨텐츠 수정</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                          <form class="forms-sample">
                        <input type="hidden" name="console_seq"  class="form-control login_input">
                  <!--     <div class="form-group">
                        <label class="login-label" for="title">제목</label>
                        <input type="text" id="pw1" name="update_title"  class="form-control login_input">
                      </div> -->
                     <div class="form-group">
                        <label class="login-label" for="sub_content"> 내용 </label>
                 			<c:set var="text_content" value="update_content"/>
							<c:set var="height" value="20"/>
                      		<%@ include file="/WEB-INF/views/common/ckEditor.jsp" %>
                      </div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-success save-update-btn">등록</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>