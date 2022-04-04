<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="admin_log"/>
<c:set var="page_seq" value="admin_log_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>





<div class="row">
    <div class="card">

        <div class="card-body">
            <h5 class="card-title">관리자 이력 관리</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>관리자 ID</th>
                        <th>이름</th>
                        <th>이력 내용</th>
                        <th>이력 일자</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.admin_id }</td>
                            <td>${item.name}</td>
                            <td>${item.content }</td>
                            <td>${item.create_dt }</td>
                            <td>
                                <button class="btn btn-info update-modal" data-toggle="modal" data-target="#detail-modal" data-seq="${item.admin_log_seq}">상세</button>
                                <button class="btn btn-danger remove-btn" data-seq="${item.admin_log_seq}">이력 삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

    <!-- 상세 모달 -->

    <div class="modal" id="detail-modal" style="display: none;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">상세 이력</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="detail-modal">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="forms-sample">
                        <label class="login-label">관리자 ID</label>
                        <div class="form-group" style="display: flex;">
                            <div class="card-body detail_admin_id">
                                <!-- id -->
                            </div>
                        </div>
                        <label class="login-label">이름</label>
                        <div class="form-group" style="display: flex;">
                            <div class="card-body detail_name">
                                <!-- name -->
                            </div>
                        </div>
                        <label class="login-label">이력 내용</label>
                        <div class="form-group" style="display: flex;">
                            <div class="card-body detail_content">
                                <!-- content -->
                            </div>
                        </div>
                        <label class="login-label">이력 날짜</label>
                        <div class="form-group" style="display: flex;">
                            <div class="card-body detail_dt">
                                <!-- create_dt -->
                            </div>
                        </div>
                        <label class="login-label">작업 내용</label>
                        <div class="form-group" style="display: flex;">
                            <div class="card-body detail_op">
                                <!-- log_table_seq -->
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger text-white modal-cancel-btn" data-modal="detail-modal">닫기</button>
                </div>
            </div>
        </div>
    </div>