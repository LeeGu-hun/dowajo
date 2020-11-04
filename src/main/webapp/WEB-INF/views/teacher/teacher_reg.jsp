<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2>회원 정보</h2>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
							<form role="form" action="/teacher/teacher_reg" method="post" id="form_regist">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>			
							<div class="msg">
								<b>강의실(강의) 정보</b>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> 강의이름 :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_name" id="lecture_name"  >
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> 아프리카ID :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_afreecaid" id="lecture_afreecaid" >
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons" >location_city</i> 강의설명 : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_description" id="lecture_description">
								</div>
							</div>
							<button id="regBtn" class="btn bg-green waves-effect" type="submit" >등록하기</button>
							<button id="listbtn"type="button" class="btn bg-black waves-effect waves-light">뒤로가기</button>
						</form>						
					</div>
				</div>
			</div>
		</div>		
	</div>
</section>
<script>

$(document).ready(function() {

	var formObj = $("form");
	$('#listbtn').on("click", function(e){
		e.preventDefault();
		alert("hello!");
		history.back();
	});
	$('#regBtn').on("click", function(e) {
		e.preventDefault();
		if($('#lecture_name').val()==""){
			alert("강의 이름을 입력해주세요.");
			$('#lecture_name').focus();
			return false;
		}
		if($('#lecture_name').val()==""){
			alert("강의 이름을 입력해주세요.");
			$('#lecture_name').focus();
			return false;
		}
		if($('#lecture_description').val()==""){
			alert("간단하게 강의소개해주세요.");
			$('#lecture_description').focus();
			return false;
		}
		formObj.submit();
	});	
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>