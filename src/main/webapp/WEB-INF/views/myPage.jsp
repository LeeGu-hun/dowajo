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
			<h2>MY PAGE</h2>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">						
							<input type="hidden" name="_csrf" value="fc2ba2ba-9a81-4a14-914c-98f772bdd638">
							<div class="msg">
								<b>내 정보</b>
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

							<button id="regBtn" class="btn bg-green waves-effect" type="submit" ">회원정보 수정</button>
						
					</div>
				</div>
			</div>
		</div>		
	</div>
</section>
<script>

</script>
<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>