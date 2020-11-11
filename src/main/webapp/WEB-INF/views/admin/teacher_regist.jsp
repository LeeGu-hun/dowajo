<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>Sign Up | Bootstrap Based Admin Template - Material Design</title>
    <!-- Favicon-->
    <link rel="icon" href="/resources/favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

    <!-- Bootstrap Core Css -->
    <link href="/resources/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- Waves Effect Css -->
    <link href="/resources/plugins/node-waves/waves.css" rel="stylesheet" />

    <!-- Animation Css -->
    <link href="/resources/plugins/animate-css/animate.css" rel="stylesheet" />

    <!-- Custom Css -->
    <link href="/resources/css/style.css" rel="stylesheet">
    
    
     <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
</head>

<body class="signup-page">
    <div class="signup-box">
        <div class="logo">
            <a href="javascript:void(0);">강사<b>등록</b></a>
        </div>
        <div class="card">
            <div class="body">
                <form id="sign_up" role="form" action="/admin/teacher_regist" method="POST">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="msg">Register a new membership</div>
                     <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">person</i>
                        </span>
                        <div class="form-line">
                            <input type="text" class="form-control" name="user_id" id="user_id" placeholder="아이디" required autofocus>
                        	<span id="idcheck" style="color:red;"></span>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">person</i>
                        </span>
                        <div class="form-line">
                            <input type="text" class="form-control" name="user_name" id="user_name" placeholder="이름" required autofocus>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">phone</i>
                        </span>
                        <div class="form-line">
                            <input type="text" class="form-control" name="user_mobile" id="user_mobile" placeholder="전화번호" required autofocus>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">location_city</i>
                        </span>
                        <div class="form-line">
                            <input type="text" class="form-control" name="user_depart" id="user_depart" placeholder="학교소속" required autofocus>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">email</i>
                        </span>
                        <div class="form-line">
                            <input type="email" class="form-control" name="user_email" id="user_email" placeholder="이메일" required>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">lock</i>
                        </span>
                        <div class="form-line">
                            <input type="password" class="form-control" name="user_pw" id="user_pw" minlength="6" placeholder="비밀번호" required>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">lock</i>
                        </span>
                        <div class="form-line">
                            <input type="password" class="form-control" name="re_pw" id="re_pw" minlength="6" placeholder="비밀번호 확인" required>
                        </div>
                    </div>              
                    <button class="btn btn-block btn-lg bg-pink waves-effect" type="submit">등록</button>                                        
                </form>
            </div>
        </div>
    </div>

    <!-- Jquery Core Js -->
    <script src="/resources/plugins/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core Js -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.js"></script>

    <!-- Waves Effect Plugin Js -->
    <script src="/resources/plugins/node-waves/waves.js"></script>

    <!-- Validation Plugin Js -->
    <script src="/resources/plugins/jquery-validation/jquery.validate.js"></script>

    <!-- Custom Js -->
    <script src="/resources/js/admin.js"></script>
    <script src="/resources/js/pages/examples/sign-up.js"></script>
</body>

</html>

<script>
$(document).ready(function() {
	var formObj = $("form[role='form']");
	var idObj = $('#user_id');
	$('#submitBtn').on("click", function(e){
		e.preventDefault();
		if($('#re_pw').val()!=$('#user_pw').val()){
			alert("비밀번호가 맞지 않습니다.");
			$('#user_pw').val("");
			$('#re_pw').val("");
			$('#user_pw').focus();
			return false;
		}
		formObj.submit();		
	
	$('#user_id').focusout(function(e){
		e.preventDefault();
		if(idObj.val()!='' && checkId()){
			console.log('ajax load...');
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$.ajax({
				type : 'GET',
				url : '/admin/duplicateId',
				data : "user_id=" + idObj.val(),
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result) {
					console.log("result::::::::: ["+result.trim()+"]");
					if(result!=''){
						$('#user_id').focus()
					 	$('#idcheck').html(' (중복된 아이디입니다.)')
					  	.css('color','red');
					} else {
						$('#idcheck').html(' (사용할 수 있는 아이디입니다.)')
						.css('color','green');
					}
				},
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"
						    +"message:"+request.responseText
						    +"\n"+"error:"+error);
		    }
			});
		}
	});
		
	function checkId(){
		$('#idcheck').html('');
		var id = $("#user_id");
		var idReg = /^[a-z0-9_]{3,12}$/g;
  if( !idReg.test(id.val())) {
	  $('#idcheck').html('(조건이 만족되지 않습니다.)');
	  id.focus();
    return false;
  } else {
    return true;
  }
	}	
});
</script>