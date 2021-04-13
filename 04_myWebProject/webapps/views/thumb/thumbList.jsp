<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.kh.jsp.thumb.model.vo.*, java.util.*"%>
<%
	ArrayList<Thumbnail> list = (ArrayList<Thumbnail>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판 목록</title>
<%@ include file="../common/head-config.jsp"%>
<style>
section {
	width: 1000px;
	height: auto;
	background: black;
	color: white;
	margin-left: auto;
	margin-right: auto;
	padding: 50px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<section>
		<h2 align="center">사진 게시판</h2>
		<div id="thumbnailArea">
			<% for (Thumbnail t : list ) { %>
			<div class="thumb-list" align="center" id="<%=t.getBno() %>">
				<div>
					<!--  게시글 대표 사진 -->
					<% if (t.getBoardfile() != null) { %>
					<%-- 게시글 대표사진이 있다면 --%>

					<img src="/myWeb/resources/thumb/<%= t.getBoardfile() %>"
						width="200px" height="150px" />

					<% } else {%>
					<%-- 게시글 대표사진이 없다면 --%>

					<img src="/myWeb/assets/images/no-image.png" width="200px"
						height="150px" />

					<% } %>
				</div>

				<p>
					<!--  게시글 제목 -->
					No.
					<%= t.getBno() %> <%= t.getBtitle() %>
					<br /> 
					조회수 : <%= t.getBcount() %>
				</p>
			</div>
			<% } %>
				<br /><br />
				<% if ( m != null ) { %>
					<button onclick="location.href='views/thumb/thumbInsert.jsp';">작성하기</button>
				<% } %>
		</div>
	</section>

	<%@ include file="../common/footer.jsp"%>
</body>
</html>











