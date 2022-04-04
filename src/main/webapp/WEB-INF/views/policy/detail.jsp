<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="page" value="policy"/>
<c:set var="page_seq" value="policy_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>



<!-- partial -->
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title"> 약관 상세 </h3>
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
                        <input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
                        <div class="form-group">
                            <label class="login-label" >작성일</label>
                            <div class="card-body detail_dt">
                                ${detail.create_dt_yyyymmdd}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="login-label">작성자</label>
                            <div class="card-body detail_dt">
                                ${detail.creat_by}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="login-label">제목</label>
                            <div class="card-body detail_dt">
                                ${detail.title}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="login-label" >내용 </label>
                            <div class="card-body detail_dt">
                                ${detail.content}
                            </div>
                        </div>
                    </div>
                    <div class="card-body button-body">
                        <button type="button" class="btn btn-primary btn-fw update-btn" data-seq="${detail.policy_seq}">수정 </button>
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