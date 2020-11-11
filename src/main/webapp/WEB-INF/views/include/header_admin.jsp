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
    <title>Blank Page | Bootstrap Based Admin Template - Material Design</title>
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
    
     <!-- Bootstrap Material Datetime Picker Css -->
    <link href="/resources/plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet" />

    <!-- Wait Me Css -->
    <link href="/resources/plugins/waitme/waitMe.css" rel="stylesheet" />

    <!-- Bootstrap Select Css -->
    <link href="/resources/plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />

    <!-- Custom Css -->
    <link href="/resources/css/style.css" rel="stylesheet">

    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
    <link href="/resources/css/themes/all-themes.css" rel="stylesheet" />
    
    
    <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
</head>

<body class="theme-red">
    <!-- Page Loader -->
    <div class="page-loader-wrapper">
        <div class="loader">
            <div class="preloader">
                <div class="spinner-layer pl-red">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
            <p>Please wait...</p>
        </div>
    </div>
    
    <div class="overlay"></div>
    <div id="space-margin" style="height:50px;"></div>
    
    <nav class="navbar">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="/admin/main"style="height:100%;"><h1>수업을 도와줘</h1></a>
            </div>
        </div>
    </nav>
    <!-- #Top Bar -->
    <section>
        <!-- Left Sidebar -->
        <aside id="leftsidebar" class="sidebar" style="margin-top: 50px;">
            <!-- User Info -->
            <div class="user-info">
                <div class="image">
                    <img src="/resources/images/user.png" width="48" height="48" alt="User" />
                </div>
                <div class="info-container">
                    <div class="name" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.username"/>
					</sec:authorize>
                    </div>                    
                    <div class="btn-group user-helper-dropdown">
                        <i class="material-icons" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">keyboard_arrow_down</i>
                        <ul class="dropdown-menu pull-right">
                            <li id="myPage"><a href="/admin/myPage?user_id=<sec:authentication property='principal.user.user_id'/>"><i class="material-icons" >person</i>내 정보</a></li>                            
                            <li role="seperator" class="divider"></li>
                            <li><a id='logout' href="javascript:void(0);"><i class="material-icons">input</i>로그아웃</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- #User Info -->
            <!-- Menu -->
            <div class="menu">
                <ul class="list">
                    <li class="header">목록</li>
                    <li>
                        <a href="/admin/main">
                            <i class="material-icons">home</i>
                            <span>메인</span>
                        </a>
                    </li>
                    <li>
                    	<a href="/admin/questions">                        
                       		<i class="material-icons">forum</i>
                       		<span>문의사항</span>
                       	</a>                       
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="menu-toggle">
                           <i class="material-icons">person</i>
                    		<span>회원관리</span>
                        </a>
                        <ul class="ml-menu">
                            <li>
                                <a href="/admin/userTypeList?user_auth=ROLE_ADMIN">관리자계정</a>
                            </li>
                            <li>
                                <a href="/admin/userTypeList?user_auth=ROLE_TEACHER">강사계정</a>
                            </li>
                            <li>
                                <a href="/admin/userTypeList?user_auth=ROLE_STUDENT">학생계정</a>
                            </li>
                        </ul>
                    </li>                                 
                    <li>
                        <a href="javascript:void(0);" class="menu-toggle">
                            <i class="material-icons">person_add</i>
                            <span>계정생성</span>
                        </a>
                        <ul class="ml-menu">
                            <li>
                                <a href="/admin/teacher_regist">강사계정생성</a>
                            </li>
                            <li>
                                <a href="/admin/admin_regist">관리자계정생성</a>
                            </li>
                        </ul>
                    </li>
                    <li style="display:none">
                        <a href="javascript:void(0);" class="menu-toggle">
                            <i class="material-icons">content_copy</i>
                            <span>Example Pages</span>
                        </a>
                        <ul class="ml-menu">
                            <li>
                                <a href="/resources/pages/examples/sign-in.html">Sign In</a>
                            </li>
                            <li>
                                <a href="/resources/pages/examples/sign-up.html">Sign Up</a>
                            </li>
                            <li>
                                <a href="/resources/pages/examples/forgot-password.html">Forgot Password</a>
                            </li>
                            <li class="active">
                                <a href="/resources/pages/examples/blank.html">Blank Page</a>
                            </li>
                            <li>
                                <a href="/resources/pages/examples/404.html">404 - Not Found</a>
                            </li>
                            <li>
                                <a href="/resources/pages/examples/500.html">500 - Server Error</a>
                            </li>
                        </ul>
                    </li> 
                </ul>
            </div>
            <!-- #Menu -->
            <!-- Footer -->
            <div class="legal">
                <div class="copyright">
                    &copy; 2016 - 2017 <a href="javascript:void(0);">AdminBSB - Material Design</a>.
                </div>
                <div class="version">
                    <b>Version: </b> 1.0.5
                </div>
            </div>
            <!-- #Footer -->
        </aside>
        <!-- #END# Left Sidebar -->
        <!-- Right Sidebar -->
        <!-- #END# Right Sidebar -->
    </section>

<form action="/customLogout" method='post' id="logoutForm">
	<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
</form>
<script>
$(document).ready(function(){
	$('#logout').on("click", function(e){
		e.preventDefault();
		$('#logoutForm').submit();
	});
	
	
});
</script>