<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ include file="/WEB-INF/tiles/components/commonCss.jsp" %>
<script>

$(function(){


})


function sessionLogout(){
	location.href="/logout";
}

</script>
<header class="topbar" data-navbarbg="skin5">
  <nav class="navbar top-navbar navbar-expand-md navbar-dark">
    <div class="navbar-header" data-logobg="skin5">
      <!-- ============================================================== -->
      <!-- Logo -->
      <!-- ============================================================== -->
      <a class="navbar-brand" href="index.html">
        <!-- Logo icon -->
        <b class="logo-icon ps-2">
          <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
          <!-- Dark Logo icon -->
          <img
                  src="/resources/template/assets/images/logo-icon.png"
                  alt="homepage"
                  class="light-logo"
                  width="25"
          />
        </b>
        <!--End Logo icon -->
        <!-- Logo text -->
        <span class="logo-text ms-2">
                <!-- dark Logo text -->
                <img
                        src="/resources/template/assets/images/logo-text.png"
                        alt="homepage"
                        class="light-logo"
                />
              </span>
        <!-- Logo icon -->
        <!-- <b class="logo-icon"> -->
        <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
        <!-- Dark Logo icon -->
        <!-- <img src="../assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->

        <!-- </b> -->
        <!--End Logo icon -->
      </a>
      <!-- ============================================================== -->
      <!-- End Logo -->
      <!-- ============================================================== -->
      <!-- ============================================================== -->
      <!-- Toggle which is visible on mobile only -->
      <!-- ============================================================== -->
      <a
              class="nav-toggler waves-effect waves-light d-block d-md-none"
              href="javascript:void(0)"
      ><i class="ti-menu ti-close"></i
      ></a>
    </div>
    <!-- ============================================================== -->
    <!-- End Logo -->
    <!-- ============================================================== -->
    <div
            class="navbar-collapse collapse"
            id="navbarSupportedContent"
            data-navbarbg="skin5"
    >
      <!-- ============================================================== -->
      <!-- toggle and nav items -->
      <!-- ============================================================== -->
      <ul class="navbar-nav float-start me-auto">
        <li class="nav-item d-none d-lg-block">
          <a
                  class="nav-link sidebartoggler waves-effect waves-light"
                  href="javascript:void(0)"
                  data-sidebartype="mini-sidebar"
          ><i class="mdi mdi-menu font-24"></i
          ></a>
        </li>

        <!-- ============================================================== -->
        <!-- Search -->
        <!-- ============================================================== -->
        <li class="nav-item search-box">

        </li>
      </ul>
      <!-- ============================================================== -->
      <!-- Right side toggle and nav items -->
      <!-- ============================================================== -->
      <ul class="navbar-nav float-end">


        <!-- ============================================================== -->
        <!-- User profile and search -->
        <!-- ============================================================== -->
        <li class="nav-item dropdown">
          <a
                  class="
                    nav-link
                    dropdown-toggle
                    text-muted
                    waves-effect waves-dark
                    pro-pic
                  "
                  href="#"
                  id="navbarDropdown"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
          >
            <img
                    src="/resources/template/assets/images/users/1.jpg"
                    alt="user"
                    class="rounded-circle"
                    width="31"
            />
          </a>
          <ul
                  class="dropdown-menu dropdown-menu-end user-dd animated"
                  aria-labelledby="navbarDropdown"
          >
            <a class="dropdown-item" href="javascript:void(0)"
            ><i class="mdi mdi-account me-1 ms-1"></i>Profile</a
            >
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="javascript:void(0)"
            ><i class="mdi mdi-settings me-1 ms-1"></i> Account
              Setting</a
            >
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="javascript:void(0)"
            ><i class="fa fa-power-off me-1 ms-1"></i> Logout</a
            >
            <div class="dropdown-divider"></div>
          </ul>
        </li>
        <!-- ============================================================== -->
        <!-- User profile and search -->
        <!-- ============================================================== -->
      </ul>
    </div>
  </nav>
