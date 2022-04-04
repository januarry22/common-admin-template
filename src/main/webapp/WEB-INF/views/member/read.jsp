<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<c:set var="page" value="member_drug_join"/>
<c:set var="page_seq" value="join_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>
<script>
	$(function(){
		
		/* 회원 수정 */
		 $(document).on("click", ".create-btn-modal", function(){
				var member_seq = "${detail.member_seq}";
				var write_by = $("input[name=write_by]");
				var yyyy = $("input[name=yyyy]");
				var nickname = $("input[name=nickname]");
				var sex = $("input[name=sex]:checked");
				var job_info_code = $("#job").val();
				var param = {
						"member_seq" : member_seq,
						"yyyy" : yyyy.val(),
						"nickname" : nickname.val(),
						"write_by": write_by.val(),
						"sex" : sex.val(),
						"job_up_code" : "JOB",
						"job_info_code" : job_info_code
				}
			
		 	  	ajaxCallPost("/supervise/admin/v1/member/update", param, function(res){
					if(res.success){
						showSwal('success-update-reload');
					}
				},function(){})    
			}) 
			/* 회원 약물 추가 */
			$(document).on("click", ".drug-btn-modal", function(){
					var member_seq = "${detail.member_seq}";
					var create_by = $("input[name=write_by]");
					var drug_seq = $("#drug").val();
				
					var param = {
							"member_seq" : member_seq,
							"drug_seq" : drug_seq,
							"create_by" : create_by.val(),
							
					}
				
			 ajaxCallPost("/supervise/admin/v1/drug/member_drug_create", param, function(res){
				if(res.success){
					showSwal('success-insert-reload');
				}
				},function(){})   
			}) 
			
			/* 회원 커멘트 추가 */
			 $(document).on("click", ".comment-btn-modal", function(){
					var member_seq = "${detail.member_seq}";
					var title = $("input[name=title]");
					var content = $("textarea[name=content]");
					var write_by = $("input[name=write_by]");
					var param = {
							"member_seq" : member_seq,
							"title" : title.val(),
							"content" : content.val(),
							"write_by": write_by.val()
					}
				
			 	  	ajaxCallPost("/supervise/admin/v1/member/comment_create", param, function(res){
						if(res.success){
							showSwal('success-insert-reload');
						}
					},function(){})    
			}) 			
			
			/* 회원 커멘트 상세 */
			 $(document).on("click", ".comment-detail-btn", function(){
					var seq = $(this).attr('data-seq');
			 	  	ajaxCallGet("/supervise/admin/v1/member/comment_detail?seq="+seq, function(res){
						if(res.success){
							var data = res.data;
							$(".comment_detail").text(data.content); 
							$(".comment_title").text(data.title); 
						}
					},function(){})    
			}) 			
			
			/* 회원 커멘트 삭제 */
			 $(document).on("click", ".comment-remove-btn", function(){
					var seq = $(this).attr("data-seq");
					var param = {
							"seq" : seq,
							"table_name" : "member_comment",
							"column_name" : "comment_seq",
					}
				 	ajaxCallPost("/supervise/admin/v1/common/delete", param, function(res){
						if(res.success){
							showSwal('success-remove');
							location.reload(true);
						}
					},function(){}) 
			}) 	
	})
