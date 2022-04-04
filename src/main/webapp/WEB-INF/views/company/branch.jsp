<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="company_branch"/>
<c:set var="page_seq" value="company_branch_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<script>
    $(function(){

        /* 회사 지점별 부서 목록 이동*/
        $(document).on("click", ".part-btn", function(){
            location.href="/admin/company/company_branch/"+$(this).attr('data-seq');
        })
        /* 회사 지점 생성 */
        $(document).on("click", ".create-btn-modal", function(){
            var title = $("input[name=title]");
            var comment = $("input[name=comment]");
            var write_by = $("input[name=write_by]");
            var member_seq = $("input[name=member_seq]");

            if(!$("#title").val()){
                $("#title").focus();
                return;
            }
            var param = {
                "title" : title.val(),
                "member_seq" : member_seq.val(),
                "comment" : comment.val(),
                "write_by": write_by.val(),
                "payment_yn": "N"             // 관리자 생성시에는 'N'
            }
            ajaxCallPost("/admin/v1/board_section/create", param, function(res){
                if(res.success){
                }
            },function(){})
        })
        /* 회사 지점 정보 수정 */
        $(document).on("click", ".update-btn-modal", function(){
            var name = $("input[name=update_name]");
            var comment = $("input[name=update_comment]");
            var write_by = $("input[name=write_by]");
            if(!$("#update_name").val()){
                $("#update_name").focus();
                return;
            }
            var param = {
                "name" : name.val(),
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
            <button  class="btn btn-success text-white create-modal" data-toggle="modal" data-target="#create-section"><i class="mdi mdi-note-plus-outline"></i>신규 지점 등록</button>
        </div>
        <div class="card-body">
            <h5 class="card-title"> 지점/지사 목록</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>회사명</th>
                        <th>지점</th>
                        <th>멤버수</th>
                        <th>명함수</th>
                        <th>상태</th>
                        <th>부서관리</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.title }</td>
                            <td>${item.title }</td>
                            <td>${item.title }</td>
                            <td>${item.title }</td>
                            <td>${item.title }</td>
                            <td> <button class="btn btn-cyan part-btn text-white" data-seq="${item.company_branch_seq}">부서관리</button></td>
                            <td>
                                <button class="btn btn-info text-white update-modal" data-toggle="modal" data-target="#update-section" data-seq="${item.board_section_seq}">수정</button>
                                <button class="btn btn-danger remove-btn text-white" data-seq="${item.board_section_seq}">삭제</button>
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
                <h5 class="modal-title" id="exampleModalLabel-3">신규 지점 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="create-section">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <form class="forms-sample">
                    <label class="login-label">회사</label>
                    <div class="form-group" style="display: flex;">
                        <select id="company" class="form-control">
                            <option value="">보람상조</option>
                            <option>개인</option>
                            <option>1</option>
                        </select>
                    </div>
                    <label class="login-label">지점명</label>
                    <div class="form-group" style="display: flex;">
                        <input style="flex: 3;margin-right: 5px;" id="title" class="form-control" name="branch_name" placeholder="지점명을 입력해주세요.">
                    </div>
                    <label class="login-label">설명</label>
                    <div class="form-group" style="display: flex;">
                        <input style="flex: 3;margin-right: 5px;" id="comment" class="form-control" name="comment" placeholder="참고사항을 입력해주세요.">
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
                <h5 class="modal-title">지점 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="update-section">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <form class="forms-sample">
                    <label class="login-label">회사</label>
                    <div class="form-group" style="display: flex;">
                        <select id="update_company" class="form-control">
                            <option value="">보람상조</option>
                            <option>개인</option>
                            <option>1</option>
                        </select>
                    </div>
                    <label class="login-label">작업상태</label>
                    <div class="form-group" style="display: flex;">
                        <select id="status_type" class="form-control">
                            <option>작업상태</option>
                            <option>진행중</option>
                            <option>완료</option>
                        </select>
                    </div>
                    <label class="login-label">지점명</label>
                    <div class="form-group" style="display: flex;">
                        <input style="flex: 3;margin-right: 5px;" id="update_title" class="form-control" name="branch_name">
                    </div>
                    <label class="login-label">설명</label>
                    <div class="form-group" style="display: flex;">
                        <input style="flex: 3;margin-right: 5px;" id="update_comment" class="form-control" name="comment">
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
