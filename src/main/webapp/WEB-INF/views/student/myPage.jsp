<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>

.table{	
	width: 400px;
	margin-left: 40%;	
}
.divBtn{
	margin-left: 43%;
}
.textBox{
	width: 200px; height: 30px;
	text-align: center;
	border : 0.5px solid #aaa;	
	border-radius: 10px;
	background-color: #c3faf6;		
}
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2>MY PAGE</h2>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">						
							<input type="hidden" name="_csrf" value="fc2ba2ba-9a81-4a14-914c-98f772bdd638">
							<div class="msg" style="text-align: center;">
								<h3>회원 정보</h3>
								<hr>
							</div>
							<div class="table">
							<table >
								<tr>
									<td><i class="material-icons">person</i> ID : </td>
									<td><input type="text" class="textBox" name="user_id" id="user_id" value="${user.user_id}" readonly></td>
								</tr>
								<tr>
									<td><i class="material-icons">face</i> Name : </td>
									<td><input type="text" class="textBox" name="user_name" value="${user.user_name}" readonly></td>
								</tr>
								<tr>
									<td><i class="material-icons">location_city</i> Depart : </td>
									<td><input type="text" class="textBox" name="user_depart" value="${user.user_depart}" readonly></td>
								</tr>
								<tr>
									<td><i class="material-icons">email</i> Email : </td>
									<td><input type="text" class="textBox" name="user_email" value="${user.user_email}" readonly></td>
								</tr>
								<tr>
									<td><i class="material-icons">smartphone</i> Mobile : </td>
									<td><input type="text" class="textBox" name="user_mobile" value="${user.user_mobile}" readonly></td>
								</tr>	
							</table>
								
							</div>
							<hr>
							<div class="divBtn">
								<button id="btnModify" class="btn bg-green waves-effect" type="button">회원정보 수정</button>
							</div>				
					</div>
				</div>
			</div>
		</div>		
	</div>
</section>
<script>
$(document).ready(function() {
	$('#btnModify').on("click", function(){
		location.href="/student/myPage_modify?user_id=<sec:authentication property='principal.user.user_id'/>";
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>