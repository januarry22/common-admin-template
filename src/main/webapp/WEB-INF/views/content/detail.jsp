<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="content"/>
<script>

var type_seq = "${detail.type_seq}";

var code_name = "${detail.code_name}";
var code_number = "${detail.code_number}";
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
	 $(document).on("click", ".save-btn", function(){
		var write_by = $("input[name=write_by]");
		var title = $("input[name=title]");
		var content_seq = "${detail.content_seq}";
		var img_seq = $("input[name=img_url]");
	/* 	var gif_seq = $("input[name=gif_url]"); */
		var play_time = $("input[name=play_time]");
		
		var param = {
			"title" :title.val(),
			"content_seq" : content_seq,
			"video_seq" : img_seq.val(),
			"code_name" : code_name,
			"code_number" : code_number,
/* 			"gif_seq" : gif_seq.val(), */
			"play_time" : play_time.val(),
			"write_by": write_by.val(),
			"type_seq" : type_seq
		}
		
 	  	ajaxCallPost("/supervise/admin/v1/content/update", param, function(res){
				if(res.success){
					showSwal('success-update-reload');
				}
		},function(){})   
	 });

		/* img 업로드 */
			$(".img_fun").change(function(){
				ajaxUpload($(".img_fun")[0].files[0], "content_update", function(data_url) {
					$("input[name=img_url]").val(data_url);
				})
			})
				/* img 업로드 */
	/* 	$(".gif_fun").change(function(){
			ajaxUpload($(".gif_fun")[0].files[0], "contents_gif", function(data_url) {
				$("input[name=gif_url]").val(data_url);
			})
		}) */
})





</script>

  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
              <h3 class="page-title">청각화 컨텐츠 수정 </h3>
              <nav aria-label="breadcrumb">
              <button type="button" class="btn btn-outline-light btn-fw cancel-btn" onclick="history.back(-1)">Back </button>
              <!--   <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="#">Tables</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Data table</li>
                </ol> -->
              </nav>
            </div>
             <div class="row grid-margin">
            <div class="col-lg-12">
            <div class="card">
                <div class="card">
                
                  <div class="card-body">
                    <h4 class="card-title">작성일 : ${detail.create_dt_yyyymmdd}</h4>
					<input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
					<div class="form-group">
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 25%;" type="button" id="sleep_type" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${detail.type}</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <c:forEach var="item" items="${type }">
                          <a class="dropdown-item sleep_type" data-value="${item.type_seq}">${item.name}</a>
                          </c:forEach>
                       	</div>
                      </div>
                     <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">제목</label>
                        <input type="text" class="form-control login_input" id="exampleInputUsername1" name="title" value="${detail.title}">
                      </div>
                    <div class="form-group">
                        <label class="login-label" for="title">속성(영역)</label>
                       </div>
                       <div style="display:flex;justify-content: space-evenly;">
                       <div class="form-group">
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 100%;" type="button" id="code_name" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${detail.code_name}</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <a class="dropdown-item code_name" data-value="WS">WS</a>
        				  <a class="dropdown-item code_name" data-value="WH">WH</a>
        				  <a class="dropdown-item code_name" data-value="CS">CS</a>
        				  <a class="dropdown-item code_name" data-value="CH">CH</a>
                        </div>
                        </div>
                       <div class="form-group">
                         <button class="btn btn-info dropdown-toggle form-group" style="width: 100%;" type="button" id="code_number" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${detail.code_number}</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <a class="dropdown-item code_number" data-value="1">1</a>
        				  <a class="dropdown-item code_number" data-value="2">2</a>
        				  <a class="dropdown-item code_number" data-value="3">3</a>
        				  <a class="dropdown-item code_number" data-value="4">4</a>
                        </div>
                      </div>
                      </div>
          <%--                 <div class="form-group">
                        <label for="gif_url">gif 파일</label>
                         <input type="hidden" name="gif_url" value="${detail.gif_seq}"/>
                         <input type="file" class="dropify gif_fun" data-default-file="${detail.gif_file_url}" id="img_val"/>
                      </div> --%>
                      <div class="form-group">
                        <label for="img_url">컨텐츠 파일</label>
                         <input type="hidden" name="img_url" value="${detail.video_seq}"/>
                         <input type="file" class="dropify img_fun" data-default-file="${detail.file_url}" id="img_val"/>
                      </div>
                        <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">컨텐츠 재생 시간 ( * 컨텐츠 업로드 시 자동 추출 되므로 임의 변경이 불가능합니다.)</label>
                        <input type="text" class="form-control login_input" id="exampleInputUsername1" name="play_time" value="${detail.play_time}" disabled="disabled" style="background: black;">
                      </div>
                  </div>
                   <div class="card-body button-body">
	                 <button type="button" class="btn btn-primary btn-fw save-btn">Save </button>
	                <button type="button" class="btn btn-danger btn-fw cancel-btn" onclick="history.back(-1)">Cancel </button>
	                </div>
                </div>
               
            </div>
          </div>
            </div>
            
             <div class="row grid-margin">
            <div class="col-lg-12">
            
             </div>
            </div>
          </div>