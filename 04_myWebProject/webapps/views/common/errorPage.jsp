<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    
<%
	String msg = (String)request.getAttribute("error-msg");
%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>에러 페이지</title>
	<link rel="stylesheet" href="/myWeb/assets/css/header.css" />
	<style>
		section {
			width : 600px;
			padding : 20px;
			background : white;
			margin-left : auto;
			margin-right : auto;
		}
	</style>
	
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<section>
		<h1>서비스 에러 발생</h1>
		<h3 style="color : red;">ERROR :: <%= msg %></h3>
		<p>
		서비스 수행 중 에러가 발생하였습니다. <br />
		해당 페이지가 계속 보인다면, 담당자에게 문의하세요. <br />
		<br />
		<a href="/myWeb/index.jsp">홈 화면으로 돌아가기</a>
		
		</p>
	</section>
	
	<%@ include file="footer.jsp" %>
</body>
</html>
    
    
    