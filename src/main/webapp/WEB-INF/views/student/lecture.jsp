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
        		<div style="height:80%; width:100%;" id="lecture">
					<iframe src="http://play.afreecatv.com/${lectureInfo.lecture_afreecaid}/embed?autoplay=1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
					
				</div>
        		<div style="height:20%; width:100%;">
	        		
        		</div>
        	</div>
        	<div id="pop" style="width:20%; height:100%; float:right;">        		
        		<div style="height:50%; margin-bottom:0px" class="card" >        		
        		
        			
        			
        			
        			
   			
                    <div class="card" style="margin:0 auto; height:50%; display:none;" id="chkProgressPop">
                        <div class="header">
                            <h2>
                              	진도 체크
                            </h2>
                        </div>
                        <div class="body">
                           <div class="form-group">
                               <div class="form-line">
                                   <input type="text" class="form-control" value="강사의 진도까지 완료하셨나요?" readonly>
                               </div>
                           </div>
                           <button type="button" class="btn btn-primary m-t-15 waves-effect" id="chkProgressPopCheck">확인</button>
                        </div>
                    </div>
                    
                    <div class="card" style="margin:0 auto; height:50%; display:none;" id="chkHomeworkPop">
                        <div class="header">
                            <h2>
                              	파일 제출 (5MB 이하)
                            </h2>
                        </div>
                        <div class="body">
                           <div class="form-group">
                               <div class="form-line" id="uplodedHomework">
                                   <input type="file" name="uploadFile" class="form-control"> <!--  multiple -->
                               </div>
                           </div>
                           <button type="button" class="btn btn-primary m-t-15 waves-effect" id="chkHomeworkPopCheck" data-toggle="modal" data-target="#defaultModal">제출</button>
                        </div>
                    </div>
                    
                    
                
	        		
				</div>
				<div style="height:1px"></div>
        		<div style="height:50%; background-color:#FFEB3B; padding:10px 0px 10px 10px; margin-bottom:0px;" class="card">
        			<div style="overflow:auto; height:90%;" id="messages"></div>
        			<input style="width:80%; margin-top:6px;" type="text" id="messageinput" />
        			<button id="sendMsg" style="margin-right:10px;"  type="button" class="btn btn-default btn-circle waves-effect waves-green waves-circle waves-float pull-right" >
						<i class="material-icons">forum</i>
					</button>
				</div>
			</div>
        </div>
    </div>
    
    
    
    <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog" style="display: none;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="defaultModalLabel">파일 전송완료</h4>
                        </div>
                        <div class="modal-body">
                        	<div class="form-group">
                               <div class="form-line" id="fileResult_modal">
                               </div>
                            </div>
                        
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button>
                        </div>
                    </div>
                </div>
            </div>
    

</section>



