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
        		<div style="height:80%; width:100%;" id="lecture">
        			<iframe src="http://play.afreecatv.com/${lectureInfo.lecture_afreecaid}/embed?autoplay=1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>

				</div>
        		<div style="height:20%; width:100%;">
        		
        			<table id="lecture_button">
        				<tr style="height:10px;"></tr>
        				<tr>
        					<td style="width:500px;">
        						<button type="button" class="btn btn-primary waves-effect" id="chkProgress">수행여부 확인하기</button>
        					</td>
        					<td style="width:500px;">
        						<button type="button" class="btn btn-primary waves-effect" id="chkHomework">과제제출 보내기</button>
        					</td>
        				</tr>
        				<tr style="height:10px;"></tr>
        				<tr>
        					<td style="width:500px;">
        						<button style="display:none;" type="button" class="btn btn-success waves-effect" id="clsProgress">수행여부 확인종료</button>
        					</td>
        					<td style="width:500px;">
        						<button style="display:none;" type="button" class="btn btn-success waves-effect" id="clsHomework">학생 과제 받기</button>
        					</td>
        				</tr>
        			</table>
        			
        		</div>
        	</div>
        	<div id="pop" style="width:20%; height:100%; float:right;">
        		<div style="height:50%;">
        			<div style="overflow:auto; height:100%; width:65%; float:left; background-color:#f8cb4f;">
        				<span class="label label-default">접속 유저</span>
        				<ul id="attendance" style="margin-top:30px;">
		        			<li id="<sec:authentication property='principal.user.user_id'/>"></li>
		        			
		        			<c:forEach items="${lectureUser}" var="userList">
	       						<div id="${userList.user_no}"></div>
		       				</c:forEach>
	        				
	        			</ul>
        			</div>
        			<div style="overflow:auto; height:100%; width:35%; float:right; background-color:gray;">
	        			<span class="label label-default">미접속 유저</span>
       					<ul id="nonAttendance" style="margin-top:30px;">
		       				<c:forEach items="${lectureUser}" var="userList">
	       						<li id="${userList.user_id}">${userList.user_name} </li>
		       				</c:forEach>
       					</ul>
        			</div>
				</div>
        		<div style="height:50%; background-color:#FFEB3B; padding:0px 0px 10px 10px;">
        			<div style="overflow:auto; height:90%;" id="messages"></div>
        			<input style="width:80%; margin-top:6px;" type="text" id="messageinput" />
        			<button style="margin-right:10px;"  type="button" class="btn btn-default btn-circle waves-effect waves-green waves-circle waves-float pull-right" >
						<i class="material-icons">forum</i>
					</button>
				</div>
			</div>
        </div>
    </div>
    <form id='receiveFile' action="/file/download" method='post'>
    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    	<input type='hidden' name="lectureNo" value="${lectureInfo.lecture_no}">
    	<c:forEach items="${lectureUser}" var="userList">
			<input type='hidden' id="file${userList.user_id}" name="fileName">
		</c:forEach>
    </form>
</section>




<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		var navHeight=$('.navbar').height();
		$('#height').css('height', (windowHeight-navHeight)*0.95);
	});

	if(${lectureInfo.file_status}==true){
		$("#clsHomework").fadeIn(300);
	}

</script>
<style>
	#lecture_button td {text-align: center;}
</style>


