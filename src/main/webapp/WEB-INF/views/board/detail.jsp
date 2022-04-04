<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="board"/>
<c:set var="page_seq" value="board_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>
<script>


$(function(){
	 var up_code="${detail.up_code}";
	 var info_code="${detail.info_code}";
	 $(document).on("click", ".category_list", function(){
		$('#dropdownMenuButton1').text($(this).text());
		up_code=$(this).attr('data-up-code');
		info_code=$(this).attr('data-info-code');
     });
	 $(document).on("click", ".save-btn", function(){
		var title = $("input[name=title]");
		var content = CKEDITOR.instances['content'].getData();
		var write_by = $("input[name=write_by]");
		var board_seq = "${detail.board_seq}";
	
		var param = {
			"board_seq" : board_seq,
			"title" : title.val(),
			"content" : content,
			"write_by": write_by.val(),
			"up_code" : up_code,
			"info_code" : info_code
		}
		
 	  	ajaxCallPost("/supervise/admin/v1/board/update", param, function(res){
				if(res.success){
					showSwal('success-update','${page}');
					
				}
		},function(){})   
	 });
})





</script>



  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
              <h3 class="page-title"> 게시글 수정 </h3>
              <nav aria-label="breadcrumb">
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
                    <!--     <label class="login-label" for="dropdownMenuButton1">분류</label> -->
                       <!--  <input type="text" name="category"  class="form-control board-input" id="exampleInputEmail1"> -->
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 25%;" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${detail.type_info}</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <c:forEach var="item" items="${category }">
                          <a class="dropdown-item category_list" data-up-code="${item.up_code}" data-info-code="${item.info_code}">${item.name}</a>
                          </c:forEach>
                       	</div>
                      </div>
                     <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">제목</label>
                        <input type="text" class="form-control board-input" id="exampleInputUsername1" name="title" value="${detail.title}">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="tinyMceExample">내용 </label>
                      	<%@ include file="/WEB-INF/views/common/ckEditor_detail.jsp" %>
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