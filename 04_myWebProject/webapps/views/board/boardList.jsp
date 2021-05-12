<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="/myWeb/assets/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/myWeb/assets/css/header.css" />
<style>
	section {
		width : 900px;
		height:  auto;
		/* 좌우 가운데 정렬*/
		margin-left: auto;
		margin-right: auto;
		margin-top: 50px;
		padding: 30px;
		background: black;
		color : white;
	}
	.tableArea {
		width: 800px;
		height: auto;
		margin-left: auto;
		margin-right: auto;
	}
	
	table {
		padding: 15px;
		border: 1px solid yellow;
		text-align : center;
	}
</style>
</head>
<body>
	<c:import url="/views/common/header.jsp"/>
	<section>
		<br />
		<h2 align="center">게시글 목록</h2>	
		<div class="tableArea">
			<table align="center" id="listArea">
				<tr>
					<th width="75px;">글번호</th>
					<th width="300px;">제목</th>
					<th width="100px;">작성자</th>
					<th width="150px;">작성일</th>
					<th width="70px;">조회수</th>
					<th width="80px;">첨부파일</th>
				</tr>
			<c:forEach var="b" items="${ list }"> 
				<tr>
					<td id="${ b.bno }">${ b.bno }</td>	
					<td>${ b.btitle }</td>	
					<td>${ b.bwriter }</td>	
					<td>${ b.bdate }</td>	
					<td>${ b.bcount }</td>	
				<c:choose>
					<c:when test="${ not empty b.boardfile  }">
					<td> @ </td>
					</c:when>
					<c:otherwise>
					<td> X </td>
					</c:otherwise>
				</c:choose>
				</tr>
			</c:forEach>
				
			</table>		
		</div>
		
		<div class="btnArea" align="center">
			<br /><br />
			
			<c:if test="${ !empty member }">
			<button onclick="location.href='views/board/boardInsert.jsp'">
				작성하기
			</button>
		
			<script>
				$('#listArea td').on('mouseenter', function() {
					$(this).parent().css({'background' : 'yellow', 
									'cursor' : 'pointer', 
									'color' : 'red'});
				}).on('mouseout', function(){
					$(this).parent().css({'background' : 'black',
											'color' : 'white'});
				}).on('click', function() {
					var bno = $(this).parent().children().first()./*text();*/attr('id');
					
					//console.log(bno);
					location.href = "/myWeb/selectOne.bo?bno=" + bno;  // GET 방식
				});
			</script>
			</c:if>
		</div>		
		
		<div class="pagingArea" align="center">
		
			<button onclick="location.href = '/myWeb/selectList.bo?currentPage=1'">
				&lt;&lt;
			</button>	
			
			<c:if test="${ pi.currentPage <= 1 }">
				<button disabled> &lt; </button>
			</c:if><c:if test="${ pi.currentPage > 1 }">
				<button onclick="location.href='/myWeb/selectList.bo?currentPage=${ pi.currentPage - 1 }'"> &lt; </button>
			</c:if>
			
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${ pi.currentPage == p }">
					<button disabled> ${ p } </button>
				</c:if><c:if test="${ pi.currentPage != p }">
					<button onclick="location.href='/myWeb/selectList.bo?currentPage=${ p }'"> ${ p }</button>			
				</c:if>
			</c:forEach>
			
			<c:if test="${ pi.currentPage >= pi.maxPage }">
				<button disabled> &gt; </button>
			</c:if><c:if test="${ pi.currentPage < pi.maxPage }">
				<button onclick="location.href='/myWeb/selectList.bo?currentPage=${ pi.currentPage + 1}'"> &gt; </button>
			</c:if>
			
			<button onclick="location.href='/myWeb/selectList.bo?currentPage=${ pi.maxPage }'">
				&gt;&gt;
			</button>
			
		</div>
	</section>
	
	<c:import url="/views/common/footer.jsp"/>
</body>
</html>










