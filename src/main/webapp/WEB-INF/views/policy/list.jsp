<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="policy"/>
<c:set var="page_seq" value="policy_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<div class="row">
    <div class="card">
        <div class="card-body">
            <button  class="btn btn-success text-white create_btn"><i class="mdi mdi-note-plus-outline"></i>추가하기</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">약관 관리</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>게시여부</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.type }</td>
                            <td>${item.title }</td>
                            <c:set var="seq" value="${item.policy_seq}"/>
                            <%@ include file="/WEB-INF/views/common/showYn.jsp" %>
                            <td>
                                <button class="btn btn-info detail-btn" data-seq="${item.policy_seq}">수정</button>
                                <button class="btn btn-danger remove-btn" data-seq="${item.policy_seq}">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>