<script type="text/javascript">
	$(document).ready(function(){
		var windowHeight=window.innerHeight;
		var navHeight=$('.navbar').height();
		$('#height').css('height', (windowHeight-navHeight)*0.95);
	});

	if(${lectureInfo.file_status}==true){
		$("#chkHomeworkPop").fadeIn(300);
	}
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
				var mynum=userNo.length;
				var mylecturenum=lectureNo.length;
				var myfile=result.substring(mylecturenum+mynum+2);
				$("#fileResult_modal").html("<input type='text' class='form-control' value='"+myfile+"이/가 업로드되었습니다.' readonly><br><br>");
				viewFile();
				var message={
	        		 type: "homeworkChecked",
		        	 id: "<sec:authentication property='principal.user.user_id'/>",
		        	 file: result
	        	  };
	    		webSocket.send(JSON.stringify(message));
			}
		});
	}
	/* -- 파일업로드 위한 추가 끝 ----------- */ 
	
	function viewFile(){
		var userNo="<sec:authentication property='principal.user.user_no'/>";
		var lectureNo="${lectureInfo.lecture_no}";
		$("#fileResult_modal").append("<h4 class='modal-title' id='defaultModalLabel'>제출한 파일 목록</h4>");
		$.ajax({
			url: '/file/viewFileList',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: {userNo:userNo, lectureNo:lectureNo},
			type: 'POST',             
            dataType: "json",
			success: function(result){
				var mynum=userNo.length;
				var mylecturenum=lectureNo.length;
				$.each(result, function(idx, val) {
					var realName=val.substring(mylecturenum+mynum+2);
					$("#fileResult_modal").append("<div id='div"+val+"' style='display:table;'><input style='display:table-cell; vertical-align:middle;' type='text' class='form-control' value='"+realName+"' readonly> <i style='display:table-cell; vertical-align:middle; cursor:pointer;' class='material-icons forFileDelete' id='"+val+"'>delete_forever</i></div>");
				});
			}
		});
		
	}

	$(document).on('click','.forFileDelete',function(){
		var fileName=$(this).attr("id");
		var userNo="<sec:authentication property='principal.user.user_no'/>";
		var lectureNo="${lectureInfo.lecture_no}";
		var fileDiv=$(this).closest("div");

		$.ajax({
			url: '/file/deleteFile',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: {lectureNo:lectureNo, fileName:fileName},
			type: 'POST',             
            dataType: "text",
			success: function(result){
				var mynum=userNo.length;
				var mylecturenum=lectureNo.length;
				var realName=result.substring(mylecturenum+mynum+2);
				alert(realName+"이/가 삭제되었습니다.");
				console.log('#div'+result);
				fileDiv.remove();
			}
		});
	}) 

	/* $(".forFileDelete").on("click", function(e){
		alert("눌림"));
        
    }); */
	/* $(".forFileDelete").on("click", function(e){
		alert("눌림"));
		var fileName=$(this).attr("id");
		alert(fileName);
	}); */
	



    var webSocket;

    function openSocket() {
    	if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
    		alert("이미 세션에 접속해있습니다.");
            return;
        }

        //var url="ws://192.168.0.185:8080/echo/";
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
            	window.open('/student/main','_self').close();
            	
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
               	var role=decodeEntities(myJsonData.role);
				if(role.includes("ROLE_TEACHER")){
					$('#lecture').html('<iframe src="http://play.afreecatv.com/${lectureInfo.lecture_afreecaid}/embed?autoplay=1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>');
				}
       		}
            	
           	if(myJsonData.type=='chkProgress'){
           		$("#chkProgressPop").fadeIn(300);
           	}
           	if(myJsonData.type=='clsProgress'){
           		$("#chkProgressPop").fadeOut(300);
           	}
           	if(myJsonData.type=='chkHomework'){
           		$("#chkHomeworkPop").fadeIn(300);
           	}
           	if(myJsonData.type=='clsHomework'){
           		$("#chkHomeworkPop").fadeOut(300);
           	}
           	if(myJsonData.type=='chkAttendance'){
           		sendAttendence();
           	}

           	if(myJsonData.type=='youtube'){
               	var adr=decodeEntities(myJsonData.data);
				$('#lecture').html('<iframe width="100%" height="100%" src="https://www.youtube.com/embed/'+adr+'?autoplay=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>');
				
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
    $("#sendMsg").on("click", function(e){
		if($('#messageinput').val()!=""){
			var message={
	        	    type: "message",
	        	    data: $('#messageinput').val(),
	        	    name: "<sec:authentication property='principal.user.user_name'/>"
	        	  };
			webSocket.send(JSON.stringify(message));
			$("#messageinput").val("");
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

	function setAttendanceHistory() {
		var userNo="<sec:authentication property='principal.user.user_no'/>";
		var lectureNo="${lectureInfo.lecture_no}";
		var attendState="입실";

		$.ajax({
			url: '/attend/putAttendance',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: {lecture_no:lectureNo, user_no:userNo, attendance_state:attendState},
			type: 'POST',             
            dataType: "text",
			success: function(result){
				console.log(result);
				
			}
		});
		
    }
    
	
    webSocket.onopen = function(){sendAttendence(); setAttendanceHistory();}
    
    


	
	
</script>

<%@ include file="/WEB-INF/views/include/footer_student.jsp" %>