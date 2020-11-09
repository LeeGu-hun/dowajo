<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> <!-- 사진관련 업로드할떄 꼭필요 -->
<style>
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h4>강의 수정</h4>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">  <%-- 사진업로드에 필요함 action="/teacher/teacher_modify?${_csrf.parameterName}=${_csrf.token}" encType="multipart/form-data" --%>
							<form role="form" action="/teacher/teacher_modify?${_csrf.parameterName}=${_csrf.token}" method="post" 
								encType="multipart/form-data">
							<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
							<input type='hidden' name='lecture_no' value='<c:out value="${lecture_no}"/>'>			
							<div class="msg">
								<b>강의 수정</b>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> 강의이름 :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_name" id="lecture_name"
										value='<c:out value="${teacherVO.lecture_name}"/>'>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> 아프리카ID :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_afreecaid" id="lecture_afreecaid"
										value='<c:out value="${teacherVO.lecture_afreecaid}"/>' >
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons" >location_city</i> 강의설명 : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="lecture_description" id="lecture_description"
										value='<c:out value="${teacherVO.lecture_description}"/>'>
								</div>
							</div>
							
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons" >dashboard</i>강의 이미지 : 
								</span>
								<div class="form-line">
									<c:if test="${teacherVO.savedLecImage==null}">
										<img src='<spring:url value="/lec_img/defaultImage.jpg"/>' height="100dp">
									</c:if>
									<c:if test="${teacherVO.savedLecImage!=null}">
										<img src='<spring:url value="/lec_img/${teacherVO.savedLecImage}"/>' height="100dp">
									</c:if>	
									<input type="file" class="form-control" name="uploadFile" id="uploadFile"
										value='<c:out value="${teacherVO.savedLecImage}"/>'>
								</div>
							</div>
							
							<button id="regBtn" class="btn bg-green waves-effect" type="submit" >수정완료</button>
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
		history.back();
	});
	$('#regBtn').on("click", function(e) {
		e.preventDefault();
		if($('#lecture_name').val()==""){
			alert("강의 이름을 입력해주세요.");
			$('#lecture_name').focus();
			return false;
		}
		if($('#lecture_afreecaid').val()==""){
			alert("아프리카ID를 입력해주세요.");
			$('#lecture_afreecaid').focus();
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