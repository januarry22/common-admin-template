<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="notice"/>
<c:set var="page_seq" value="notice_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<script>
    var passCheck = false;
    $(function(){

        /* 업종명  중복 체크 */
        $(document).on("click", ".common_chk", function(){
            var name = $("input[name=name]");
            if(!$("#name").val()){
                var text = "업종명을 입력 해주세요. ";
                showSwal('text-alert',text);
                $("#name").focus();
                return;
            }
            var param = {
                "table_name" : "${page}",
                "column_name":"name",
                "column_value": name.val()
            }
            ajaxCallPost("/admin/v1/common/check", param, function(res){
                if(res.success){
                    showSwal('common-chk');
                }else{
                    showSwal('common-chk-success');
                    $("input[name=name]").val(name.val());
                    passCheck = true;
                }

            },function(){})
        })

        /* 업종 생성 */
        $(document).on("click", ".create-btn-modal", function(){
            var name = $("input[name=name]");
            var comment = $("input[name=comment]");
            var write_by = $("input[name=write_by]");
            if(passCheck==false){
                $("#name").focus();
                return;
            }
            if(!$("#name").val()){
                $("#name").focus();
                return;
            }
            var param = {
                "name" : name.val(),
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


        </div>
        <div class="card-body">
            <h5 class="card-title">게시판 관리</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>게시판</th>
                        <th>작성자</th>
                        <th>작성 날짜</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.title }</td>
                            <td>${item.section_name }</td>
                            <td>${item.write_name }</td>
                            <td>${item.create_dt }</td>
                            <td>
                                <button class="btn btn-info text-white detail-btn" data-seq="${item.board_seq}">상세</button>
                                <button class="btn btn-danger remove-btn text-white" data-seq="${item.board_seq}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

