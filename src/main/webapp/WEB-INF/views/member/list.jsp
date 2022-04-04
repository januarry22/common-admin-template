<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

<c:set var="page" value="member"/>
<c:set var="page_seq" value="member_seq"/>
<%@ include file="/WEB-INF/views/common/commonScript.jsp" %>
<script>

var eMailcheck = false;
var nickNamecheck = false;
var passCheck = false;
	$(function(){
		$(document).ready(function() {
			  var table = $('#order-listing').DataTable();
		      $("#search_keyword").keyup(function(){
		          var keyword = $(this).val();
		          var search_type = $('#search_type').val();
		          console.log("search_type"+search_type)
		          if(search_type=="nickname"){
					 table.columns(2).search( this.value ).draw();
		          }
		          else if(search_type=="type_name"){
					 table.columns(3).search( this.value ).draw();
		          }
		      }) 
		      
		      $("#pw1").change(function() {
		        var pw = $(this).val();
		        var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		      	if(false === reg.test(pw)) {
		      		var text = "비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.";
		      		showSwal('text-alert',text);
		      	}else {
		      		passCheck = true;
		      		console.log("통과");
		      	}
		     }) 
		  })
		 $(document).on("click", ".download-btn-modal", function(){
				location.href="/admin/member/excel";
		 });

	/*  	 $(document).on("click", ".search-btn", function(){
	 		
	          var search_value = $("input[name=search_value]").val();
	          var search_type = $('#search_type').val();
			$('#order-listing').DataTable({
			ajax:{
	        	url:"/supervise/admin/v1/member/search?search_type="+search_type+"&search_value="+search_value,
	        	type:"GET",
	        	dataSrc :'data'
	        },
	        "columns": [
	            { "data": "rownum" },
	            { "data": "email" },
	            { "data": "nickname" },
	            { "data": "type_name" },
	            { "data": "login_type_info" },
	            { "data": "create_dt_yyyymmdd" },
	            { "data": "exper_yn" },
	        ],
			});
		});  */
		 
			/* email  중복 체크 */
			$(document).on("click", ".common_chk", function(){
			var email = $("input[name=email]");
			if(!$("#email").val()){
				var text = "이메일을 입력 해주세요. ";
				showSwal('text-alert',text);
				 $("#email").focus();
				return;
			}
		 	var param = {
		 	  "table_name" : "${page}",
			  "column_name":"email",
			  "column_value": email.val()
			} 
			ajaxCallPost("/supervise/admin/v1/common/check", param, function(res){
				if(res.success){
					showSwal('common-chk');
				}else{
					showSwal('common-chk-success');
					$("input[name=email]").val(email.val());
					eMailcheck = true;
				}
	
	        },function(){}) 
			})
			/* 닉네임 중복 체크 */
			$(document).on("click", ".common_chk_nick", function(){
			var nickname = $("input[name=nickname]");
			if(!$("#nickname").val()){
				var text = "닉네임을 입력 해주세요. ";
				showSwal('text-alert',text);
				 $("#nickname").focus();
				return;
			}
		 	var param = {
		 	  "table_name" : "${page}",
			  "column_name":"nickname",
			  "column_value": nickname.val()
			} 
			ajaxCallPost("/supervise/admin/v1/common/check", param, function(res){
				if(res.success){
					showSwal('common-chk');
				}else{
					showSwal('common-chk-success');
					$("input[name=nickname]").val(nickname.val());
					nickNamecheck = true;
				}
	
	        },function(){}) 
			})
			
			/* 회원가입 */
			 $(document).on("click", ".create-btn-modal", function(){
				
					var email = $("input[name=email]");
					var password = $("input[name=password]");
					var write_by = $("input[name=write_by]");
					var yyyy = $("input[name=yyyy]");
					var nickname = $("input[name=nickname]");
					var sex = $("input[name=sex]:checked");
					var job_info_code = $("#job").val();
					console.log(eMailcheck);
					console.log(nickNamecheck);
					
					if(eMailcheck==false){
						var text = "Email 중복체크를 진행해주세요.";
						showSwal('text-alert',text);
	    				$("#email").focus();
	    				return;
					}
					if(nickNamecheck==false){
						var text = "닉네임 중복체크를 진행해주세요.";
						showSwal('text-alert',text);
	    				$("#nickname").focus();
	    				return;
					}
					if(passCheck==false){
						var text = "비밀번호를 다시입력해주세요.";
						showSwal('text-alert',text);
	    				$("#pw1").focus();
	    				return;
					}
					if($("#pw1").val() != $("#pw2").val() ){
						//chkPW($("#pw1").val());	
						var text = "비밀번호를 확인해주세요. ";
						showSwal('text-alert',text);
	    				$("#pw1").focus();
	    				return;
	    			}
					
					if(!$("#pw1").val()){
						var text = "비밀번호를 입력 해주세요. ";
						showSwal('text-alert',text);
						 $("#pw1").focus();
	    				return;
	    			}
					if(!$("#yyyy").val()){
						var text = "출생년도를 입력 해주세요. ";
						showSwal('text-alert',text);
						 $("#yyyy").focus();
	    				return;
	    			}
					
					var param = {
							"email" : email.val(),
							"yyyy" : yyyy.val(),
							"nickname" : nickname.val(),
							"password" : password.val(),
							"write_by": write_by.val(),
							"sex" : sex.val(),
							"job_up_code" : "JOB",
							"job_info_code" : job_info_code
					}
			  	   	ajaxCallPost("/supervise/admin/v1/member/create", param, function(res){
						if(res.success){
							showSwal('success-insert-reload');
						}
					},function(){})     
				}) 
	})



