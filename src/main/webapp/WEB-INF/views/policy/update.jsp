<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="policy"/>
<script>


    $(function(){

        $(document).on("click", ".save-btn", function(){
            var title =  $("input[name=title]").val();
            var content = CKEDITOR.instances['content'].getData();
            var write_by = $("input[name=write_by]");
            var type = $("#type").val();

            var param = {
                "title" : title,
                "content" : content,
                "write_by": write_by.val(),
                "type" : type
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
        <h3 class="page-title"> 약관 등록 </h3>
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
                        <div class="form-group" style="display: flex;">
                            <label class="login-label">구분</label>
                            <select id="type" class="form-control">
                                <option>${detail.type}</option>
                                <option value="">1</option>
                                <option>1</option>
                                <option>1</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="login-label" >제목</label>
                            <input class="form-control" name="title" type="text" value="${detail.title}">
                        </div>
                        <div class="form-group">
                            <label class="login-label" >내용 </label>
                            <c:set var="text_content" value="${detail.content}"/>
                            <c:set var="height" value="300"/>
                            <%@ include file="/WEB-INF/views/common/ckEditor_detail.jsp" %>
                        </div>
                    </div>
                    <div class="card-body button-body">
                        <button type="button" class="btn btn-primary btn-fw save-btn">변경사항 저장 </button>
                        <button type="button" class="btn btn-danger btn-fw list_btn" >목록으로 </button>
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