<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kh.jsp.thumb.model.vo.*"%>
<%
Thumbnail t = (Thumbnail) request.getAttribute("thumbnail");
ArrayList<Attachment> list = (ArrayList<Attachment>) request.getAttribute("attList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판 상세보기</title>
<%@ include file="../common/head-config.jsp"%>
<style>
section {
	width: 1000px;
	height: auto;
	background: black;
	color: white;
	margin-left: auto;
	margin-right: auto;
	margin-top: 50px;
}

.detail td {
	text-align: center;
	width: 1000px;
	border: 1px solid white;
}

#titleImgArea {
	width: 500px;
	height: 300px;
	margin-left: auto;
	margin-right: auto;
}

#contentArea {
	height: 30px;
}

.detailImgArea {
	width: 250px;
	height: 210px;
	margin-left: auto;
	margin-right: auto;
}

#titleImg {
	width: 500px;
	height: 300px;
}

.detailImg {
	width: 250px;
	height: 180px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<% if( m != null) { %> <%-- 로그인이 된 상태라면  --%>
	
	<section>
		<table class="detail" align="center">
			<tr>
				<td width="50px">제목</td>
				<td colspan="5"><%=t.getBtitle()%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=t.getBwriter()%></td>
				<td>조회수</td>
				<td><%=t.getBcount()%></td>
				<td>작성일</td>
				<td><%=t.getBdate()%></td>
			</tr>
			<tr>
				<td>대표사진</td>
				<td colspan="4">
					<div id="titleImgArea" align="center">
						<img src="/myWeb/resources/thumb/<%=list.get(0).getFilename()%>"
							id="titleImg" />
					</div>
				</td>
				<td><a
					href="/myWeb/resources/thumb/<%=list.get(0).getFilename()%>"
					download>
						<button>다운로드</button>
				</a></td>
			</tr>
		</table>
		<table class="detail">
			<tr>
				<% for (int i = 1; i < 4; i++) { %>
				<td>
					<div class="detailImgArea">
						<% if ((list.size() - 1) >= i) { %>
							<img src="/myWeb/resources/thumb/<%=list.get(i).getFilename()%>"
								class="detailImg" id="detailImg<%=i%>" /> 
								<a href="/myWeb/resources/thumb/<%=list.get(i).getFilename()%>" download>
								<button>다운로드</button>
							</a>
							
							<% if (t.getUserId().equals(m.getUserId())) { %>
							<a href="/myWeb/deletoOne.tn?fno=<%=list.get(i).getFno()%>&bno=<%= t.getBno()%>">
								<button>사진 삭제</button>
							</a>
							<% } %>						
						<% } else { %>
							<img src="/myWeb/assets/images/no-image.png" class="detailImg" />
						<% } %>
					</div>
				</td>
				<% } %>
			</tr>
			<tr>
				<td colspan="3">
					<button onclick="location.href='/myWeb/selectList.tn'">목록으로 돌아가기</button>
					<% if ( m.getUserId().equals(t.getUserId()) ) { %> <%-- 게시글 작성자 라면 --%>
					<button onclick="updateBoard();">수정하기</button>
					<button onclick="deleteBoard();">삭제하기</button>
					<script>
						function updateBoard(){
							
							location.href='/myWeb/updateView.tn?bno=<%= t.getBno() %>';
							
						}
						
						function deleteBoard() {
							
							location.href='/myWeb/delete.tn?bno=<%= t.getBno() %>';
							
						}
					</script>
					<% } %>
				</td>
			</tr>
		</table>
	</section>
	<% } else {  // 로그인 하지 않았다면 ( 비회원 상태라면 )   
		
		request.setAttribute("error-msg", "회원 전용 기능입니다. <br> 로그인 해주세요!");
		
		request.getRequestDispatcher("../common/errorPage.jsp").forward(request, response);
	
	   } %>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>


















