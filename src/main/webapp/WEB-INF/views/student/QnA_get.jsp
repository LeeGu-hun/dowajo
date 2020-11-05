<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<style>
.divBtn{
	margin-left: 20px;
}
.menu{
	padding: 20px;
}
.labelTxt{
	margin-right: 10px;
}
.txtTitle{
	height: 70px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
	background-color: #eee;
	text-align: center;
}
.txtContent{
	height: 70px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
	background-color: #eee;
}
.txtWriter{
	height: 50px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	background-color: #eee;	
	text-align: center;
}
table, tr, td{
	border: 1px solid black;
}
</style>
<body>
	<section class="content">
		<!-- start: Content -->
		<div id="content">
			<div class="col-md-12 top-20 padding-0">
				<div class="col-md-12">
					<div class="panel form-element-padding">
						<div class="panel-heading">
							<h4></h4>
						</div>
						<div class="panel-body" style="padding-bottom: 30px;">
							<form id='actionForm' action="/student/QnA_register" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
							<div class="row clearfix">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="card">
										<div class="header">
											<h2>
												<b>문의하기</b><small>글 등록</small>
											</h2>
										</div>
										<div class="body table-responsive">
											<div class="menu">
												<label class="labelTxt">번 호</label>
												<input type="text" name="qa_title" class="txtWriter" placeholder="제목 입력" value='<c:out value="${qa.qa_no }"/>' readonly>																								
											</div>
											<div class="menu">
												<label class="labelTxt">제 목</label>
												<input type="text" name="qa_title" class="txtTitle" value='<c:out value="${qa.qa_title }"/>' readonly>												
											</div>
											<div class="menu">
												<label class="labelTxt">내 용</label>
												<input type="text" name="qa_reply" class="txtContent" value='<c:out value="${qa.qa_content }"/>' readonly>
											</div>
											<div class="menu">
												<label class="labelTxt">작성자</label>
												<input type="text" name="qa_writer" class="txtWriter" value="<sec:authentication property='principal.user.user_id'/>" readonly>
											</div>
											<div class="menu">
												<label class="labelTxt">일 자</label>												
												<input type="text" name="qa_writer" class="txtWriter"  value='<fmt:formatDate pattern="yyyy/MM/dd" value="${qa.qa_date}" />' readonly>
											</div>
											<div class="menu">
												<label class="labelTxt">답 변</label>
												<input type="text" name="qa_reply" class="txtWriter" value='<c:out value="${qa.qa_reply }"/>' readonly>												
											</div>																						
											<hr>
											
											<div class="divBtn">																							
												<button type="button" id="btn" class="btn bg-blue-grey waves-effect">돌아가기</button>
											</div>
											
										</div>
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
<script>
$(document).ready(function(){		
	$('#btn').on("click", function(){
		history.back();
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>