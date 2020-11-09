<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h4>
				강의 등록,신청 및 수업시작(강의내용 수정할려면 '수정하기'를 눌러주세요)
				<button type="button" class="btn bg-teal waves-effect" style="float:right" id="modify_Btn">강의수정</button>
			</h4>
			<br>
		</div>
		<div class="row clearfix">
			<!-- Default Example -->
			<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
				<div class="card">
						<div class="header">
							<h2>
								등록된 학생 목록 <input type="button" id="cancelBtn"class="btn bg-red waves-effect"
								 value="수강해제"style="float: right;">
								 <input type="button" id="all_cancel_select_Btn"class="btn bg-red waves-effect"
								 value="전체선택"style="float: right;">
								 <input type="button" id="all_cancel_Btn"class="btn bg-red waves-effect"
								 value="전체해제"style="float: right;">
									 <small>잘못 등록한 학생이있으면
									체크박스에 체크한뒤 버튼을 눌러주세요. </small>
							</h2>
						</div>
						<div class="panel-body">
							<div class="responsive-table">
								<div id="datatables-example_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="datatables-example_length">

											</div>
										</div>
										<div class="col-sm-6" style="text-align: right;">
											<div id="datatables-example_filter" class="dataTables_filter">
											</div>
										</div>
									</div>
									<table class="table table-striped table-bordered" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th class="sorting_asc" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 215px;">학 번</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 329px;">이 름</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 167px;">전화번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 150px;">수강신청</th>
											</tr>
										</thead>
										<tbody id="signup_tbody">
											<c:forEach items="${cancel}" var="teacher">
												<tr style="cursor: pointer;">
													<td><c:out value="${teacher.user_no }" /></td>
													<td><c:out value="${teacher.user_name}" /></td>
													<td><c:out value="${teacher.user_mobile }" /></td>
													<td>
														<div class="demo-checkbox">
																<input type="checkbox" class="cancel_lc"
																id="<c:out value="${teacher.user_no}"/>"
																value="<c:out value="${teacher.user_no}"/>"
																class="chk-col-pink"> 
																<label for="<c:out value="${teacher.user_no}"/>">신청</label>
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
				<div class="card">
					<form method="get" action="" name="sign_up">
						<div class="header">
							<h2>
								수강신청한 학생 목록 <input type="button" id="signBtn"class="btn bg-red waves-effect"
								 value="수강등록"style="float: right;">
									<input type="button" id="all_joinup_select_Btn"class="btn bg-red waves-effect"
								 value="전체선택"style="float: right;">
								 <input type="button" id="all_joinup_cancel_Btn"class="btn bg-red waves-effect"
								 value="전체해제"style="float: right;">
								 <input type="button" id="reject_Btn"class="btn bg-red waves-effect"
								 value="신청반려"style="float: right;">
									 <small>등록하고자 하는 학생이있으면
									체크박스에 체크한뒤 버튼을 눌러주세요.</small>
							</h2>

						</div>
						<div class="panel-body">
							<div class="responsive-table">
								<div id="datatables-example_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="datatables-example_length">

											</div>
										</div>
										<div class="col-sm-6" style="text-align: right;">
											<div id="datatables-example_filter" class="dataTables_filter">
											</div>
										</div>
									</div>
									<table class="table table-striped table-bordered" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th class="sorting_asc" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 215px;">학 번</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 329px;">이 름</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 167px;">전화번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 150px;">수강신청</th>
											</tr>
										</thead>
										<tbody id="cancel_tbody">
											<c:forEach items="${sign_up}" var="teacher">
												<tr style="cursor: pointer;">
													<td><c:out value="${teacher.user_no }" /></td>
													<td><c:out value="${teacher.user_name}" /></td>
													<td><c:out value="${teacher.user_mobile }" /></td>
													<td>
														<div class="demo-checkbox">
															<input type="checkbox" class="chk_not_reg"
																id="<c:out value="${teacher.user_no}"/>"
																value="<c:out value="${teacher.user_no}"/>"
																class="chk-col-pink"> 
																<label for="<c:out value="${teacher.user_no}"/>">신청</label>
														</div>
													</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- #END# Default Example -->
		</div>
		<!-- Draggable Handles -->
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<button type="button" id="start_class"
						class="btn btn-primary waves-effect" value="${lecture_no}"style="float: right;">수업시작</button>
				</div>
			</div>
		</div>
		<!-- #END# Draggable Handles -->
	</div>