</script>


<style>
		tr{
			position: relative;
			text-align: center;
		}
		td{
			position: relative;
			text-align: center;
		}
		.badge{
			position: absolute;
		    left: 14px;
		    top: 50%;
		    transform: translateY(-50%);
		}
</style>

  <!-- partial -->
       <div class="content-wrapper">
            <div class="page-header">
              <span class="page-title"> 회원 리스트  </span>
					<input type="hidden" name="write_by" value="${sessionScope.ADMIN.admin_seq}">
					<div>          		 
					<button type="button" class="btn btn-info btn-rounded btn-fw member_create" data-toggle="modal" data-target="#create-user">+ 회원추가</button>
          		 <button type="button" class="btn btn-success btn-rounded btn-fw download-btn-modal">+ 전체 다운로드</button>
          		 </div>
          		 
            </div>
            
              <div class="card" style="margin-bottom:2%;">
              <div class="card-body" style="width:100%;display: flex;">
              	<select class="form-control" id="search_type" style="max-width:22%;margin-right:2%;">
              		<option value="nickname">닉네임</option>
              		<option value="type_name">유형</option>
              	</select>
              	<input type="text" class="form-control" name="search_value" id="search_keyword" style="max-width:75%;" placeholder="검색어를 입력해주세요.">
			
              </div>
              </div>
            <div class="card">
              <div class="card-body">
           <!--  <h4 class="card-title">Data table</h4> -->
                <div class="row">
                  <div class="col-12">
                    <div class="table-responsive">
                      <table id="order-listing" class="table">
                        <thead>
                          <tr>
                            <th>No.</th>
                            <th>이메일 </th>
                            <th>닉네임 </th>
                            <th>수면유형</th>
                            <th>로그인타입</th>
                            <th>회원가입날짜</th>
                            <th>체험단 여부</th>
                            <th>관리 </th>
                          </tr>
                        </thead>
                        <tbody>
        				    <c:forEach var="item" items="${list }">
                          <tr>
                            <td><fmt:formatNumber type = "number" value = "${item.rownum }"/></td>
                            <td><c:if test="${item.create_dt_yyyymmdd eq today}"><div class="badge badge-danger" style="margin-right:5%;">NEW</div></c:if>${item.email }</td>
                            <td>${item.nickname }</td>
                            <td>${item.type_name }</td>
                            <td>${item.login_type_info }</td>
                            <td>${item.create_dt_yyyymmdd }</td>
                            <%@ include file="/WEB-INF/views/common/experYn.jsp" %>
                            <td>
                              <button class="btn btn-primary detail-btn" data-seq="${item.member_seq}">Detail</button>
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
          
     		  <div class="modal fade" id="create-user" tabindex="-1" role="dialog" aria-labelledby="create-user" aria-hidden="true">
                      <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel-3">회원 추가</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true"></span>
                            </button>
                          </div>
                          <div class="modal-body">
                    <form class="forms-sample">
                      <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">이메일</label>
                        <input style="width:75%;" type="email" class="form-control login_input" id="email" name="email" placeholder="Email">
                    	<button style="width:20%;float:right;" type="button" class="btn btn-info common_chk">중복체크</button>
                      </div>
                       <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">닉네임</label>
                        <input type="text" style="width:75%;"  class="form-control login_input" id="nickname" name="nickname" placeholder="Nickname">
                    	  <button style="width:20%;float:right;" type="button" class="btn btn-info common_chk_nick">중복체크</button>
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">비밀번호</label>
                        <input type="password" id="pw1" name="password"  class="form-control login_input" placeholder="Password 입력 ">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="exampleInputPassword1">비밀번호 확인 </label>
                        <input type="password" id="pw2" name="password1" class="form-control login_input" placeholder="Password 확인 ">
                      </div>
                       <div class="form-group">
                        <label class="login-label" for="exampleInputUsername1">출생년도</label>
                        <input type="text" class="form-control login_input" id="yyyy" name="yyyy" placeholder="YYYY">
                      </div>
                      <div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">직업 </label>
                        	<select class="form-control job" name="job" id="job">
        				    <c:forEach var="item" items="${common }">
                        		<option value="${item.info_code}">${item.name}</option>
                        	</c:forEach>
                        	</select>
                    	</div> 
                   	<div class="form-group">
                        <label class="login-label" for="exampleInputEmail1">성별 </label>
                        <div class="form-check form-check-info">
                              <label class="form-check-label">
                                <input type="radio" name="sex" class="form-check-input" value="1" checked>여 </label>
                        </div>
                          <div class="form-check form-check-info">
                              <label class="form-check-label">
                                <input type="radio" name="sex" class="form-check-input" value="2">남 </label>
                        </div>
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