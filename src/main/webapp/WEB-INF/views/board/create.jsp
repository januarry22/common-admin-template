<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="board"/>
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
		var title =  $("input[name=title]").val();
		var content = CKEDITOR.instances['content'].getData();
		var write_by = $("input[name=write_by]");
	
		var param = {
			"title" : title,
			"content" : content,
			"write_by": write_by.val(),
			"up_code" : up_code,
			"info_code" : info_code
		}
		
 	  	ajaxCallPost("/supervise/admin/v1/board/create", param, function(res){
				if(res.success){
					showSwal('success-insert','${page}');
				}
		
		},function(){})   

})
})




</script>



  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
              <h3 class="page-title"> 게시글 작성</h3>
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
                    <h4 class="card-title"></h4>
					<input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
                     <div class="form-group">
                    <!--     <label class="login-label" for="dropdownMenuButton1">분류</label> -->
                       <!--  <input type="text" name="category"  class="form-control board-input" id="exampleInputEmail1"> -->
                      <button class="btn btn-info dropdown-toggle form-group" style="width: 25%;" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">선택해주세요.</button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        				  <c:forEach var="item" items="${category }">
                          <a class="dropdown-item category_list" data-up-code="${item.up_code}" data-info-code="${item.info_code}">${item.name}</a>
                          </c:forEach>
                       	</div>
                      </div>
                     <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">제목</label>
                        <input class="form-control" name="title" type="text">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="tinyMceExample">내용 </label>
                 			<c:set var="text_content" value="content"/>
							<c:set var="height" value="300"/>
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