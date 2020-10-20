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
	        		<div id="chkHomeworkPop" style="display:none; height:50%;">파일을 제출하세요 <br>
	        		
	        		<input type="file" name="uploadFile">
	        		<br><div id="uplodedHomework"></div>
	        		<br><button id="chkHomeworkPopCheck">확인</button></div>
	        		
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


	/* -- 파일업로드 위한 추가 ------------------------------------------ */ 
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	// 업로드 파일 확장자 필터링
	//var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");  //정규식
	var maxSize = 5242880;  //5MB

	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		/* if (regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		} */
		return true;
	}


	function fileUpload(){
	    var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		var userNo="<sec:authentication property='principal.user.user_no'/>";
		var lectureNo="${lectureInfo.lecture_no}";
		console.log(inputFile)
		console.log(files)
		
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/file/uploadAjaxAction/'+lectureNo+'/'+userNo,
			processData: false,
			contentType: false,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData,
			type: 'POST',
			dataType: 'text',  
			success: function(result){
				$("#uplodedHomework").html("<span>"+result+" 이/가 업로드 되었습니다.</span>")
			}
		});
	}
	/* -- 파일업로드 위한 추가 끝 ----------- */ 



    var webSocket;

    function openSocket() {
    	if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
    		alert("이미 세션에 접속해있습니다.");
            return;
        }
        //webSocket = new WebSocket("ws://192.168.0.185:8080/echo/");
        var url="ws://localhost:8080/echo/";
	        url+="${lectureInfo.lecture_no}/";
	        url+=decodeEntities("<sec:authentication property='principal.user.user_name'/>/");
	        url+=decodeEntities("<sec:authentication property='principal.user.user_no'/>");
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
            	window.open('http://localhost:8080/student/main','_self').close();
            	
            	//self.opener=self;
            	//window.close();
            	
            	//window.open('','_self').close();
            	     
            	//window.open('','_parent','');
                //window.close();
                
           		//alert("강의창은 하나만 띄울 수 있습니다.");
           		//window.close();
           	}
           	
           	if(myJsonData.type=='message'){
				$("#messages").append(myJsonData.name + ": " + myJsonData.data + "<br>");
				$("#messages").scrollTop($("#messages").height());
           	}
            	
           	if(myJsonData.type=='chkProgress'){
           		$("#chkProgressPop").fadeIn(300);
           	}
           	if(myJsonData.type=='chkHomework'){
           		$("#chkHomeworkPop").fadeIn(300);
           	}
           	if(myJsonData.type=='chkAttendance'){
           		sendAttendence();
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
		fileUpload();
        var message={
        		 type: "homeworkChecked",
	        	 id: "<sec:authentication property='principal.user.user_id'/>"
        	  };
    	webSocket.send(JSON.stringify(message));
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
        	    role: "<sec:authentication property='principal.Authorities'/>",
            	no: "<sec:authentication property='principal.user.user_no'/>"
        	  };
		//webSocket.onopen = () =>webSocket.send(JSON.stringify(attendance)); //ie에선 람다식 안먹힘
		webSocket.send(JSON.stringify(attendance));
    }
    webSocket.onopen = function(){sendAttendence();}
	
</script>

<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>