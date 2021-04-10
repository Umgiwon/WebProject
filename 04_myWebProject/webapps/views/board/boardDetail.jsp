<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.jsp.board.model.vo.*" %>
<%
				// Object --> Board
	Board b = (Board)request.getAttribute("board"); // 서블릿(서버)이 보낸 " board" 받아오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<%@ include file = "../common/head-config.jsp" %>
<%-- ↗↗이런 형식으로 설정 스크립트도 추가 가능 --%>
<style>
	section {
		width : 800px;
		height : auto;
		background: black;
		color : white;		
		margin-left : auto;
		margin-right : auto;
		margin-top : 50px;
		padding : 30px;
	}
	
	#tableArea {
		background : white;
		color : black;
	}
</style>
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
	<section>
		<h2 align="center"><%=b.getBtitle() %></h2>
		
		<div id="tableArea">
			<table align="center" width="750px">
				<tr>
					<td>작성자 :</td>
					<td><b><%= b.getBwriter() %></b></td>
					<td>작성일 :</td>
					<td><b><%= b.getBdate() %></b></td>
					<td>조회수 :</td>
					<td><b><%= b.getBcount() %></b></td>
				</tr>
				<%-- 파일이 null이 아니면서 파일 이름의 길이가 0보다 크다면 ( 파일이 있다면 ) --%>
				<% if ( b.getBoardfile() != null && b.getBoardfile().length() > 0) { %>
				<tr>
					<td>첨부 파일 : </td>
					<td colspan="5">
						<a href="/myWeb/resources/boardUploadFiles/<%= b.getBoardfile()%>" download>
						<%= b.getBoardfile() %>
						</a>
					</td>
				</tr>
				<% } %>
				<tr>
					<td colspan="6">
						<p id="content">
							<%= b.getBcontent() %>
						</p>
					</td>
				</tr>
			</table>			
		</div>
		<div align="center">
			<button onclick="goSelectList();">목록으로 돌아가기</button>
			<%-- 게시글 작성자와 로그인한 사용자의 아이디가 같다면 ( 작성자 라면 ) --%>
			<% if ( b.getUserId().equals(m.getUserId()))  {%>
			<button onclick="goUpdatePage();">수정하기</button>
			<% } %>
			
			<script>
				function goSelectList() {
					location.href = '/myWeb/selectList.bo';
				}
				
				function goUpdatePage() {
					location.href = '/myWeb/updateView.bo?bno=' + <%= b.getBno() %>;
				}
			</script>	
		</div>
	</section>
	<%@ include file = "../common/footer.jsp" %>
</body>
</html>













