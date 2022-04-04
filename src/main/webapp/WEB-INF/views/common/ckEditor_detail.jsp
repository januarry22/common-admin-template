<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<textarea id="" name="content">${detail.content}</textarea>
	<script>
			var ckeditor_config = {
					uploadUrl: "/api/file/ckeditUpload",  // 이게 드래그 드롭을 위한 URL
					filebrowserUploadUrl : "/api/file/ckeditUpload",
					height: 600 
															};
														
			CKEDITOR.replace("content", ckeditor_config);
			window.parent.CKEDITOR.tools.callFunction(1,"${url}","전송완료");
	</script>