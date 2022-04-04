<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
$(function(){
	
	$(".enter-btn").click(function(){
		console.log("dd");
		var admin_id = $("input[name=admin_id]").val();
		var password = $("input[name=password]").val();
		
		var param = {
				"admin_id" : admin_id,
				"password" : password
		}
		
		ajaxCallPost("/api/v1/login/admin", param, function(res){
			if(res.success){
		
				location.href="/";
			}else{
				alert("아이디 또는 비밀번호를 확인해주세요.");
				
			}
		},function(){})
	})
})
</script>


<style>

</style>


<div class="
          d-flex
          no-block
          justify-content-center
          align-items-center
          " style="min-height: 1000px;background-color: #bdcddd!important;">
  <div class="auth-box bg-dark border-top border-secondary">
    <div id="loginform">
      <div class="text-center pt-3 pb-3" style="background-color: #bdcddd!important;">
              <span class="db"
              ><img src="../assets/images/logo.png" alt="logo"
              /></span>
      </div>
      <!-- Form -->
      <form
              class="form-horizontal"
              id="loginform"
              action="index.html" style="background-color: #bdcddd!important;"
      >
        <div class="row pb-4">
          <div class="col-12">
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                      <span
                              class="input-group-text bg-success text-white h-100"
                              id="basic-addon1"
                      ><i class="mdi mdi-account fs-4"></i
                      ></span>
              </div>
              <input
                      type="text"
                      class="form-control form-control-lg"
                      placeholder="ID"
                      aria-label="Username"
                      aria-describedby="basic-addon1"
                      required="아이디를 입력해주세요!"
                      name="admin_id"
              />
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                      <span
                              class="input-group-text bg-warning text-white h-100"
                              id="basic-addon2"
                      ><i class="mdi mdi-lock fs-4"></i
                      ></span>
              </div>
              <input
                      type="password"
                      class="form-control form-control-lg"
                      placeholder="password"
                      aria-label="Password"
                      aria-describedby="basic-addon1"
                      required="비밀번호를 입력해주세요"
                      name="password"
              />
            </div>
          </div>
        </div>
        <div class="row border-top border-secondary">
          <div class="col-12">
            <div class="form-group">
              <div class="pt-3">
                <button
                        class="btn btn-info"
                        id="to-recover"
                        type="button"
                >
                  <i class="mdi mdi-lock fs-4 me-1"></i> 비밀번호 찾기
                </button>
                <button
                        class="btn btn-success float-end text-white enter-btn"
                        type="button"
                >
                  로그인
                </button>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>

  </div>
</div>