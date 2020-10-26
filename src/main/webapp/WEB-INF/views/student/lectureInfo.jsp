<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<section class="content" >
    
    <h3>강의정보</h3><br>
    <div id="container">        
   <div id="gongzi" style="overflow:auto; width:300px; height:100%; border: 1px solid black;">
   <c:forEach items="${leIn}" var="lein">
    	<label>강의실 이름</label> : <label><c:out value="${lein.lecture_name}"/></label><br>
    	<br>
    	<br>
    	<label>강의소개</label> : <label><c:out value="${lein.lecture_description}"/></label><br>
    	<br>
    	<br>
    	<label>강 사 명</label> :  <label><c:out value="${lein.lecture_afreecaid}"/></label>
	</c:forEach>
    	<br>
    	<br>
    	<br>
    	<div>
    	<input type="button" data-toggle="modal" data-target="#defaultModal" value="신청"> <input type="button" id="backBtn" value="목록으로">
    	</div>    	
   	</div>
   </div>
</section>
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
             <!-- Jquery Core Js -->
    <script src="../../plugins/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core Js -->
    <script src="../../plugins/bootstrap/js/bootstrap.js"></script>

    <!-- Select Plugin Js -->
    <script src="../../plugins/bootstrap-select/js/bootstrap-select.js"></script>

    <!-- Slimscroll Plugin Js -->
    <script src="../../plugins/jquery-slimscroll/jquery.slimscroll.js"></script>

    <!-- Bootstrap Notify Plugin Js -->
    <script src="../../plugins/bootstrap-notify/bootstrap-notify.js"></script>

    <!-- Waves Effect Plugin Js -->
    <script src="../../plugins/node-waves/waves.js"></script>

    <!-- Custom Js -->
    <script src="../../js/admin.js"></script>
    <script src="../../js/pages/ui/modals.js"></script>

    <!-- Demo Js -->
    <script src="../../js/demo.js"></script>
    
<script type="text/javascript">
$(document).ready(function() {
	$('#backBtn').on("click", function() {
		location.href = "./lectureSearch";
	});		
	
});


</script>
       


<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>