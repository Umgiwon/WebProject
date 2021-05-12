<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판 목록</title>
<c:import url="/views/common/head-config.jsp"/>
<style>
	section {
		width: 1000px;
		height: auto;
		background: black;
		color: white;
		margin-left: auto;
		margin-right: auto;
		padding: 50px;
		margin-top : 50px;
	}

	#thumbnailArea {
		width : 760px;
		height : auto;
		margin-left : auto;
		margin-right : auto;
	}
	
	.thumb-list {
		width : 220px;
		border : 1px solid yellow;
		display : inline-block;
		margin : 10px;
		aling : center;
	}
	
	.thumb-list:hover {
		opacity : 0.8;
		cursor : pointer;
	}
	
</style>
</head>
<body>
	<c:import url="/views/common/header.jsp"/>
	<section>
		<h2 align="center">사진 게시판</h2>
		<div id="thumbnailArea">
			<c:forEach var="t" items="${ list }">
			<div class="thumb-list" align="center" id="${ t.bno }">
				<div>
					<!--  게시글 대표 사진 -->
					<c:if test="${ !empty t.boardfile }">
					<%-- 게시글 대표사진이 있다면 --%>

					<img src="/myWeb/resources/thumb/${ t.boardfile }"
						width="200px" height="150px" />

					</c:if> <c:if test="${ empty t.boardfile }">
					<%-- 게시글 대표사진이 없다면 --%>

					<img src="/myWeb/assets/images/no-image.png" width="200px"
						height="150px" />

					</c:if>
				</div>

				<p>
					<!--  게시글 제목 -->
					No.
					${ t.bno } ${ t.btitle }
					<br /> 
					조회수 : ${ t.bcount }
				</p>
			</div>
			</c:forEach>
				<br /><br />
				<c:if test="${ !empty member }">
					<button onclick="location.href='views/thumb/thumbInsert.jsp';">작성하기</button>
				</c:if>
		</div>
	</section>
	
	<script>
	
	$('.thumb-list').on('click', function(){
		var bno = $(this).attr('id');
		
		location.href = '/myWeb/selectOne.tn?bno=' + bno;
	});
	
	</script>

	<c:import url="/views/common/footer.jsp"/>
</body>
</html>











