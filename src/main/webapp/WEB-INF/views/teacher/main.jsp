<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<section class="content">
    <div class="container-fluid">
        <div class="block-header">
            <h2>Teacher PAGE</h2>
            <a href='./lecture'>./lecture</a>
            <a href='./teacher_check'>./check</a>
        </div>
    </div>
</section>


<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>