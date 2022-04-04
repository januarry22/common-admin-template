<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="section"/>
<c:set var="page_seq" value="section_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<script>
    var passCheck = false;
    $(function(){

        /* 업종명  중복 체크 */
        $(document).on("click", ".common_chk", function(){
            var title = $("input[name=title]");
            if(!$("#title").val()){
                var text = "업종명을 입력 해주세요. ";
                showSwal('text-alert',text);
                $("#title").focus();
                return;
            }
            var param = {
                "table_name" : "${page}",
                "column_name":"title",
                "column_value": title.val()
            }
            ajaxCallPost("/admin/v1/common/check", param, function(res){
                if(res.success){
                    showSwal('common-chk');
                }else{
                    showSwal('common-chk-success');
                    $("input[name=title]").val(title.val());
                    passCheck = true;
                }

            },function(){})
        })

        /* 업종 생성 */
        $(document).on("click", ".create-btn-modal", function(){
            var title = $("input[name=title]");
            var comment = $("input[name=comment]");
            var write_by = $("input[name=write_by]");
            if(passCheck==false){
                $("#title").focus();
                return;
            }
            if(!$("#title").val()){
                $("#title").focus();
                return;
            }
            var param = {
                "title" : title.val(),
                "comment" : comment.val(),
                "write_by": write_by.val()
            }
            ajaxCallPost("/admin/v1/section/create", param, function(res){
                if(res.success){
                }
            },function(){})
        })
        /* 업종 수정 */
        $(document).on("click", ".update-btn-modal", function(){
            var title = $("input[name=update_title]");
            var comment = $("input[name=update_comment]");
            var write_by = $("input[name=write_by]");
            if(!$("#update_title").val()){
                $("#update_title").focus();
                return;
            }
            var param = {
                "title" : title.val(),
                "comment" : comment.val(),
                "write_by": write_by.val()
            }
            ajaxCallPost("/admin/v1/section/update", param, function(res){
                if(res.success){

                }
            },function(){})
        })
    })

</script>
<div class="row">
    <div class="card">
        <div class="card-body">
            <button  class="btn btn-success text-white create-modal" data-toggle="modal" data-target="#create-section"><i class="mdi mdi-note-plus-outline"></i>업종 추가</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">업종 관리</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>업종명</th>
                        <th>게시여부</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.name }</td>
                            <c:set var="seq" value="${item.section_seq}"/>
                            <%@ include file="/WEB-INF/views/common/showYn.jsp" %>
                            <td>
                                <button class="btn btn-info text-white update-modal" data-toggle="modal" data-target="#update-section" data-seq="${item.section_seq}">수정</button>
                                <button class="btn btn-danger remove-btn text-white" data-seq="${item.section_seq}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>


    <!-- 등록 모달 -->

    <div class="modal" id="create-section" style="display: none;">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel-3">업종 추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="create-section">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="forms-sample">
                        <label class="login-label">업종명</label>
                        <div class="form-group" style="display: flex;">
                            <input style="flex: 3;margin-right: 5px;" id="title" class="form-control" name="title" placeholder="업종명을 입력해주세요.">
                            <button style="" type="button" class="btn btn-info common_chk">중복체크</button>
                        </div>
                        <label class="login-label">설명</label>
                        <div class="form-group" style="display: flex;">
                            <input style="flex: 3;margin-right: 5px;" id="comment" class="form-control" name="comment" placeholder="설명을 입력해주세요.">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success create-btn-modal text-white">등록</button>
                    <button type="button" class="btn btn-danger text-white modal-cancel-btn" data-modal="create-section">취소</button>
                </div>
            </div>
        </div>
    </div>



        <!-- 수정 모달 -->

    <div class="modal" id="update-section" style="display: none;">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">업종 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="update-section">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="forms-sample">
                        <label class="login-label">업종명</label>
                        <div class="form-group" style="display: flex;">
                            <input style="flex: 3;margin-right: 5px;" id="update_title" class="form-control" name="update_title">
                        </div>
                        <label class="login-label">설명</label>
                        <div class="form-group" style="display: flex;">
                            <input style="flex: 3;margin-right: 5px;" id="update_comment" class="form-control" name="update_comment">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success update-btn-modal text-white">변경사항 저장</button>
                    <button type="button" class="btn btn-danger text-white modal-cancel-btn" data-modal="update-section">취소</button>
                </div>
            </div>
        </div>
    </div>