</script>
  <!-- partial -->
          <div class="content-wrapper">
           <div class="page-header">
              <h3 class="page-title"> 회원 상세 정보 </h3>
              <nav aria-label="breadcrumb">
              <button type="button" class="btn btn-outline-light btn-fw cancel-btn" onclick="history.back(-1)">Back </button>
              </nav>
            </div>
            <div class="row">
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">회원 정보</h4>
                    <div class="row my-4">
                      <div class="col-lg-7 mx-auto text-center">
                      <c:if test="${detail.img_url ne null}">
                      <img src="${detail.img_url}" alt="profile" class="img-lg rounded-circle mb-3">
                      </c:if>
                        <div id="currentBalanceCircle" class="progressbar-js-circle demo-progress-circle"></div>
                        <h3 class="card-text mb-0 mt-4">${detail.email}</h3>
                      </div>
                    </div>
                    <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded justify-content-between">
                        <div>
                          <h6 class="mb-1">닉네임</h6>
                        </div>
                        <div class="align-self-center">
                          <h6 class="font-weight-bold mb-0 user-info">${detail.nickname}</h6>
                        </div>
                      </div>
                    </div>
                    <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">로그인 타입</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.login_type_info }</h6>
                        </div>
                      </div>
                    </div>
                     <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">직업</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.job}</h6>
                        </div>
                      </div>
                    </div>
                     <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">성별</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0"> <c:if test="${detail.sex eq '1'}">여자</c:if>
                          									<c:if test="${detail.sex eq '2'}">남자</c:if> </h6>
                        </div>
                      </div>
                    </div>
                      <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">출생년도</h6>
                          <p class="card-text"></p>
                        </div>
                        
                        <div class="align-self-center flex-grow text-right">
                         	 <h6 class="font-weight-bold mb-0 user-info">${detail.yyyy}</h6>
                        </div>
                      </div>
                    </div>
                      <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">회원가입 날짜</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.create_dt_yyyymmdd}</h6>
                        </div>
                      </div>
                    </div>
                       <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">접속 횟수 </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.visit_count}</h6>
                        </div>
                      </div>
                    </div>
                       <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">최근 방문 날짜</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.visit_date}</h6>
                        </div>
                      </div>
                    </div>
                        <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">수면 설문조사</h6>
                          <p class="card-text"></p>
                        </div>
                             <div class="align-self-center flex-grow text-right">
                             <button type="button" class="btn btn-outline-light btn-fw" data-toggle="modal" data-target="#report-modal">내역 보기 </button>
                      <%--     <h6 class="font-weight-bold mb-0">${detail.visit_date}</h6> --%>
                        </div> 
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                   <div class="row">
                    <h4 class="card-title">질병 / 복용중인 약</h4>
               	
                    <div class="table-responsive">
                       <div class="card-head" style="float: right;">
                    <button type="button" style="min-width: 100px;" class="btn btn-success btn-rounded btn-fw" data-toggle="modal" data-target="#drug-modal">+ 추가 </button>
       				</div>
                      <table class="table">
                        <thead>
                          <tr>
                            <th> No. </th>
                            <th> 질병  / 약품  </th>
                            <th> 관리 </th>
                          </tr>
                        </thead>
                        <tbody>
        				    <c:forEach var="member_drug" items="${member_drug }">
                         	 <tr>
                            <td><fmt:formatNumber type = "number" value = "${member_drug.rownum }"/></td>
                            <td> ${member_drug.drug_name} </td>
                            <td>
                              <i class="mdi mdi-close icon-sm text-danger remove-btn" data-seq="${member_drug.join_seq}"></i>
                            </td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                   <div class="card-body">
                   <div class="row">
                    <h4 class="card-title">회원 코멘트</h4>
            	    <div class="table-responsive">	
                       <div class="card-head" style="float: right;">
                    <button type="button" style="min-width: 100px;" class="btn btn-success btn-rounded btn-fw" data-toggle="modal" data-target="#comment-modal">+ 추가 </button>
       				</div>
                      <table class="table">
                        <thead>
                          <tr>
                            <th> No. </th>
                            <th> 제목 </th>
                            <th> 관리 </th>
                          </tr>
                        </thead>
                        <tbody>
        				    <c:forEach var="comment" items="${comment }">
                         	 <tr>
                            <td><fmt:formatNumber type = "number" value = "${comment.rownum }"/></td>
                            <td> ${comment.title} </td>
                            <td>
                              <i class="mdi mdi-alert-circle-outline icon-sm text-danger comment-detail-btn" style="color: chartreuse !important;" data-toggle="modal" data-target="#comment-detail-modal" data-seq="${comment.comment_seq}"></i>
                              <i class="mdi mdi-close icon-sm text-danger comment-remove-btn" data-seq="${comment.comment_seq}"></i>
                            </td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
                  </div>
                  
                     <div class="row">
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">수면 유형 히스토리 </h4>
                    <table id="report-listing"  class="table">
                        <thead>
                          <tr>
                            <th> No. </th>
                            <th> 날짜 </th>
                            <th> 이전 수면 유형</th>
                            <th> 현재 수면 유형 </th>
                          </tr>
                        </thead>
                        <tbody>
        				    <c:forEach var="history" items="${history }">
                         	 <tr>
                            <td><fmt:formatNumber type = "number" value = "${history.rownum }"/></td>
                            <td> ${history.create_dt_yyyymmdd} </td>
                            <td> ${history.pre_type} </td>
                            <td> ${history.cur_type} </td>
                        <%--     <td>
                              <i class="mdi mdi-close icon-sm text-danger remove-btn" data-seq="${history.join_seq}"></i>
                            </td> --%>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                  </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                   <div class="row">
                    <h4 class="card-title">찜한 수면 컨텐츠</h4>
               	
                    <div class="table-responsive">
                       <div class="card-head" style="float: right;">
       				</div>
                      <table id="order-listing" class="table">
                        <thead>
                          <tr>
                            <th> No. </th>
                            <th> 컨텐츠 제목 </th>
                          </tr>
                        </thead>
                        <tbody>
        				    <c:forEach var="goods" items="${goods }">
                         	 <tr>
                            <td><fmt:formatNumber type = "number" value = "${goods.rownum }"/></td>
                            <td> ${goods.content_title} </td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
                  </div>
                   <div class="card-body button-body">
	                 <button type="button" class="btn btn-primary btn-fw" data-toggle="modal" data-target="#exampleModal-3">Update </button>
	           <!--      <button type="button" class="btn btn-warning btn-fw cancel-btn">Save</button> -->
	                </div>
                </div>
                
                
     		  <div class="modal fade" id="exampleModal-3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel-3" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel-3">회원 수정</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                      <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">Nickname</label>
                        <input type="text" class="form-control login_input" name="nickname" value="${detail.nickname}">
                      </div>
                       <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">출생년도</label>
                        <input type="text" class="form-control login_input" name="yyyy" value="${detail.yyyy}">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">성별 </label>
                        <div class="form-check form-check-info">
                              <label class="form-check-label">
                                <input type="radio" name="sex" class="form-check-input" value="1" <c:if test="${detail.sex eq '1'}">checked="checked"</c:if> >여 </label>
                        </div>
                          <div class="form-check form-check-info">
                              <label class="form-check-label">
                                <input type="radio" name="sex" class="form-check-input" id="ExampleRadio3" value="2" <c:if test="${detail.sex eq '2'}">checked="checked"</c:if> >남 </label>
                        </div>
                    	</div>
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">직업 </label>
                        	<select class="form-control" id="job">
                        		<option value="${detail.job_info_code}">${detail.job }</option>
        				    <c:forEach var="item" items="${common }">
                        		<option value="${item.info_code}">${item.name}</option>
                        	</c:forEach>
                        	</select>
                    	</div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-success create-btn-modal">등록</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                         
     		  <div class="modal fade" id="drug-modal" tabindex="-1" role="dialog" aria-labelledby="drug-modal" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="drug-modal">약물 / 질병 추가 </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">약물 / 질병  </label>
                        	<select class="form-control" id="drug">
        				    <c:forEach var="drug" items="${drug }">
                        		<option value="${drug.drug_seq}">${drug.name}</option>
                        	</c:forEach>
                        	</select>
                    	</div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-success drug-btn-modal">등록</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                     <div class="modal fade" id="comment-modal" tabindex="-1" role="dialog" aria-labelledby="comment-modal" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="drug-modal">회원 코멘트 추가 </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">제목 </label>
                        <input type="text" class="form-control login_input" name="title">
                    	</div>
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">내용 </label>
                        <textarea class="form-control login_input" name="content" rows="20"></textarea>
                    	</div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-success comment-btn-modal">등록</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    
                     <div class="modal fade" id="comment-detail-modal" tabindex="-1" role="dialog" aria-labelledby="comment-detail-modal" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="drug-modal">회원 코멘트 상세 </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">제목 </label>
                        <p class="comment_title"></p>
                    	</div>
                    	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">내용 </label>
                        <p class="comment_detail"></p>
                    	</div>
                    </form>
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">취소</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
              <div class="modal fade" id="report-modal" tabindex="-1" role="dialog" aria-labelledby="comment-modal" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="drug-modal">설문조사 내역</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                  <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded justify-content-between">
                        <div>
                          <h6 class="mb-1">Q. 정기적으로 하는 취미 활동이 있나요? </h6>
                        </div>
                        <div class="align-self-center">
                          <h6 class="font-weight-bold mb-0 user-info">${detail.fm_hobby}</h6>
                        </div>
                      </div>
                    </div>
                    <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 사람을 만나서 이야기(수다)를 자주 하시나요? </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_small_talk }</h6>
                        </div>
                      </div>
                    </div>
                     <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 평소의 취침시간과 기상시간을 알려주세요</h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">취침시간 : ${detail.fm_bedtime}</h6>
                          <h6 class="font-weight-bold mb-0">기상시간 : ${detail.fm_q_wake_up_time}</h6>
                        </div>
                      </div>
                    </div>
                  	<div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q.평소 수면시간이 규칙적인가요? </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_regularity}</h6>
                        </div>
                      </div>
                    </div>
                    <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 침실에 TV 혹은 컴퓨터가 있나요? </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_have_a_com}</h6>
                        </div>
                      </div>
                    </div>
                  <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 자기전 명상을 하시나요?  </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_youtube}</h6>
                        </div>
                      </div>
                    </div>
                   <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 취침 시 수면유도음악(ASMR)을 들으시나요? </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_music}</h6>
                        </div>
                      </div>
                    </div>
                 <div class="row mt-3">
                      <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                        <div>
                          <h6 class="mb-1">Q. 자기 전 일기를 쓰시나요? </h6>
                          <p class="card-text"></p>
                        </div>
                        <div class="align-self-center flex-grow text-right">
                          <h6 class="font-weight-bold mb-0">${detail.fm_diary}</h6>
                        </div>
                      </div>
                    </div>     
                  </div>
                   <div class="modal-footer">
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
                          </div>
                        </div>
                      </div>
                    </div>