<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="push"/>
<c:set var="page_seq" value="push_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>

<div class="row">
    <div class="card">
        <div class="card-body">
            <button  class="btn btn-success text-white create_btn"><i class="mdi mdi-note-plus-outline"></i>PUSH 전송</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">PUSH 내역</h5>
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>기기 구분</th>
                        <th>예약 여부</th>
                        <th>전송 여부</th>
                        <th>전송 날짜</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.title }</td>
                            <td>${item.push_type }</td>
                            <td>${item.reserve_yn}</td>
                            <td>${item.send_yn}</td>
                            <td>${item.send_dt}</td>
                            <td>
                                <button class="btn btn-info detail-btn" data-seq="${item.push_seq}">상세</button>
                                <button class="btn btn-danger remove-btn" data-seq="${item.push_seq}">내역 삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>