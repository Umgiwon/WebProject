<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.jsp.member.model.vo.Member" %>

<%
	Member m = (Member)session.getAttribute("member");
%>

<h1 align="center">Welcome to My Web!</h1>

<div class="loginArea">
	<% if ( m == null ) { %>
	<form action="/myWeb/login.me" method="post" id="loginForm">
		<table>
			<!-- tr>td*2 -->
			<tr>
				<td>
					<label class="text">ID : </label>
				</td>
				<td>
					<input type="text" name="userId"/>
				</td>
			</tr>
			<tr>
				<td>
					<label class="text">PWD : </label>
				</td>
				<td>
					<input type="password" name="userPwd" onkeyup="enterKey();">
				</td>
			</tr>
		</table>
		<div class="btns" align="center">
			<div id="memberJoinBtn" onclick="memberJoin()">회원가입</div>
			<div id="loginBtn" onclick='login()'>로그인</div> 
		</div>
	</form>
	<script>
		function enterKey(){
			if(window.event.keyCode == 13) {
				login();
			}
		}
	</script>
	<% } else { %>
	<div id="userInfo">
		<label><%= m.getUserName() %>님의 방문을 환영합니다.</label>
		<div class="btns" align="right">
			<div id="changeInfo" onclick="changeInfo()">정보수정</div>
			<div id="logoutBtn" onclick='logout()'>로그아웃</div> 
		</div>
		
	</div>
	<% } %>
</div>
<br clear="both"><br>
<div class="wrap">
	<nav>
		<!-- div.menu*3 -->
		<div class="menu" onclick="goHome();">Home</div>
		<div class="menu" onclick="goBoard();">게시판</div>
		<div class="menu" onclick="goThumbnail();">사진 게시판</div>
	</nav>
</div>

<script>
	function login(){
		$('#loginForm').submit();
	}
	
	function logout(){
		location.href="/myWeb/logout.me";
	}
	
	function memberJoin(){
		location.href="/myWeb/views/member/join.jsp";
	}
	
	function changeInfo(){
		location.href="/myWeb/views/member/memberUpdate.jsp";
	}
	
	function goHome(){
		location.href="/myWeb/index.jsp";
	}
	function goBoard(){
		location.href="/myWeb/selectList.bo";
	}
	function goThumbnail(){
		location.href="/myWeb/selectList.tn";
	}
</script>










