<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script type="text/javascript">

	/* 공통 페이지 */
	$(function(){

		$(document).on("click", ".close , .modal-cancel-btn", function(){
			$('#'+$(this).attr('data-modal')+'').modal('hide');
		})
		$(document).on("click", ".create-modal", function(){
			$(''+$(this).attr('data-target')+'').modal('show');
		})
		$(document).on("click", ".update-modal", function(){
			$(''+$(this).attr('data-target')+'').modal('show');
		})
		
		$(document).on("click", ".detail-btn", function(){
	       var seq = $(this).attr("data-seq");
	       location.href="/admin/"+"${page}"+"/"+seq;
	   	});
		$(document).on("click", ".create_btn", function(){
		    location.href="/admin/"+"${page}"+"/create";
		});
		$(document).on("click", ".list_btn", function(){
			location.href="/admin/"+"${page}"+"/"+"${page}"+"_list";
		});
		
		$(document).on("click", ".update-btn", function(){
		    var seq = $(this).attr("data-seq");
		    location.href="/admin/"+"${page}"+"/update/"+seq;
		});
		$(document).on("click", ".guide-btn", function(){
		    var seq = $(this).attr("data-seq");
		    location.href="/admin/"+"${page}"+"/"+"${site}"+"/"+seq;
		});
		$(document).on("click", ".site-btn", function(){
		    var seq = $(this).attr("data-seq");
		    var member_seq = $(this).attr("data-member");
		    var date = $(this).attr("data-date");
		    location.href="/admin/"+"${page}"+"/"+"${site}"+"/"+seq+"${member_seq}"+"/"+member_seq+"${date}"+"/"+date;
		});
		$(document).on("click", ".remove-btn", function(){
			var seq = $(this).attr("data-seq");

			var param = {
					"seq" : seq,
					"table_name" : "${page}",
					"column_name" : "${page_seq}",
			}
			if(confirm("삭제 된 데이터는 복구할 수 없습니다. 삭제 하시겠습니까?")){

		 	ajaxCallPost("/supervise/admin/v1/common/delete", param, function(res){
				if(res.success){
					showSwal('success-remove');
				}
			},function(){})

			}
		});
	
	})
	</script>

