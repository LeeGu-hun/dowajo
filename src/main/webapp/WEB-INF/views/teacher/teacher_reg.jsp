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
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
							<form role="form" action="/teacher/teacher_reg?${_csrf.parameterName}=${_csrf.token}" method="post" 
							id="form_regist" encType="multipart/form-data">							
							<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>			
							<div class="msg">
								<h1>강의 만들기</h1>
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
							
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons" >dashboard</i> 강의 이미지 : 
								</span>
								<div class="form-line">
									<input type="file" class="form-control" name="uploadFile" id="uploadFile">
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

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
	
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
		if($('#uploadFile').val()==""){
			alert("강의실 개설할때 사진은 필수입니다.");
			$('#uploadFile').focus();
			return false;
		}
		formObj.submit();
	});	
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>