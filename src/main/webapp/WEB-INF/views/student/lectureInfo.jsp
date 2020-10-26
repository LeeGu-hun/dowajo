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
    	<label>강 사 명</label> :  <label><c:out value="${lein.lecture_twitchid}"/></label>
	</c:forEach>
    	<br>
    	<br>
    	<br>
    	<div>
    	<input type="button" id="callbtn" value="신청"> <input type="button" id="backbtn" value="목록으로">
    	</div>    	
   	</div>
   </div>
</section>

        


<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>