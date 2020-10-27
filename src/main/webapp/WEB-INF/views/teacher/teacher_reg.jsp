<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.uploadResult {width: 90%;background-color: gray;}
.uploadResult ul {display: flex;flex-flow: row;justify-content: left;align-items: center;}
.uploadResult ul li {list-style: none;padding: 10px;}
.uploadResult ul li img {width: 100px;}
.bigPictureWrapper {
	position: absolute;	display: none;justify-content: center;align-items: center;
	top: 0%;width: 100%;height: 100%;background-color: gray;z-index: 100;
}
.bigPicture {position: relative;display: flex;justify-content: center;align-items: center;}
.bigPicture img {width: 600px;}
span[data-type=file] + span[data-type=image] {cursor:pointer;}

.space-margin {height: 50px;}
.upload-title {
	background: #ccc; border: solid 1px #aaa; line-height: 30px; padding-left: 10px;
	border-radius: 5px 5px 0 0;color:black; font-weight: bold;	height: 30px;
}
.upload-box {
	border: solid 1px #aaa;border-radius: 0 0 5px 5px;min-height: 150px;
}
</style>


<%-- <section class="content">
    <div class="container-fluid">
        <div class="block-header">
            <h2>Teacher PAGE</h2>
        </div>
    </div>
</section> --%>
<body>
<section class="content" >
<!-- start: Content -->
<div id="content">
	<div class="panel box-shadow-none content-header">
		<div class="panel-body">
			<div class="col-md-12">
				<h3 class="animated fadeInLeft">게시판</h3>
				<p class="animated fadeInDown">
					게시판 <span class="fa-angle-right fa"></span>등록
				</p>
			</div>
		</div>
	</div>

	<div class="col-md-12 top-20 padding-0">
		<div class="col-md-12">
			<div class="panel form-element-padding">
				<div class="panel-heading">
					<h4>User Register</h4>
				</div>
				<div class="panel-body" style="padding-bottom: 30px;">
				<form role="form" action="/user/regist" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="col-md-12">
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">사용자 ID</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="id" id="id" /><p>
								사용자 ID는 영소문자, 숫자, '_'로 8~12자 이내
								<span id="idcheck" style="color:red;"></span>
								<div class="space-margin"></div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label text-right">이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="user_name" id="user_name">
								<div class="space-margin"></div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label text-right">비밀번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="password" id="password">
								<div class="space-margin"></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">비밀번호 확인</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="repassword">
								<div class="space-margin"></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">관리자 체크</label>
							<div class="col-sm-10">
								<label for="admin_user">관리자
								<input type="checkbox" class="form-control" name="admin_user" 
								id="admin_user"></label>
								<div class="space-margin"></div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label text-right"> </label>
							<div class="col-sm-10" style="text-align: right;">
								<input type="submit" id="submitBtn" 
									class=" btn btn-round btn-primary" value="Submit">
								<input type="button" id="resetBtn"
									class="btn btn-round btn-warning" value="Reset">
								<input type="button" id="backBtn"
									class="btn btn-round btn-info" value="Back">
								<div class="space-margin"></div>
							</div>
						</div>

					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
</div>
</section>
</body>
<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>