<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
<title>모바일 명함 프로그램 </title>

	<script src="/resources/js/commonAjax.js"></script>

	<script src="https://www.jsviews.com/download/jsrender.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">

    <link href="/resources/template/assets/libs/flot/css/float-chart.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="/resources/template/dist/css/style.min.css" rel="stylesheet" />
    <link
            rel="stylesheet"
            type="text/css"
            href="/resources/template/assets/libs/select2/dist/css/select2.min.css"
    />

    <link
            href="/resources/template/assets/libs/jquery-steps/jquery.steps.css"
            rel="stylesheet"
    />
    <link href="/resources/template/assets/libs/jquery-steps/steps.css" rel="stylesheet" />


    <link href="/resources/template/assets/libs/flot/css/float-chart.css" rel="stylesheet" />
    <link href="/resources/template/dist/css/style.min.css" rel="stylesheet" />
</head>

<body>
        <div
        id="main-wrapper"
        data-layout="vertical"
        data-navbarbg="skin5"
        data-sidebartype="full"
        data-sidebar-position="absolute"
        data-header-position="absolute"
        data-boxed-layout="full"
>
  		  <!-- Main wrapper  -->
		<tiles:insertAttribute name="headerAdmin" />
            <div class="page-wrapper">
        <div class="container-fluid">

		<tiles:insertAttribute name="contentAdmin" />
	     </div>
                <tiles:insertAttribute name="footerAdmin" />
            </div>
		
	</div>
    <script src="/resources/template/assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="/resources/template/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/template/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="/resources/template/assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="/resources/template/dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="/resources/template/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="/resources/template/dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <!-- <script src="../dist/js/pages/dashboards/dashboard1.js"></script> -->
    <!-- Charts js Files -->
    <script src="/resources/template/assets/libs/flot/excanvas.js"></script>
    <script src="/resources/template/assets/libs/flot/jquery.flot.js"></script>
    <script src="/resources/template/assets/libs/flot/jquery.flot.pie.js"></script>
    <script src="/resources/template/assets/libs/flot/jquery.flot.time.js"></script>
    <script src="/resources/template/assets/libs/flot/jquery.flot.stack.js"></script>
    <script src="/resources/template/assets/libs/flot/jquery.flot.crosshair.js"></script>
    <script src="/resources/template/assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="/resources/template/dist/js/pages/chart/chart-page-init.js"></script>


        <script src="/resources/template/assets/libs/select2/dist/js/select2.full.min.js"></script>
        <script src="/resources/template/assets/libs/select2/dist/js/select2.min.js"></script>


        <script src="/resources/template/assets/libs/jquery-steps/build/jquery.steps.min.js"></script>
        <script src="/resources/template/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>


        <script src="/resources/template/assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
        <script src="/resources/template/dist/js/pages/mask/mask.init.js"></script>
        <script src="/resources/template/assets/libs/select2/dist/js/select2.full.min.js"></script>
        <script src="/resources/template/assets/libs/select2/dist/js/select2.min.js"></script>
        <script src="/resources/template/assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
        <script src="/resources/template/assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
        <script src="/resources/template/assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
        <script src="/resources/template/assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
        <script src="/resources/template/assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="/resources/template/assets/libs/quill/dist/quill.min.js"></script>

        <script src="/resources/template/assets/libs/chart/matrix.interface.js"></script>
        <script src="/resources/template/assets/libs/chart/excanvas.min.js"></script>
        <script src="/resources/template/assets/libs/flot/jquery.flot.js"></script>
        <script src="/resources/template/assets/libs/flot/jquery.flot.pie.js"></script>
        <script src="/resources/template/assets/libs/flot/jquery.flot.time.js"></script>
        <script src="/resources/template/assets/libs/flot/jquery.flot.stack.js"></script>
        <script src="/resources/template/assets/libs/flot/jquery.flot.crosshair.js"></script>
        <script src="/resources/template/assets/libs/chart/jquery.peity.min.js"></script>
        <script src="/resources/template/assets/libs/chart/matrix.charts.js"></script>
        <script src="/resources/template/assets/libs/chart/jquery.flot.pie.min.js"></script>
        <script src="/resources/template/assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
        <script src="/resources/template/assets/libs/chart/turning-series.js"></script>
        <script src="/resources/template/dist/js/pages/chart/chart-page-init.js"></script>
</body>
</html>