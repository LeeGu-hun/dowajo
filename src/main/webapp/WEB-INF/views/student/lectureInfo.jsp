<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<section class="content" >
    
    <h3>강의정보</h3><br>
    
   <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card">
                        <div class="header bg-blue-grey">
                            <h2>
                                <label>강의실 이름</label> : <label><c:out value="${leIn.lecture_name}"/></label><br>
                            </h2>
                            
                        </div>
                        <div class="body">
                            <label>강의소개</label> : <label><c:out value="${leIn.lecture_description}"/></label><br>
                            <br>
                            <br>
						 <label>강사이름</label> :  <label><c:out value="${leIn.user_name}"/></label>
						 <br>
						 <br>
						 <br>
						 <div align="right">
						 <button type="button" class="btn bg-indigo waves-effect" data-toggle="modal" data-target="#defaultModal">신청</button>
						 <button type="button" class="btn bg-indigo waves-effect" id="backBtn">목록으로</button>
						 </div>
                        </div>
                    </div>
                </div>
</section>

<form id='actionForm' action="/student/lectureInfo" method='post'>
<input type='hidden' name='lecture_no' value='<c:out value="${leIn.lecture_no}"/>'>
<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>

<form id='backForm' action="/student/lectureSearch" method='get'>
<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
</form>


<div class="modal fade" id="defaultModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="defaultModalLabel">신청</h4>
                        </div>
                        <div class="modal-body">
                            	선택하신 강의를 신청하시겠습니까?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link waves-effect" id="subBtn">신청</button>
                            <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>            
          
    
<script type="text/javascript">
$(document).ready(function() {
	var form = $("#actionForm");
	var form2 = $("#backForm");
	
	$('#backBtn').on("click", function() {
		form2.submit();
	});		

	$('#subBtn').on("click", function() {		
		form.submit();
	});		
		
	
});


</script>
       


<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>