<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
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
        //var url="ws://192.168.0.185:8080/echo/";
        var url="ws://localhost:8080/echo/";
            url+="${lectureInfo.lecture_no}/";
            url+=decodeEntities("<sec:authentication property='principal.user.user_name'/>/");
            url+=decodeEntities("<sec:authentication property='principal.user.user_no'/>");
            console.log(url);
        webSocket = new WebSocket(url);

        webSocket.onopen = function(event) {
            if (event.data === undefined)
                return;
            alert("세션에 문제가 있습니다.");
        };

        
        webSocket.onmessage = function(event) {
        	console.log(event.data);

        	var myJsonData=JSON.parse(event.data);
			if(myJsonData.type=='overlap'){
            	
            	alert("강의창은 하나만 띄울 수 있습니다.");
            	window.open('http://localhost:8080/teacher/main','_self').close();
            	
            	//self.opener=self;
            	//window.close();
            	
            	//window.open('','_self').close();
            	     
            	//window.open('','_parent','');
                //window.close();
                
           		//alert("강의창은 하나만 띄울 수 있습니다.");
           		//window.close();
           	}
            
           	if(myJsonData.type=='message'){
				$("#messages").append(myJsonData.name + " : " + myJsonData.data + "<br>");
				$("#messages").scrollTop($("#messages")[0].scrollHeight);
       		}
           	if(myJsonData.type=='attendance'){
               	var name=decodeEntities(myJsonData.name);
               	var id=decodeEntities(myJsonData.id);
               	var role=decodeEntities(myJsonData.role);
               	var no=decodeEntities(myJsonData.no);

				$('#nonAttendance #'+ id ).remove();
				if(role.includes("ROLE_TEACHER")){
					$("#"+id).html(name);
				}
				else if(role.includes("ROLE_STUDENT")){
					$("#attendance #"+no).html('<li id="'+id+'" >' + name + '  <div style="display:inline; vertical-align: middle;" class="chkPg" id="chkPg'+id+'"></div> <div style="display:inline; vertical-align: middle;" class="chkHw" id="chkHw'+id+'"></div></li>');
				}
				
       		}
           	if(myJsonData.type=='nonAttendance'){
               	var name=decodeEntities(myJsonData.name);
               	var id=decodeEntities(myJsonData.id);
               	$('#attendance #'+ id ).remove();
				$("#nonAttendance").append('<li id="'+id+'" >' + name + '</li>');
				
       		}
           	if(myJsonData.type=='progressChecked'){
               	var id=decodeEntities(myJsonData.id);
               	$('#chkPg'+ id ).html("<i class='material-icons'>check_circle</i>");
				
       		}
           	if(myJsonData.type=='homeworkChecked'){
               	var id=decodeEntities(myJsonData.id);
               	var file=decodeEntities(myJsonData.file);
               	$('#chkHw'+ id ).html("<i class='material-icons'>cloud_done</i>");
               	$('#file'+ id ).val(file);
				
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
    $("#chkProgress").on("click", function(e){
		var str="<div class='preloader pl-size-xs'> <div class='spinner-layer pl-grey'> <div class='circle-clipper left'> <div class='circle'> </div> </div> <div class='circle-clipper right'> <div class='circle'> </div> </div> </div> </div>";
		$(".chkPg").html(str);
        
        var chkProgress={
        	    type: "chkProgress"
        	  };
    	webSocket.send(JSON.stringify(chkProgress));
    	$("#clsProgress").fadeIn(300);
    });
    $("#clsProgress").on("click", function(e){
		$(".chkPg").html("");
        
        var clsProgress={
        	    type: "clsProgress"
        	  };
    	webSocket.send(JSON.stringify(clsProgress));
    	$("#clsProgress").fadeOut(300);
    });
    
    $("#chkHomework").on("click", function(e){
    	var str="<img src='/resources/images/cloud.gif' style='height:30px; width:30px;' > ";
		$(".chkHw").html(str);
        
        var chkHomework={
        	    type: "chkHomework"
        	  };
    	webSocket.send(JSON.stringify(chkHomework));
    	$("#clsHomework").fadeIn(300);


    	$.ajax({
	        url: '/file/fileState',
	        data: {file_status: true, lecture_no: ${lectureInfo.lecture_no}}, //넘겨줄 데이터 1개인경우엔 이름 정의안해도 되는데 2개이상일경우 정의해줘야 하는 듯.
	        beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  //로그인 시큐리티 관련 token전달. 위에 hidden으로 토큰전달하듯이 ajax에선 이렇게 보내는듯.
			},
	        dataType: 'text',
	        type: 'POST',
	        success: function(result) {
	            console.log(result);
	        }
	    });
    	
    	
    });
    $("#clsHomework").on("click", function(e){
		$(".chkHw").html("");
        
        var clsHomework={
        	    type: "clsHomework"
        	  };
    	webSocket.send(JSON.stringify(clsHomework));
    	
		$("#receiveFile").submit();
    	//self.location = "/file/download?fileName=dream01.png";
        	// + "${product.filename}";
    	
    	$("#clsHomework").fadeOut(300);


    	$.ajax({
	        url: '/file/fileState',
	        data: {file_status: false, lecture_no: ${lectureInfo.lecture_no}}, //넘겨줄 데이터 1개인경우엔 이름 정의안해도 되는데 2개이상일경우 정의해줘야 하는 듯.
	        beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  //로그인 시큐리티 관련 token전달. 위에 hidden으로 토큰전달하듯이 ajax에선 이렇게 보내는듯.
			},
	        dataType: 'text',
	        type: 'POST',
	        success: function(result) {
	            console.log(result);
	        }
	    });

	    
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
            	name: "<sec:authentication property='principal.user.user_name'/>",
            	id: "<sec:authentication property='principal.user.user_id'/>",
            	role: "<sec:authentication property='principal.Authorities'/>",
            	no: "<sec:authentication property='principal.user.user_no'/>"
                	
        	  };
		//webSocket.onopen = () =>webSocket.send(JSON.stringify(attendance)); //function webSocket.onopen(){}과 같은 의미? webSocket.onopen = function(){}의 의미?
		//webSocket.onopen = function(){webSocket.send(JSON.stringify(attendance))};
		webSocket.send(JSON.stringify(attendance));
    }
    //sendAttendence();


    function checkAttendence() {
		var chkAttendance={
        	    type: "chkAttendance"
        	  };
		//webSocket.onopen = () =>webSocket.send(JSON.stringify(attendance)); //ie에선 람다식 안먹힘
		//webSocket.onopen = function(){webSocket.send(JSON.stringify(chkAttendance))};
		webSocket.send(JSON.stringify(chkAttendance));
    }
    //checkAttendence();

    webSocket.onopen = function(){sendAttendence(); checkAttendence();}

    

    
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>