</section>
<form id='operForm' action="/teacher/teacher_modify" method="get">
  <input type='hidden' name='lecture_no' value='<c:out value="${lecture_no}"/>'>
</form>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	function joinajax(){
	    // 강의 번호를 갖고 온다.
	    var lecture_no = ${lecture_no };
	   
	    // 체크박스의 학생의 id를 배열에 담는다.
	    var checkboxValues = [];
	    $(".chk_not_reg:checked").each(function(i) {
	        checkboxValues.push($(this).val());
	    });
	    console.log(checkboxValues);
	    
/* 	    var uncheck = [];
	    $(".chk_not_reg:not(:checked)").each(function(i){
	    	uncheck.push($(this).val());
		});
	    console.log(uncheck); 체크안된 사람들 값포함시킬의도*/
	   
	    // 사용자 ID(문자열)와 체크박스 값들(배열)을 name/value 형태로 담는다.
	    var allData = { "lecture_no": lecture_no, "checkArr": checkboxValues };
	    var allData2 = { "lecture_no": lecture_no};

	    $.ajax({
	        url:"/teacher/joinup",
	        type:'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
	        data: allData,
	        success:function(data){
	            alert("완료!");
	            //location.reload();
	            console.log(data);
	            //self.close();
				$("#signup_tbody").empty();
	            $.each(data, function (index, item) {
		            console.log(item);
		            console.log(item.user_name);
		            console.log(index);
		            
					
					var str = "";
		            str += "<tr style='cursor: pointer;'>";//c:out태그를 쓸떄는 굳이 다쓰지말고 밑에 +item.user_no+만 쓰면 가능
					str+="<td>"+item.user_no+"</td>";
					str+="<td>"+item.user_name+"</td>";
					str+="<td>"+item.user_mobile+"</td>";
					str+="<td><div class='demo-checkbox'>"
						+"<input type='checkbox' class='cancel_lc' id='"+item.user_no+"'"
						+" value='"+item.user_no+"'"
						+" class='chk-col-pink'>";
					str+="<label for="+item.user_no+">신청</label>";
					str+="</div>";
					str+="</td>";
					str+="</tr>";
						
		            $("#signup_tbody").append(str);
				});
	            //ajax안에 ajax
	    	    $.ajax({
	    	        url:"/teacher/cancelclean",
	    	        type:'POST',
	    			beforeSend : function(xhr){
	    				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	    			},
	    	        data: allData2,
	    	        success:function(data){
	    	            
	    	            //location.reload();
	    	            console.log(data);
	    	            //self.close();
	    				$("#cancel_tbody").empty();
	    	            $.each(data, function (index, item) {
	    		            console.log(item);
	    		            console.log(item.user_name);
	    		           
	    					var str = "";
	    		            str += "<tr style='cursor: pointer;'>";//c:out태그를 쓸떄는 굳이 다쓰지말고 밑에 +item.user_no+만 쓰면 가능
	    					str+="<td>"+item.user_no+"</td>";
	    					str+="<td>"+item.user_name+"</td>";
	    					str+="<td>"+item.user_mobile+"</td>";
	    					str+="<td><div class='demo-checkbox'>"
	    						+"<input type='checkbox' class='cancel_lc' id='"+item.user_no+"'"
								+" value='"+item.user_no+"'"
	    						+" class='chk-col-pink'>";
	    					str+="<label for="+item.user_no+">신청</label>";
	    					str+="</div>";
	    					str+="</td>";
	    					str+="</tr>";
	    						
	    		            $("#cancel_tbody").append(str);

	    				});           
	    	        },
	    	        error:function(jqXHR, textStatus, errorThrown){
	    	            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	    	            self.close();
	    	        }
	    	    });           
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	            self.close();
	        }
	    });
    
	}
	    ///////////////////////////////////////////////////////////////////////////////////
	    function cancelajax(){
		    // 강의 번호를 갖고 온다.
		    var lecture_no = ${lecture_no };
		    // 체크박스의 학생의 id를 배열에 담는다.
		    var checkboxValues = [];
		    $(".cancel_lc:checked").each(function(i) {
		        checkboxValues.push($(this).val());
		    });
		    console.log(checkboxValues);
		    // 사용자 ID(문자열)와 체크박스 값들(배열)을 name/value 형태로 담는다.
		    var allData = { "lecture_no": lecture_no, "checkArr": checkboxValues };
		    var allData2 = { "lecture_no": lecture_no};		     
		    $.ajax({
		        url:"/teacher/cancel",
		        type:'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
		        data: allData,
		        success:function(data){
		            alert("완료!");
		            //location.reload();
		            console.log(data);
		            //self.close();
		            $("#cancel_tbody").empty();
		            $.each(data, function (index, item) {
			            console.log(item);
			            console.log(item.user_name);
			            console.log(index);
			            
						
						var str = "";
			            str += "<tr style='cursor: pointer;'>";//c:out태그를 쓸떄는 굳이 다쓰지말고 밑에 +item.user_no+만 쓰면 가능
						str+="<td>"+item.user_no+"</td>";
						str+="<td>"+item.user_name+"</td>";
						str+="<td>"+item.user_mobile+"</td>";
						str+="<td><div class='demo-checkbox'>"
							+"<input type='checkbox' class='chk_not_reg' id='"+item.user_no+"'"
							+" value='"+item.user_no+"'"
							+" class='chk-col-pink'>";
						str+="<label for="+item.user_no+">신청</label>";
						str+="</div>";
						str+="</td>";
						str+="</tr>";
							
			            $("#cancel_tbody").append(str);
			            
					});
		            //ajax안에 ajax
		    	    $.ajax({
		    	        url:"/teacher/sign_up_clean",
		    	        type:'POST',
		    			beforeSend : function(xhr){
		    				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    			},
		    	        data: allData2,
		    	        success:function(data){
		    	            
		    	            //location.reload();
		    	            console.log(data);
		    	            //self.close();
		    				$("#signup_tbody").empty();
		    	            $.each(data, function (index, item) {
		    		            console.log(item);
		    		            console.log(item.user_name);
		    		           
		    					var str = "";
		    		            str += "<tr style='cursor: pointer;'>";//c:out태그를 쓸떄는 굳이 다쓰지말고 밑에 +item.user_no+만 쓰면 가능
		    					str+="<td>"+item.user_no+"</td>";
		    					str+="<td>"+item.user_name+"</td>";
		    					str+="<td>"+item.user_mobile+"</td>";
		    					str+="<td><div class='demo-checkbox'>"
		    						+"<input type='checkbox' class='cancel_lc'id='"+item.user_no+"'"
									+" value='"+item.user_no+"'"
		    						+" class='chk-col-pink'>";
		    					str+="<label for="+item.user_no+">신청</label>";
		    					str+="</div>";
		    					str+="</td>";
		    					str+="</tr>";
		    						
		    		            $("#signup_tbody").append(str);

		    				});           
		    	        },
		    	        error:function(jqXHR, textStatus, errorThrown){
		    	            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		    	            self.close();
		    	        }
		    	    });   
		            
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		            self.close();
		        }
		    });
	}
