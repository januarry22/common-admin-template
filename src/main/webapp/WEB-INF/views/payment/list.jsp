<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="notice"/>
<c:set var="page_seq" value="notice_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>


<style>
    .period-search-btn{
        margin-right: 2%;
    }
</style>

<div class="row">
    <div class="card">
        <div class="card-body">

        </div>
        <div class="card-body">
            <div class="card card-hover">
                <!-- 결제 기간 검색 조회-->
                <div class="box" style="display: flex;flex-direction: row;justify-content: space-between;max-width: 300px;">
                    <button type="button" class="btn btn-outline-secondary period-search-btn">
                        일
                    </button>
                    <button type="button" class="btn btn-outline-secondary  period-search-btn">
                        1주
                    </button>
                    <button type="button" class="btn btn-outline-secondary  period-search-btn">
                        1개월
                    </button>
                    <button type="button" class="btn btn-outline-secondary  period-search-btn">
                        1년
                    </button>
                </div>
                <!-- 결제 총 금액 영역-->
                <div class="box bg-success text-center"  style="display: flex;justify-content: space-between;">
                    <h6 class="text-white"> 2022/01/01 ~ 2022/01/07 </h6>
                    <h1 class="font-light text-white">
                       Total : 500,000 원
                    </h1>
                </div>
                 <!--그래프 영역-->
                <div class="box">
                    <div class="bars" style="height: 400px"></div>
                </div>
            </div>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table id="zero_config"
                       class="table table-bordered">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>회사명</th>
                        <th>담당자</th>
                        <th>계약일</th>
                        <th>멤버 수</th>
                        <th>명함 수</th>
                        <th>결제 수단</th>
                        <th>세금 계산서 발행 여부</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list }">
                        <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td>${item.type }</td>
                            <td>${item.type_info}</td>
                            <td>${item.title }</td>
                            <td>${item.type_info}</td>
                            <td>${item.type_info}</td>
                            <td>${item.type_info}</td>
                            <td>${item.type_info}</td>
                            <td>
                                <button class="btn btn-info detail-btn" data-seq="${item.notice_seq}">상세</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>