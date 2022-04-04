<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<td>
	<div class="btn-group" data-toggle="buttons">
		<label class="btn btn-warning showBtn showYnBtn text-white <c:if test="${item.show_yn eq 'Y' }">active</c:if>" data-role="Y" data-col="${page_seq}" data-table-name="${page}" data-table-seq="${seq}"> <input type="radio" name="showyn" <c:if test="${item.show_yn eq 'Y' }">checked="checked"</c:if> style="display: none">노출
		</label> <label class="btn btn-warning showBtn showYnBtn text-white<c:if test="${item.show_yn eq 'N' }">active</c:if>" data-role="N" data-col="${page_seq}" data-table-name="${page}" data-table-seq="${seq}"> <input type="radio" name="showyn" <c:if test="${item.show_yn eq 'N' }">checked="checked"</c:if> style="display: none">비노출
		</label>
	</div>
</td>