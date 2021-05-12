<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
		margin-left: auto;
		margin-right: auto;
	}
</style>
</head>
<body>
	<c:import url="/views/common/header.jsp"/>
	<section>
		
		<h2 align="center">게시글 수정</h2>		
	
		<div class="tableArea">	
			<form action="/myWeb/update.bo" method="post"
					enctype="multipart/form-data">
			<input type="hidden" name="bno" value="${ board.bno }" />
			<table>
				<tr>
					<td>제목</td>			
					<td colspan="3">
						<input type="text" name="btitle" size="40" value="${ board.btitle }"/>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="3">
						${ member.userName }
						<input type="hidden" name="userId" value="${ member.userId }"/>
					</td>
				</tr>	
				<c:if test="${ empty board.boardfile }">
				<tr>
					<td>기존 파일</td>
					<td colspan="3">
						<a href="/myWeb/resources/boardUploadFiles/${ board.boardfile }">
							${ board.boardfile }
						</a>
					</td>
				</tr>
				</c:if>
				<tr>
					<td>새 첨부 파일</td>
					<td colspan="3">
						<input type="file" name="file" id="file" />
					</td>
				</tr>		
				<tr>
					<td>내용</td>
					<td colspan="3">
						<textarea name="bcontent" cols="50" rows="15" 
								  style="resize:none;">${ board.bcontent }</textarea>
					</td>
				</tr>
			</table>
			
			<br />
			<div align="center">
				<button type="submit">작성 완료</button> &nbsp;
				<button type="button" onclick="deleteBoard();">게시글 삭제</button>
			</div>
			
			</form>
		</div>
	</section>
	<script>
		function deleteBoard() {
			location.href = '/myWeb/delete.bo?bno=${ board.bno }';		
		};
	</script>
	<c:import url="/views/common/footer.jsp"/>
</body>
</html>









