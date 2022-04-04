<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="content_eye"/>
<c:set var="page_seq" value="eye_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<script>


$(function(){
	 $(document).on("click", ".sleep_type", function(){
			$('#sleep_type').text($(this).text());
			type_seq=$(this).attr('data-value');
	 });
	 $(document).on("click", ".code_name", function(){
			$('#code_name').text($(this).text());
			code_name=$(this).attr('data-value');
	 });
	 $(document).on("click", ".code_number", function(){
			$('#code_number').text($(this).text());
			code_number=$(this).attr('data-value');
	 });

	 $(document).on("click", ".detail-vision-btn", function(){
	       var seq = $(this).attr("data-seq");
	       location.href="/admin/content/vision/"+seq;
	 });
	 $(document).on("click", ".save-btn", function(){
		var title = $("input[name=title]");
		var write_by = $("input[name=write_by]");
		var img_seq = $("input[name=img_url]");
	
		var param = {
			"title" : title.val(),
			"code_name" : code_name,
			"code_number" : code_number,
			"write_by": write_by.val(),
			"eye_file_seq" : img_seq.val()
		}
		
 	  	ajaxCallPost("/supervise/admin/v1/content/eye_create", param, function(res){
				if(res.success){
					showSwal('success-insert-reload');
				}
		
		},function(){})   
		})
		/* img 업로드 */
		$(".img_fun").change(function(){
			ajaxUpload($(".img_fun")[0].files[0], "contents_eye", function(data_url) {
				$("input[name=img_url]").val(data_url);
			})
		})
})




</script>

  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
               <span class="page-title"> 수면 시각화 컨텐츠 관리 </span>
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
                       <!--      <th>수면유형</th> -->
                            <th>제목</th>
                            <th>속성</th>
                            <th>관리</th>
                          </tr>
                        </thead>
                        <tbody>
        				  <c:forEach var="item" items="${list }">
                          <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.title }</td>
                   <%--          <td>${item.type }</td> --%>
                            <td>${item.code}</td>
                            <td>
                              <button class="btn btn-info detail-vision-btn" data-toggle="modal" data-target="#content_update" data-seq="${item.eye_seq}">수정</button>
                              <button class="btn btn-danger remove-btn" data-seq="${item.eye_seq}">삭제</button>
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
                            <h5 class="modal-title" id="#content_create">컨텐츠 추가</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                    <%--   <div class="form-group">
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 25%;" type="button" id="sleep_type" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">선택해주세요.</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <c:forEach var="item" items="${type }">
                          <a class="dropdown-item sleep_type" data-value="${item.type_seq}">${item.name}</a>
                          </c:forEach>
                       	</div>
                      </div> --%>
                       <div class="form-group">
                        <label class="login-label" for="title">속성(영역)</label>
                       </div>
                       <div style="display:flex;justify-content: space-evenly;">
                       <div class="form-group">
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 100%;" type="button" id="code_name" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">선택해주세요.</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <a class="dropdown-item code_name" data-value="WS">WS</a>
        				  <a class="dropdown-item code_name" data-value="WH">WH</a>
        				  <a class="dropdown-item code_name" data-value="CS">CS</a>
        				  <a class="dropdown-item code_name" data-value="CH">CH</a>
                        </div>
                        </div>
                       <div class="form-group">
                         <button class="btn btn-info dropdown-toggle form-group" style="width: 100%;" type="button" id="code_number" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">선택해주세요.</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <a class="dropdown-item code_number" data-value="1">1</a>
        				  <a class="dropdown-item code_number" data-value="2">2</a>
        				  <a class="dropdown-item code_number" data-value="3">3</a>
        				  <a class="dropdown-item code_number" data-value="4">4</a>
                        </div>
                      </div>
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="title">제목</label>
                        <input type="text" id="pw1" name="title"  class="form-control login_input">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="exampleInputPassword1">파일 </label>
                         <input type="hidden" name="img_url"/>
                         <input type="file" class="dropify img_fun" id="img_val"/>
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
             