<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<section class="content" >
    <div class="container-fluid">
        <div class="block-header" id="height" >
        	<div style="width:80%;  height:100%; float:left;">
        		<div style="height:80%; width:100%; background-color:red;">
					<iframe src="https://tv.kakao.com/embed/player/livelink?service=kakao_tv&amp;autoplay=1&amp;profile=HIGH&amp;wmode=transparent&amp;liveLinkId=9333611" allow="autoplay, fullscreen" allowfullscreen="" style="width: 100%; height: 100%; border: 0px;"></iframe>
				</div>
        		<div style="height:20%; width:100%; background-color:yellow;">menu</div>
        	</div>
        	<div style="width:20%; height:100%; background-color:green; float:right;">pop<br>up</div>
        </div>
    </div>
</section>
<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		console.log(windowHeight);
		$('#height').css('height', windowHeight);
	});
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>