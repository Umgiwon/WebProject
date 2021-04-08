<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.kh.jsp.board.model.vo.*, java.util.*" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
%>
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
	<%@ include file="../common/header.jsp" %>
	
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
				<% for(Board b : list) { %>
				<tr>
					<td id="<%= b.getBno()%>"><%=b.getBno() %></td>	
					<td><%=b.getBtitle() %></td>	
					<td><%=b.getBwriter() %></td>	
					<td><%=b.getBdate() %></td>	
					<td><%=b.getBcount() %></td>	
					<% if (b.getBoardfile() != null) { %>
					<td> @ </td>
					<% } else { %>
					<td> X </td>
					<% } %>
				</tr>
				<% } %>
			</table>		
		</div>
		
		<div class="btnArea" align="center">
			<br /><br />
			<% if( m != null ) { %>
			<button onclick="location.href='views/board/boardInsert.jsp'">
				작성하기
			</button>
		
		
		
		
		
		
		
			<% } %>
		</div>		
	</section>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>