</header>
<aside class="left-sidebar" data-sidebarbg="skin5">
  <!-- Sidebar scroll-->
  <div class="scroll-sidebar">
    <!-- Sidebar navigation-->
    <nav class="sidebar-nav">
      <ul id="sidebarnav" class="pt-4">
        <li class="sidebar-item">
          <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/dashboard"
                  aria-expanded="false"
          ><i class="mdi mdi-view-dashboard"></i
          ><span class="hide-menu">Dashboard</span></a
          >
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="javascript:void(0)"
                  aria-expanded="false"
          ><i class="mdi mdi-server"></i
          ><span class="hide-menu">회사 관리</span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/company/company_list" class="sidebar-link"
              ><i class="mdi mdi-information-outline"></i
              ><span class="hide-menu"> 회사 정보 관리 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/company/company_branch" class="sidebar-link"
              ><i class="mdi mdi-server-plus"></i
              ><span class="hide-menu"> 지점 / 부서 관리 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/company/company_member" class="sidebar-link"
              ><i class="mdi mdi-wallet-membership"></i
              ><span class="hide-menu"> 회사 멤버 관리 </span></a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/admin/section/section_list"
                  aria-expanded="false"
          ><i class="mdi mdi-shape-plus"></i
          ><span class="hide-menu">업종 관리</span></a
          >
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="javascript:void(0)"
                  aria-expanded="false"
          ><i class="mdi mdi-account-card-details"></i
          ><span class="hide-menu">명함 관리</span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="form-basic.html" class="sidebar-link"
              ><i class="mdi mdi-account-off"></i
              ><span class="hide-menu"> 탈퇴 회원 관리 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="form-wizard.html" class="sidebar-link"
              ><i class="mdi mdi-account-key"></i
              ><span class="hide-menu"> 명함 관리 </span></a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/payment/payment_list"
                  aria-expanded="false"
          ><i class="mdi mdi-receipt"></i
          ><span class="hide-menu">결제 관리</span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/payment/payment_list" class="sidebar-link"
              ><i class="mdi mdi-chart-bar"></i
              ><span class="hide-menu"> 결제 내역 </span></a
              >
            </li>
<%--            <li class="sidebar-item">--%>
<%--              <a href="/admin/payment/payment_list" class="sidebar-link"--%>
<%--              ><i class="mdi mdi-note-text"></i--%>
<%--              ><span class="hide-menu"> 결제 내역 </span></a--%>
<%--              >--%>
<%--            </li>--%>
            <li class="sidebar-item">
              <a href="/admin/payment/create" class="sidebar-link"
              ><i class="mdi mdi-note-plus"></i
              ><span class="hide-menu"> 결제 방법 관리 </span></a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/push/push_list"
                  aria-expanded="false"
          ><i class="mdi mdi-lightbulb-on"></i
          ><span class="hide-menu">PUSH 관리</span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/push/create" class="sidebar-link"
              ><i class="mdi mdi-send"></i
              ><span class="hide-menu"> PUSH 발송 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/push/push_list" class="sidebar-link"
              ><i class="mdi mdi-sort-variant"></i
              ><span class="hide-menu"> PUSH 내역 </span></a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/board/b_section_list"
                  aria-expanded="false"
          ><i class="mdi mdi-newspaper"></i
          ><span class="hide-menu">게시판 관리 </span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/board/b_section_list" class="sidebar-link"
              ><i class="mdi mdi-pen"></i
              ><span class="hide-menu"> 게시판 관리 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/board/board_list" class="sidebar-link"
              ><i class="mdi mdi-pencil-lock"></i
              ><span class="hide-menu"> 게시글 관리 </span></a
              >
            </li>
          </ul>
        </li>

        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/admin/admin_list"
                  aria-expanded="false"
          ><i class="mdi mdi-account-key"></i
          ><span class="hide-menu">관리자 관리 </span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/admin/admin_list" class="sidebar-link"
              ><i class="mdi mdi-account-multiple-plus"></i
              ><span class="hide-menu"> 관리자 목록 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/admin/log" class="sidebar-link"
              ><i class="mdi mdi-account-box"></i
              ><span class="hide-menu"> 관리자 이력 </span></a>
            </li>
          </ul>
        </li>

        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/note/note_list"
                  aria-expanded="false"
          ><i class="mdi mdi-library"></i
          ><span class="hide-menu">관리자 NOTE </span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/note/note_list" class="sidebar-link"
              ><i class="mdi mdi-folder-plus"></i
              ><span class="hide-menu"> NOTE 관리 </span></a
              >
            </li>
          </ul>
        </li>

        <li class="sidebar-item">
          <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="widgets.html"
                  aria-expanded="false"
          ><i class="mdi mdi-chart-bubble"></i
          ><span class="hide-menu">영업 정산 관리</span></a
          >
        </li>
        <li class="sidebar-item">
          <a
                  class="sidebar-link has-arrow waves-effect waves-dark"
                  href="/admin/notice/notice_list"
                  aria-expanded="false"
          ><i class="mdi mdi-settings"></i
          ><span class="hide-menu">설정 </span></a
          >
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a href="/admin/notice/notice_list" class="sidebar-link"
              ><i class="mdi mdi-message-text-outline"></i
              ><span class="hide-menu"> 공지사항 관리 </span></a
              >
            </li>
            <li class="sidebar-item">
              <a href="/admin/policy/policy_list" class="sidebar-link"
              ><i class="mdi mdi-library-books"></i
              ><span class="hide-menu"> 약관 관리 </span></a
              >
            </li>
          </ul>
        </li>
      </ul>
    </nav>
    <!-- End Sidebar navigation -->
  </div>
  <!-- End Sidebar scroll-->
</aside>
