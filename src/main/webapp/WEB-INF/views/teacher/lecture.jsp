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
        		<div style="height:80%; width:100%;">
					<!-- Add a placeholder for the Twitch embed -->
					<div id="twitch-embed" style="height:100%; width:100%"></div>
				</div>
        		<div style="height:20%; width:100%;">
	        		<ul style="list-style:none; margin-top:30px">
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect" id="chkAttendance">출석확인</button></li>
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect" id="chkProgress">수행여부확인</button></li>
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect" id="chkHomework">과제제출보내기</button></li>
	        			
	        		</ul>
        		</div>
        	</div>
        	<div id="pop" style="width:20%; height:100%; float:right;">
        		<div style="height:50%;">
        			<div style="overflow:auto; height:100%; width:65%; float:left; background-color:green;">
        				<span class="label label-default">접속 유저</span>
        				<ul id="attendance" style="margin-top:30px;">
		        			<li>학생1 <i class="material-icons">cached</i></li>
		        			<li>학생2 <i class="material-icons">check_circle</i></li>
	        			
	        			</ul>
        			</div>
        			<div style="overflow:auto; height:100%; width:35%; float:right; background-color:gray;">
	        			<span class="label label-default">미접속 유저</span>
       					<ul id="nonAttendance" style="margin-top:30px;">
		       				<c:forEach items="${lectureUser}" var="userList">
	       						<li id="${userList}">${userList} </li>
		       				</c:forEach>
       					</ul>
        			</div>
				</div>
        		<div style="height:50%; background-color:yellow;">
        			<div style="overflow:auto; height:90%;" id="messages"></div>
        			<input style="margin-bottom:0;" type="text" id="messageinput" />
				</div>
			</div>
        </div>
    </div>
</section>


<!-- Load the Twitch embed script -->
<script src="https://player.twitch.tv/js/embed/v1.js"></script>
<!-- Create a Twitch.Player object. This will render within the placeholder div -->
<script type="text/javascript">
var options = {
	    width: '100%',
	    height: '100%',
	    channel: "${lectureInfo.lecture_twitchid}"
	  };

new Twitch.Player("twitch-embed", options);
</script>


<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		$('#height').css('height', windowHeight);
	});
</script>

<script type="text/javascript">
    var webSocket;

    function openSocket() {
    	if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
    		alert("이미 세션에 접속해있습니다.");
            return;
        }
        //webSocket = new WebSocket("ws://192.168.0.185:8080/echo/");
        var url="ws://localhost:8080/echo/";
            url+="${lectureInfo.lecture_no}";
        webSocket = new WebSocket(url);

        webSocket.onopen = function(event) {
            if (event.data === undefined)
                return;
            alert("세션에 문제가 있습니다.");
        };

        
        webSocket.onmessage = function(event) {
        	console.log(event.data);

        	var myJsonData=JSON.parse(event.data);
            $.each(myJsonData, function(key, value) {
            	//$("#messages").append(key+": "+value+"<br>");
            	if(key=='type' && value=='message'){
					$("#messages").append(myJsonData.name + ": " + myJsonData.data + "<br>");
					$("#messages").scrollTop($("#messages").height());
          		}
            	if(key=='type' && value=='attendance'){
            		//여기부터 수정해야함
					$("#messages").append(myJsonData.name);
					$("#messages").scrollTop($("#messages").height());
          		}
            });
        	
        };

        webSocket.onclose = function(event) {
        	alert('세션접속종료됨');
        };
    }

    function closeSocket() {
        webSocket.close();
    }


    openSocket();
    $("#chkProgress").on("click", function(e){
        var chkProgress={
        	    type: "chkProgress"
        	  };
    	webSocket.send(JSON.stringify(chkProgress));
    });
    $("#chkAttendance").on("click", function(e){
        var chkAttendance={
        	    type: "chkAttendance"
        	  };
    	webSocket.send(JSON.stringify(chkAttendance));
    });
    $("#chkHomework").on("click", function(e){
        var chkHomework={
        	    type: "chkHomework"
        	  };
    	webSocket.send(JSON.stringify(chkHomework));
    });

    $("#messageinput").on("keypress", function(e){
		if(e.keyCode==13){
			if($('#messageinput').val()!=""){
				var message={
		        	    type: "message",
		        	    data: $('#messageinput').val(),
		        	    name: "<sec:authentication property='principal.user.user_name'/>"
		        	  };
				webSocket.send(JSON.stringify(message));
				$("#messageinput").val("");
			}
		}
    });

    function sendAttendence() {
		var attendance={
        	    type: "attendance",
            	name: "<sec:authentication property='principal.user.user_name'/>"
        	  };
		webSocket.send(JSON.stringify(attendance));
    }
	sendAttendence();


    
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>