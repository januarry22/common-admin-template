<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="push"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>
<script>


    $(function(){

        $(document).on("click", ".save-btn", function(){
            var title =  $("input[name=title]").val();reserve_yn
            var push_type =  $("#push_type").val();
            var reserve_yn =  $("#reserve_yn").val();
            var company =  $("#company").val();
            var company_part =  $("#company_part").val();
            var content = $("textarea[name=content]").val();
            var write_by = $("input[name=write_by]");

            var param = {
                "title" : title,
                "push_type" : push_type,
                "reserve_yn" : reserve_yn,
                "company" : company,
                "company_part" : company_part,
                "content" : content,
                "write_by": write_by.val()
            }

            ajaxCallPost("/admin/v1/push/create", param, function(res){
                if(res.success){

                }

            },function(){})

        })
    })




</script>



<!-- partial -->
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title"> PUSH 전송</h3>
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
                            <label class="login-label" >제목</label>
                            <input class="form-control" name="title" type="text">
                        </div>
                        <div class="form-group">
                            <label class="login-label" >전송 기기</label>
                                <select class="select2 form-select" id="push_type">
                                    <option value="A">안드로이드</option>
                                    <option value="S">iOS</option>
                                    <option value="M">전체</option>
                                </select>
                        </div>
                        <div class="form-group">
                            <label class="login-label" >전송 타입</label>
                            <select class="select2 form-select" id="reserve_yn">
                                <option value="Y">예약</option>
                                <option value="N">실시간</option>
                            </select>
                        </div>

                        <div class="form-group" style="display: flex;justify-content: space-evenly;align-items: center;">
                            <label class="login-label" style="width: 15%;">회사</label>
                                <select class="select2 form-select" id="company" style="width: 50%;">
                                    <option value="Y">예약</option>
                                    <option value="N">실시간</option>
                                </select>
                            <label class="login-label" style="width: 15%;margin-left: 2%">조직 / 부서</label>
                                <select class="select2 form-select" id="company_part" style="width: 50%;">
                                    <option value="Y">예약</option>
                                    <option value="N">실시간</option>
                                </select>
                        </div>

                        <div class="form-group">
                            <label class="login-label">PUSH 내용 </label>
                            <textarea class="form-control" name="content"></textarea>
                        </div>
                    </div>
                    <div class="card-body button-body">
                        <button type="button" class="btn btn-primary save-btn">저장 </button>
                        <button type="button" class="btn btn-danger btn-fw list_btn">목록으로 </button>
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