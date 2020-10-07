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
					
<!-- Add a placeholder for the Twitch embed -->
<div id="twitch-embed" style="height:100%; width:100%"></div>


				</div>
        		<div style="height:20%; width:100%; background-color:yellow;">menu</div>
        	</div>
        	<div style="width:20%; height:100%; background-color:green; float:right;">pop up</div>
        </div>
    </div>
</section>
<!-- Load the Twitch embed script -->
<script src="https://player.twitch.tv/js/embed/v1.js"></script>

<!-- Create a Twitch.Player object. This will render within the placeholder div -->
<script type="text/javascript">
  new Twitch.Player("twitch-embed", {
    channel: "kbo2"
  });
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		console.log(windowHeight);
		$('#height').css('height', windowHeight);
	});
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>