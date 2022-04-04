<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="note"/>
<c:set var="page_seq" value="note_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>




<div class="row">
    <div class="card">
        <div class="card-body">
            <button  class="btn btn-success text-white create-modal" data-toggle="modal" data-target="#create-section"><i class="mdi mdi-note-plus-outline"></i>NOTE 추가하기</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">관리자 NOTE 목록</h5>
            <input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>관리자 ID</th>
                        <th>구분</th>
                        <th>제목</th>
                        <th>게시여부</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.admin_id }</td>
                            <td>${item.type_info}</td>
                            <td>${item.title }</td>
                            <c:set var="seq" value="${item.notice_seq}"/>
                            <%@ include file="/WEB-INF/views/common/showYn.jsp" %>
                            <td>
                                <button class="btn btn-info update-modal"  data-toggle="modal" data-target="#detail-modal" data-seq="${item.note_seq}">상세</button>
                                <button class="btn btn-danger remove-btn" data-seq="${item.note_seq}">삭제</button>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel-3">NOTE 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="create-section">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <form class="forms-sample">
                    <label class="login-label">소속</label>
                    <div class="form-group" style="display: flex;">
                        <select class="form-control" id="company">
                            <option>회사명</option>
                            <option>일반</option>
                            <option>기타</option>
                        </select>
                    </div>
                    <label class="login-label">구분</label>
                    <div class="form-group" style="display: flex;">
                        <select class="form-control" id="type">
                            <option>공지</option>
                            <option>일반</option>
                            <option>기타</option>
                        </select>
                    </div>
                    <label class="login-label">제목</label>
                    <div class="form-group" style="display: flex;">
                        <input style="flex: 3;margin-right: 5px;" id="title" class="form-control" name="title" placeholder="제목을 입력해주세요.">
                    </div>
                    <label class="login-label">내용</label>
                    <div class="form-group" style="display: flex;">
                        <textarea class="form-control" name="comment" rows="15">내용을 입력해주세요.
                        </textarea>
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


<!-- 상세 모달 -->

<div class="modal" id="detail-modal" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">NOTE 상세</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  data-modal="detail-modal">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <form class="forms-sample">
                    <label class="login-label">회사</label>
                    <div class="form-group" style="display: flex;">
                        <div class="card-body detail_company">
                            <!-- company -->
                        </div>
                    </div>
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
                    <label class="login-label">구분</label>
                    <div class="form-group" style="display: flex;">
                        <div class="card-body detail_type">
                            <!-- type -->
                        </div>
                    </div>
                    <label class="login-label">제목</label>
                    <div class="form-group" style="display: flex;">
                        <div class="card-body detail_title">
                            <!-- title -->
                        </div>
                    </div>
                    <label class="login-label">내용</label>
                    <div class="form-group" style="display: flex;">
                        <div class="card-body detail_content">
                            <!-- content -->
                        </div>
                    </div>
                    <label class="login-label">날짜</label>
                    <div class="form-group" style="display: flex;">
                        <div class="card-body detail_dt">
                            <!-- create_dt -->
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