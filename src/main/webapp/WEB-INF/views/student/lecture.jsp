<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<section class="content" >
    <div class="container-fluid">
        <div class="block-header" id="height" >
        	<div style="width:80%;  height:100%; float:left;">
        		<div style="height:80%; width:100%;">
					<!-- Add a placeholder for the Twitch embed -->
					<div id="twitch-embed" style="height:100%; width:100%;"></div>
				</div>
        		<div style="height:20%; width:100%;">
	        		
        		</div>
        	</div>
        	<div id="pop" style="width:20%; height:100%; background-color:green; float:right;">        		
        		<div style="overflow:auto; height:50%; background-color:green;">
	        		<div id="chkProgressPop" style="display:none; height:50%;">강사의 진도를 다 따라잡았나요? <br><button id="chkProgressPopCheck">확인</button></div>
	        		<div id="chkHomeworkPop" style="display:none; height:50%;">파일제출할까요? <br><button id="chkHomeworkPopCheck">확인</button></div>
	        		
				</div>
        		<div style="height:40%; background-color:yellow;">
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
	//html decoder
	function decodeEntities(encodedString) {
	  var div = document.createElement('div');
	  div.innerHTML = encodedString;
	  return div.textContent;
	}



    var webSocket;

    function openSocket() {
    	if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
    		alert("이미 세션에 접속해있습니다.");
            return;
        }
        //webSocket = new WebSocket("ws://192.168.0.185:8080/echo/");
        var url="ws://localhost:8080/echo/";
	        url+="${lectureInfo.lecture_no}/";
	        url+=decodeEntities("<sec:authentication property='principal.user.user_name'/>");
        webSocket = new WebSocket(url);

        webSocket.onopen = function(event) {
            if (event.data === undefined)
                return;
            alert("세션에 문제가 있습니다.");
        };

        
        webSocket.onmessage = function(event) {
        	console.log(event.data);
        	
            var myJsonData=JSON.parse(event.data);
            	
           	if(myJsonData.type=='chkProgress'){
           		$("#chkProgressPop").fadeIn(300);
           	}
           	if(myJsonData.type=='chkHomework'){
           		$("#chkHomeworkPop").fadeIn(300);
           	}
           	if(myJsonData.type=='chkAttendance'){
           		var attendance={
                	    type: "attendance",
                	    name: "<sec:authentication property='principal.user.user_name'/>",
                    	id: "<sec:authentication property='principal.user.user_id'/>",
                	    role: "<sec:authentication property='principal.Authorities'/>"
                	  };
           		webSocket.send(JSON.stringify(attendance))
           	}
           	if(myJsonData.type=='message'){
				$("#messages").append(myJsonData.name + ": " + myJsonData.data + "<br>");
				$("#messages").scrollTop($("#messages").height());
           	}
           	
			
        };

        webSocket.onclose = function(event) {
            alert('세션접속종료됨');
        };
    }

    function closeSocket() {
        webSocket.close();
    }


	openSocket();

	$("#chkProgressPopCheck").on("click", function(e){
        var message={
        		 type: "progressChecked",
	        	 id: "<sec:authentication property='principal.user.user_id'/>"
        	  };
    	webSocket.send(JSON.stringify(message));
    	$("#chkProgressPop").fadeOut(300);
    });
	$("#chkHomeworkPopCheck").on("click", function(e){
        var message={
        		 type: "homeworkChecked",
	        	 id: "<sec:authentication property='principal.user.user_id'/>"
        	  };
    	webSocket.send(JSON.stringify(message));
    	$("#chkHomeworkPop").fadeOut(300);
    });


	$("#messageinput").on("keypress", function(e){
		//e.stopPropagation();
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
        	    name: "<sec:authentication property='principal.user.user_name'/>",
            	id: "<sec:authentication property='principal.user.user_id'/>",
        	    role: "<sec:authentication property='principal.Authorities'/>"
        	  };
		//webSocket.onopen = () =>webSocket.send(JSON.stringify(attendance)); //ie에선 람다식 안먹힘
		webSocket.onopen = function(){webSocket.send(JSON.stringify(attendance))};
    }
	sendAttendence();

	

	
</script>

<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>