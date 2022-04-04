<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script> -->
<textarea id="" name="${text_content}" class="form-control" rows="${height}"><c:if test="${detail_content ne null}">${detail_content}</c:if></textarea>
<!-- 	<script>
			var ckeditor_config = {
					uploadUrl: "/api/file/ckeditUpload",  // 이게 드래그 드롭을 위한 URL
					filebrowserUploadUrl : "/api/file/ckeditUpload",
					height: "${height}"
															};
														
			CKEDITOR.replace("${text_content}", ckeditor_config);
			window.parent.CKEDITOR.tools.callFunction(1,"${url}","전송완료");
	</script> -->