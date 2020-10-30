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
	background-color: #e2e2e2;	
}
.textBox2{
	width: 200px; height: 30px;
	text-align: center;
	border : 0.5px solid #aaa;	
	border-radius: 10px;	
}
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">			
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">						
							<input type="hidden" name="_csrf" value="fc2ba2ba-9a81-4a14-914c-98f772bdd638">
							<div class="msg" style="text-align: center;">
								<h3>회원 정보 수정</h3>
								<hr>
							</div>
							<form role="form" action="/student/myPage_modify" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="user_no" value="${user.user_no}"> 
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
									<td><input type="text" class="textBox2" name="user_depart" value="<c:out value="${user.user_depart}"/>"></td>
								</tr>
								<tr>
									<td><i class="material-icons">email</i> Email : </td>
									<td><input type="text" class="textBox2" name="user_email" value="<c:out value="${user.user_email}"/>" ></td>
								</tr>
								<tr>
									<td><i class="material-icons">smartphone</i> Mobile : </td>
									<td><input type="text" class="textBox2" name="user_mobile" value="<c:out value="${user.user_mobile}"/>" ></td>
								</tr>						
								<tr>
									<td><i class="material-icons">lock</i> Password: </td>
									<td><input type="password" class="textBox2" name="user_pw" id="pwBox"></td>
								</tr>
							</table>
								
							</div>
							<hr>
							<div class="divBtn">																
								<button type="button" id="btnModify" class="btn bg-green waves-effect" > 확 인 </button>&nbsp&nbsp
								<button type="button" id="btnCancel" class="btn bg-grey waves-effect"> 취 소 </button>&nbsp&nbsp
								<button type="button" id="btnLeave" data-toggle="modal" data-target="#defaultModal" class="btn bg-blue-grey waves-effect">회원탈퇴</button>
							</div>
						</form>						
					</div>
				</div>
			</div>
		</div>		
	</div>
	

	
</section>

    
<div class="modal fade" id="defaultModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="defaultModalLabel">회원탈퇴</h4>
			</div>
			<div class="modal-body">
				정말 탈퇴 하시겠습니까?
			</div>
			<div class="modal-footer">
				
				<button type="button" class="btn btn-link waves-effect" id="btnModal">탈퇴</button>
				<button type="button" class="btn btn-link waves-effect" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
         
<!-- Jquery Core Js -->
    <script src="/resources/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap Core Js -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.js"></script>
    <!-- Select Plugin Js -->
    <script src="/resources/plugins/bootstrap-select/js/bootstrap-select.js"></script>
    <!-- Slimscroll Plugin Js -->
    <script src="/resources/plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <!-- Bootstrap Notify Plugin Js -->
    <script src="/resources/plugins/bootstrap-notify/bootstrap-notify.js"></script>
    <!-- Waves Effect Plugin Js -->
    <script src="/resources/plugins/node-waves/waves.js"></script>
    <!-- SweetAlert Plugin Js -->
    <script src="../../plugins/sweetalert/sweetalert.min.js"></script>
    <!-- Custom Js -->
    <script src="/resources/js/admin.js"></script>
    <script src="/resources/js/pages/ui/modals.js"></script>
    <!-- Demo Js -->
    <script src="/resources/js/demo.js"></script>            
<script>
$(document).ready(function(){
	var formObj = $("form");
	
    $('#btnModify').on("click", function(e){
       e.preventDefault();
       if($('[name="user_depart"]').val()==''){
          alert("소속을 확인하세요.");
          $('[name="user_depart"]').focus();
          return false;
       }
       if($('#pwBox').val() == ""){
    	   alert("비밀번호를 확인하세요.");
    	   $('#pwBox').focus();
    	   return false;
       }
       
       formObj.submit();              
    });
    
    $('#btnCancel').on("click",function(){
		location.href="/student/myPage?user_id=<sec:authentication property='principal.user.user_id'/>";
    });

    $('#btnModal').on("click", function(){
    	formObj.attr("action", "/student/user_delete").submit();        
    });
});
</script>

	
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>