////////////////////////////////////////////////////
	    function rejectajax(){
		    // 강의 번호를 갖고 온다.
		    var lecture_no = ${lecture_no };
		    // 체크박스의 학생의 id를 배열에 담는다.
		    var checkboxValues = [];
		    $(".chk_not_reg:checked").each(function(i) {
		        checkboxValues.push($(this).val());
		    });
		    console.log(checkboxValues);
		    
	/* 	    var uncheck = [];
		    $(".chk_not_reg:not(:checked)").each(function(i){
		    	uncheck.push($(this).val());
			});
		    console.log(uncheck); 체크안된 사람들 값포함시킬의도*/
		   
		    // 사용자 ID(문자열)와 체크박스 값들(배열)을 name/value 형태로 담는다.
		    var allData = { "lecture_no": lecture_no, "checkArr": checkboxValues };
		    var allData2 = { "lecture_no": lecture_no};

		    $.ajax({
		        url:"/teacher/reject",
		        type:'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
		        data: allData,
		        success:function(data){
		            alert("완료!");
		            //location.reload();
		            console.log(data);
		            //self.close();
		    	    $.ajax({
		    	        url:"/teacher/cancelclean",
		    	        type:'POST',
		    			beforeSend : function(xhr){
		    				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    			},
		    	        data: allData2,
		    	        success:function(data){
		    	            
		    	            //location.reload();
		    	            console.log(data);
		    	            //self.close();
		    				$("#cancel_tbody").empty();
		    	            $.each(data, function (index, item) {
		    		            console.log(item);
		    		            console.log(item.user_name);
		    		           
		    					var str = "";
		    		            str += "<tr style='cursor: pointer;'>";//c:out태그를 쓸떄는 굳이 다쓰지말고 밑에 +item.user_no+만 쓰면 가능
		    					str+="<td>"+item.user_no+"</td>";
		    					str+="<td>"+item.user_name+"</td>";
		    					str+="<td>"+item.user_mobile+"</td>";
		    					str+="<td><div class='demo-checkbox'>"
		    						+"<input type='checkbox' class='cancel_lc' id='"+item.user_no+"'"
									+" value='"+item.user_no+"'"
		    						+" class='chk-col-pink'>";
		    					str+="<label for="+item.user_no+">신청</label>";
		    					str+="</div>";
		    					str+="</td>";
		    					str+="</tr>";
		    						
		    		            $("#cancel_tbody").append(str);

		    				});           
		    	        },
		    	        error:function(jqXHR, textStatus, errorThrown){
		    	            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		    	            self.close();
		    	        }
		    	    });           
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("에러 발생~~s \n" + textStatus + " : " + errorThrown);
		            self.close();
		        }
		    });
		}
	
	/////////////////////////////////////////////////////////////////   
	$(document).ready(function() {
		
		var operForm = $("#operForm");
		
		$('#modify_Btn').on("click",function(e){
			console.log("move modify");
			operForm.submit();
		});
		
		$('#start_class').on("click", function() {
			/* location.href = "/teacher/lecture/"; */
			console.log("start_class click");
	 		$('#actionForm').append("<input type='hidden' name='lecture_no' value='"
					+$(this).val()+"' />"); //href에 적혀져있는 값의 속성을 변경,추가한다.
			$('#actionForm').attr("action","/teacher/lecture");
			$('#actionForm').submit();
		});
		
		$('#signBtn').on("click", function() {
			console.log("signbtn!!!");
			joinajax();
		});
		
		$('#cancelBtn').on("click", function() {
			cancelajax();
		});
		
		$('#reject_Btn').on("click", function() {
			rejectajax();
		});
		
		$("#all_cancel_select_Btn").click(function(){
			$('.cancel_lc[type=checkbox]').prop('checked',true);
	    })
	    $("#all_cancel_Btn").click(function(){
			$('.cancel_lc[type=checkbox]').prop('checked',false);
	    })

	    $("#all_joinup_select_Btn").click(function(){
			$('.chk_not_reg[type=checkbox]').prop('checked',true);
	    })
	    $("#all_joinup_cancel_Btn").click(function(){
			$('.chk_not_reg[type=checkbox]').prop('checked',false);
	    })
	    
	});
</script>
<form id='actionForm' action="/teacher/lecture" method='get'>
</form>
<%@ include file="/WEB-INF/views/include/footer_teacher.jsp"%>