<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_admin.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
.myPageTable {
	margin:auto;
	width: 600px; height: 50px;
	background: yellow;
	font-size: 30px;
	text-align: center;	
	line-height: 50px;				
}
table, th, td {
        border: 1px solid #bcbcbc;
      }
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2>MY PAGE</h2>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<table class="myPageTable">
                    	<tdead>
	                    	<tr>	                    		
	                    		<td colspan="2">내 정보</td>	                    		
	                    	</tr>
                    	</tdead>
                    	<tbody>
                    		<tr>
                    			<td scope="row">아이디    </td>
                    			<td></td>
                    		</tr>
                    		<tr>
                    			<td scope="row">이름</td>
                    			<td>1</td>
                    		</tr>
                    		<tr>
                    			<td scope="row">소속</td>
                    			<td>1</td>
                    		</tr> 
                    		<tr>
                    			<td scope="row">이메일</td>
                    			<td>1</td>
                    		</tr>
                    		<tr>
                    			<td scope="row">연락처</td>
                    			<td>1</td>
                    		</tr>
                    	</tbody>
                    	<tfoot>
                    		<tr>
                    			<td><input type="button" value="he"></td>
                    			<td><input type="button" value="she"></td>
                    		</tr>
                    	</tfoot>
                    </table>
                                        
				</div>
			</div>			
		</div>
		<div></div>
	</div>
</section>

<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>