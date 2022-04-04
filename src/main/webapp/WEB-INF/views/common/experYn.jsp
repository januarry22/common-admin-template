<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<td>
	<div class="btn-group" data-toggle="buttons">
		<label class="btn btn-success showBtn experYnBtn <c:if test="${item.exper_yn eq 'Y' }">active</c:if>" data-role="Y" data-table-seq="${item.member_seq}"> <input type="radio" name="experyn" <c:if test="${item.exper_yn eq 'Y' }">checked="checked"</c:if> style="display: none">체험단 
		</label> <label class="btn btn-success showBtn experYnBtn <c:if test="${item.exper_yn eq 'N' }">active</c:if>" data-role="N" data-table-seq="${item.member_seq}"> <input type="radio" name="experyn" <c:if test="${item.exper_yn eq 'N' }">checked="checked"</c:if> style="display: none">일반
		</label>
	</div>
</td>