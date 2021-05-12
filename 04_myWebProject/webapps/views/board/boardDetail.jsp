<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<c:import url="/views/common/head-config.jsp"/>
<%-- <%@ include file = "../common/head-config.jsp" %> --%>
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
	
	#replyArea {
		width:800px;
		color:white;
		background:black;
		margin-left:auto;
		margin-right:auto;
		padding-bottom : 5px;
	}
	#replyArea textArea {
		border-radius: 10px;
		resize: none;
	}
	
	table[class*=replyList] td{
		color : black;
	}
	
	.replyList1 td { background : yellow; }
	.replyList2 td { background : cyan; }
	.replyList3 td { background : pink; }
</style>
</head>
<body>
	<c:import url="/views/common/header.jsp"/>
	<section>
		<h2 align="center">${ board.btitle }</h2>
		
		<div id="tableArea">
			<table align="center" width="750px">
				<tr>
					<td>작성자 :</td>
					<td><b>${ board.bwriter }</b></td>
					<td>작성일 :</td>
					<td><b>${ board.bdate }</b></td>
					<td>조회수 :</td>
					<td><b>${ board.bcount }</b></td>
				</tr>
				<%-- 파일이 null이 아니면서 파일 이름의 길이가 0보다 크다면 ( 파일이 있다면 ) --%>
				<c:if test="${ !empty board.boardfile && fn:length(board.boardfile) > 0 }">
				<tr>
					<td>첨부 파일 : </td>
					<td colspan="5">
						<a href="/myWeb/resources/boardUploadFiles/${ board.boardfile }" download>
						${ board.boardfile }
						</a>
					</td>
				</tr>
				</c:if>
				<tr>
					<td colspan="6">
						<p id="content">
							${ board.bcontent }
						</p>
					</td>
				</tr>
			</table>			
		</div>
		<div align="center">
			<button onclick="goSelectList();">목록으로 돌아가기</button>
			<%-- 게시글 작성자와 로그인한 사용자의 아이디가 같다면 ( 작성자 라면 ) --%>
			<%-- <% if ( b.getUserId().equals(m.getUserId()))  {%> --%>
			<%-- <c:if test="${ board.userId eq member.userId }"> --%>
			<c:if test="${ board.userId.equals(member.userId) }">
			<button onclick="goUpdatePage();">수정하기</button>
			</c:if>
			
			<script>
				function goSelectList() {
					location.href = '/myWeb/selectList.bo';
				}
				
				function goUpdatePage() {
					location.href = '/myWeb/updateView.bo?bno=${ board.bno }';
				}
			</script>	
		</div>
		
		<div id="replyArea">
			<div id="replyWriteArea">
				<form action="/myWeb/insert.co" method="post">
					<input type="hidden" name="writer" value="${ member.userId }">
					<input type="hidden" name="bno" value="${ board.bno }" />
					<input type="hidden" name="refcno" value="0" />
					<input type="hidden" name="clevel"  value="1"/>
					<input type="hidden" name="btype"  value="1"/>
					
					<table align="center">
						<tr>
							<td>댓글 작성</td>
							<td>
								<textarea name="replyContent" id="replyContent" 
								          cols="80" rows="3"></textarea>
							</td>
							<td>
								<button type="submit" id="addReply">
									댓글 등록
								</button>
							</td>
							
						</tr>
					</table>
				</form>	
			</div>
			
			<div class="replySelectArea">
			<!-- 댓글 목록 구현 영역 -->
			<c:if test="${ clist.size() == 0 }">
				<span>여러분이 새 댓글의 주인공이 되어 보세요!</span>
			</c:if><c:if test="${ clist.size() != 0 }">
			
			<c:forEach var="bco" items="${ clist }">
			<table id="replySelectTable" 
		      	 style="margin-left : ${ (bco.clevel -1) * 15 }px;
		      	 		width : ${ 800 - (bco.clevel -1) * 15 }px;"
		      	 class="replyList${ bco.clevel }">
		  		<tr>
		  			<td rowspan="2"> </td>
					<td><b>${ bco.cwriter }</b></td>
					<td>${ bco.cdate }</td>
					<td align="center">
 					<c:if test="${ member.userId.equals(bco.userId) }">
						<input type="hidden" name="cno" value="${ bco.cno }"/>
							  
						<button type="button" class="updateBtn" 
							onclick="updateReply(this);">수정하기</button>
							
						<button type="button" class="updateConfirm"
							onclick="updateConfirm(this);"
							style="display:none;" >수정완료</button> &nbsp;&nbsp;
							
						<button type="button" class="deleteBtn"
							onclick="deleteReply(this);">삭제하기</button>
							
					</c:if><c:if test="${ bco.clevel < 3 }">
						<input type="hidden" name="writer" value="${ member.userId }"/>
						<input type="hidden" name="refcno" value="${ bco.cno }" />
						<input type="hidden" name="clevel" value="${ bco.clevel }" />
						<button type="button" class="insertBtn" 
							 onclick="reComment(this);">댓글 달기</button>&nbsp;&nbsp;
							 
						<button type="button" class="insertConfirm"
							onclick="reConfirm(this);"
							style="display:none;" >댓글 추가 완료</button> 
							
					</c:if><c:if test="${ bco.clevel >= 3 }">
						<span> 마지막 레벨입니다.</span>
					</c:if>
					</td>
				</tr>
				<tr class="comment replyList${ bco.clevel }">
					<td colspan="3" style="background : transparent;">
					<textarea class="reply-content" cols="105" rows="3"
					 readonly="readonly">${ bco.ccontent }</textarea>
					</td>
				</tr>
			</table>
				
					
				</c:forEach>
			</c:if>
			</div>
		
		
		
		<script>

			// 게시글 번호 가져오기
			var bno = '${ board.bno }';
			var btype= 1;
			
			function reComment(obj) {
				// 추가 완료 버튼
				$(obj).siblings('.insertConfirm').css('display', 'inline');
				
				// 현재 클릭한 버튼 숨기기
				$(obj).css('display', 'none');
				
				// 대댓글 입력공간 만들기
				var htmlForm = 
					'<tr class="comment"><td></td>'
						+'<td colspan="3" style="background : transparent;">'
							+ '<textarea class="reply-content" style="background : ivory;" cols="105" rows="3"></textarea>'
						+ '</td>'
					+ '</tr>';
				
				$(obj).parents('table').append(htmlForm);
			}
		
			function reConfirm(obj){
				// 참조할 댓글 번호 가져오기
				var refcno = $(obj).siblings('input[name=refcno]').val();
				var level = $(obj).siblings('input[name=clevel]').val();
				
				level = Number(level) + 1;
				
				var content = $(obj).parent().parent().siblings()
				              .last().find('textarea').val();
				
				location.href = '/myWeb/insert.co'
						+ '?writer=${ meber.userId }'
						+ '&replyContent=' + content
						+ '&bno=' + bno
						+ '&refcno=' + refcno
						+ '&clevel=' + level
						+ '&btype=' +btype;
			}
			
			function updateReply(obj) {
				// 현재 버튼의 위치와 가장 가까운 textarea 접근하기
				$(obj).parent().parent().next().find('textarea').removeAttr('readonly');
				
				// 수정 완료 버튼 보이게 하기
				$(obj).siblings('.updateConfirm').css('display', 'inline');
				
				// 현재 클릭한 수정 버튼 숨기기
				$(obj).css('display', 'none');
			}
			
			function updateConfirm(obj) {
				// 수정을 마친 댓글 내용 가져오기
				var content = $(obj).parent().parent().next().find('textarea').val();
				
				// 댓글 번호 가져오기
				var cno = $(obj).siblings('input').val();
				
				location.href = "/myWeb/update.co?"
						      + "bno=" + bno
						      + "&cno=" + cno
						      + "&content=" + content
						      + '&btype=' +btype;
			}
			
			function deleteReply(obj){
				// 댓글 번호 가져오기
				var cno = $(obj).siblings('input').val();
				
				//console.log("삭제 댓글 번호 : " + cno + " / " + bno);
				
				location.href="/myWeb/delete.co"
					 + "?cno=" + cno + "&bno=" + bno + '&btype=' +btype;
				
			}
		</script>
		</div>
	</section>
	<c:import url="/views/common/footer.jsp"/>
</body>
</html>













