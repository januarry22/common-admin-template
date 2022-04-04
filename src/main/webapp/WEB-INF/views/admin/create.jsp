<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="admin"/>
<c:set var="page_seq" value="admin_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>
<script>


    var idcheck = false;
    var passCheck = false;
    $(function(){

        /* id 중복 체크 */
        $(document).on("click", ".common_chk", function(){
            var admin_id = $("input[name=admin_id]");
            if(!$("#admin_id").val()){
                $("#admin_id").focus();
                return;
            }
            var param = {
                "table_name" : "${page}",
                "column_name":"id",
                "column_value": admin_id.val()
            }
            ajaxCallPost("/admin/v1/common/check", param, function(res){
                if(res.success){
                    showSwal('common-chk');
                }else{
                    showSwal('common-chk-success');
                    $("input[name=admin_id]").val(admin_id.val());
                    idcheck = true;
                }

            },function(){})
        })

        /* 회원가입 */
        $(document).on("click", ".save-btn", function(){
            var admin_id = $("input[name=admin_id]");
            var password = $("input[name=password]");
            var write_by = $("input[name=write_by]");
            var phone = $("input[name=phone]");
            var name = $("input[name=name]");
            var type = $("#type").val();

            if(idcheck==false){
                var text = "Email 중복체크를 진행해주세요.";
                showSwal('text-alert',text);
                $("#admin_id").focus();
                return;
            }
            if(passCheck==false){
                var text = "비밀번호를 다시입력해주세요.";
                showSwal('text-alert',text);
                $("#pw1").focus();
                return;
            }
            if($("#pw1").val() != $("#pw2").val() ){
                var text = "비밀번호를 확인해주세요. ";
                showSwal('text-alert',text);
                $("#pw1").focus();
                return;
            }

            if(!$("#phone").val()){
                var text = "연락처를 입력 해주세요. ";
                showSwal('text-alert',text);
                $("#phone").focus();
                return;
            }
            if(!$("#name").val()){
                var text = "이름을 입력 해주세요. ";
                showSwal('text-alert',text);
                $("#name").focus();
                return;
            }

            if(!$("#type").val()){
                var text = "권한을 입력 해주세요. ";
                showSwal('text-alert',text);
                $("#type").focus();
                return;
            }


            var param = {
                "admin_id" : admin_id.val(),
                "name" : name.val(),
                "password" : password.val(),
                "write_by": write_by.val(),
                "type" : type.val()
            }
            ajaxCallPost("/admin/v1/admin/create", param, function(res){
                if(res.success){
                    showSwal('success-insert-reload');
                }
            },function(){})
        })
    })




</script>



<!-- partial -->
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title"> 관리자 생성</h3>
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
                        <label class="login-label">관리자 ID</label>
                        <div class="form-group" style="display: flex;max-width: 400px;">
                            <input style="flex: 3;margin-right: 5px;" class="form-control" name="id" type="text">
                            <button type="button" class="btn btn-info common_chk">중복체크</button>
                        </div>
                        <div class="form-group">
                            <label class="login-label">비밀번호 </label>
                            <input class="form-control" name="password" type="password">
                        </div>
                        <div class="form-group">
                            <label class="login-label">비밀번호 확인</label>
                            <input class="form-control" name="password_check" type="password">
                        </div>
                        <div class="form-group">
                            <label class="login-label">이름</label>
                            <input class="form-control" name="name" type="text">
                        </div>
                        <div class="form-group">
                            <label class="login-label">연락처 </label>
                            <input class="form-control phone-inputmask" name="phone" type="text" placeholder="-없이 입력해주세요">
                        </div>
                        <div class="form-group">
                            <label class="login-label">권한  </label>
                            <select class="select2 form-select" id="type">
                                <option value="">마스터</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body button-body">
                        <button type="button" class="btn btn-primary btn-fw save-btn">저장 </button>
                        <button type="button" class="btn btn-danger btn-fw list_btn">취소 </button>
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