<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_admin.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
							<form role="form" action="/user/get" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type='hidden' name='user_auth' value='<c:out value="${cri.user_auth }"/>'>
							<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
							<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	 						<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>						
							<div class="msg">
								<h2>
									<b>회원관리</b><small>회원정보</small>
								</h2>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> USER_NO :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_no" id="user_no" value="${user.user_no}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> ID :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_id" id="user_id" value="${user.user_id}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons" >face</i> Name : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_name" value="${user.user_name}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">location_city</i> Depart : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_depart" value="${user.user_depart}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon">
									<i class="material-icons">email</i> Email : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_email" value="${user.user_email}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">smartphone</i> Mobile : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="user_mobile" value="${user.user_mobile}" readonly><br>
								</div>
							</div>
							<button id="regBtn" class="btn bg-green waves-effect" type="submit" ">회원삭제</button>
							<button id="listbtn"type="button" class="btn bg-black waves-effect waves-light">뒤로가기</button>						
					</div>
				</div>
			</div>
		</div>		
	</div>
</section>
<script>

$(document).ready(function() {
	
	var formObj = $("form");
	$('#modifyBtn').on("click", function(e) {
		e.preventDefault();
		console.log(">>>>modify post");
		formObj.submit();
	});
	$('#listbtn').on("click", function(){
		history.back();
	});
	$('#regBtn').on("click", function() {
		formObj.attr("action", "/admin/remove").submit();
	});	
	
});

</script>
<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>