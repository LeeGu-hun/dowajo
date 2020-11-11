<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<title>TeachingAssistant | 사용자 등록</title>
<!-- Favicon-->
<link rel="icon" href="/resources/favicon.ico" type="image/x-icon">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext"	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

<!-- Bootstrap Core Css -->
<link href="/resources/plugins/bootstrap/css/bootstrap.css"	rel="stylesheet">

<!-- Waves Effect Css -->
<link href="/resources/plugins/node-waves/waves.css" rel="stylesheet" />

<!-- Animation Css -->
<link href="/resources/plugins/animate-css/animate.css" rel="stylesheet" />

<!-- Custom Css -->
<link href="/resources/css/style.css" rel="stylesheet">


<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
</head>

<body class="signup-page">
	<div class="signup-box">
		<div class="logo">
			<a href="javascript:void(0);">Teaching<b>Assistant</b></a>
		</div>
		<div class="card">
			<div class="body">
				<form id="sign_up" method="POST" action="/user_register" role="form">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="msg">
						<b>회원 가입</b>
					</div>
					<span id="idcheck"></span><br>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">person</i>
						</span>
						<div class="form-line">
							<input type="text" class="form-control" name="user_id" id="user_id"	placeholder="ID" required autofocus>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">lock</i>
						</span>
						<div class="form-line">
							<input type="password" class="form-control" name="user_pw" placeholder="비밀번호" value="1" required>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">lock</i>
						</span>
						<div class="form-line">
							<input type="password" class="form-control" name="confirm" placeholder="비밀번호 확인" value="1" required>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">face</i>
						</span>
						<div class="form-line">
							<input type="text" class="form-control" name="user_name" placeholder="이름" required>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">location_city</i>
						</span>
						<div class="form-line">
							<input type="text" class="form-control" name="user_depart" placeholder="소속" value="동성" required>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">email</i>
						</span>
						<div class="form-line">
							<input type="text" class="form-control" name="user_email" placeholder="이메일" value="sample@naver.com" required>
						</div>
					</div>
					<div class="input-group">
						<span class="input-group-addon"> <i class="material-icons">smartphone</i>
						</span>
						<div class="form-line">
							<input type="text" class="form-control" name="user_mobile" placeholder="연락처" value="010-0000-0000" required><br>
						</div>
					</div>

					<button id="regBtn" class="btn btn-block btn-lg bg-pink waves-effect" type="submit">가입하기</button>

					<div class="m-t-25 m-b--5 align-center">
						<a href="/customLogin">이미 계정이 있으신가요?</a>
					</div>
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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script>
$(document).ready(function() {	
	
	$('#user_id').focusout(function(e) {
		e.preventDefault();
		var idObj = $('#user_id');
		if (idObj.val() != '' && checkId()) {
			console.log('ajax load...');
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
		$.ajax({
		type : 'POST',
		url : '/twin_check',
		data : {user_id: idObj.val()},
		beforeSend : function(xhr) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success : function(result) {
		console.log("result::::::::: ["	+ result.trim() + "]");
		if (result != '') {
			$('#idcheck').html("중복된 아이디입니다.").css('color', 'red');
		} else {
			$('#idcheck').html("사용가능한 아이디입니다.").css('color', 'blue');
			}
		},
		error : function(request, status, error) {
			console.log("code:" + request.status
						+ "\n" + "message:"
						+ request.responseText + "\n"
						+ "error:" + error);
				}
			});
		}
	});

	function checkId() {
		$('#idcheck').html('');
		var id = $("#user_id");
		var idReg = /^[a-z0-9_]{3,12}$/g;
		if (!idReg.test(id.val())) {
			$('#idcheck').html("(아이디 생성 불가)").css('color', 'red');
			id.focus();
			return false;
		} else {
			return true;
		}
	}
});
</script>
</html>