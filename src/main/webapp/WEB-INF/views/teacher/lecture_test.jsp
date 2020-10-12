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
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect">출석확인</button></li>
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect" id="chkProgress">수행여부확인</button></li>
	        			<li style="display:inline; margin-right:100px"><button type="button" class="btn btn-primary waves-effect">과제제출보내기</button></li>
	        			
	        		</ul>
        		</div>
        	</div>
        	<div style="width:20%; height:100%; background-color:green; float:right;">
        		<div>
			        <input type="text" id="messageinput" />test
			    </div>
			    <div>
			        <button type="button" onclick="openSocket();">Open</button>
			        <button type="button" onclick="send();">Send</button>
			        <button type="button" onclick="closeSocket();">Close</button>
			    </div>
			    <!-- Server responses get written here -->
			    <div id="messages"></div>
			    
			   		<sec:authentication property='principal' var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						${pinfo}<br><br>
						${pinfo.username}<br><br>
						<sec:authentication property="principal.user"/><br><br>
						<sec:authentication property="principal.user.user_name"/><br><br>
						
					</sec:authorize>
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
	    channel: "childish1986"
	  };

new Twitch.Player("twitch-embed", options);
</script>


<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		//console.log(windowHeight);
		$('#height').css('height', windowHeight);
	});
</script>

<!-- Script to utilise the WebSocket -->
<script type="text/javascript">
    var webSocket;
    var messages = document.getElementById("messages");

    function openSocket() {
    	if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
    		alert("이미 소켓에 접속해있습니다.")
            //writeResponse("WebSocket is already opened.");
            return;
        }
        //webSocket = new WebSocket("ws://192.168.0.185:8080/echo");
        var url="ws://localhost:8080/echo/";
            url+="${lectureInfo.lecture_no}";
        //console.log(url);
        webSocket = new WebSocket(url);

        webSocket.onopen = function(event) {
            if (event.data === undefined)
                return;
            alert("세션에 문제가 있습니다.")
            //writeResponse(event.data);
        };

        
        webSocket.onmessage = function(event) {
        	//var msg = JSON.parse(event.data); 실패
        	//writeResponse(msg.type='type'); 실패
        	console.log(event.data);
        	
        	 

            writeResponse(event.data);
			var myJsonData=JSON.parse(event.data);
			for(var i in myJsonData){//데이터를 하나씩 뽑아냄
			    //i번째 data 중 key가 id인 것의 value
			      var test = myJsonData[i];
			      writeResponse(test);
			    }


         /* var msg = {
         	    type: "message",
         	    text: "mytest"
         	  };
       		 var jmsg=JSON.stringify(msg);
       		 var jjmsg=JSON.parse(jmsg); */

       		/* for(var i in jmsg){//데이터를 하나씩 뽑아냄
                 //i번째 data 중 key가 id인 것의 value
                   var test = jmsg[i];
                   writeResponse(test);
                 } */

             
         	/* $.each(jmsg, function(i, v) {
	   //i : data 내 객체의 인덱스.
	   //v : optiontext와 optionvalue 속성을 가지는 객체를 가리킴.
	   writeResponse(v);
	  }); */
            /* console.log("msg");
            console.log(msg);
            console.log("jmsg : ");
            console.log(jmsg);
            console.log("jjmsg : ");
            console.log(jjmsg);
            for(var i in jjmsg){//데이터를 하나씩 뽑아냄
            //i번째 data 중 key가 id인 것의 value
              var test = jjmsg[i];
              writeResponse(test);
            } */
        };

        webSocket.onclose = function(event) {
            writeResponse("Connection closed");
        };
    }

    /**
     * Sends the value of the text input to the server
     */

     //위에서 onopen한다음에 .send로 role정보를 보내야하나?
    function send() {
        var text = document.getElementById("messageinput").value;

        var msg = {
        	    type: "message",
        	    text: document.getElementById("messageinput").value,
        	    date: Date.now()
        	  };
        //webSocket.send(text);
        webSocket.send(JSON.stringify(msg));
    }

    function closeSocket() {
        webSocket.close();
    }

    function writeResponse(text) {
        messages.innerHTML += "<br/>" + text;
    }




    $("#chkProgress").on("click", function(e){
        var chkProgress={
        	    type: "chkProgress"
        	  };
    	webSocket.send(JSON.stringify(chkProgress));
    });
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>