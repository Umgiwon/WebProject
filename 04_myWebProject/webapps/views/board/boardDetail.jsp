<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.jsp.board.model.vo.*, com.kh.jsp.boardComment.model.vo.*, java.util.*" %>
<%
				// Object --> Board
	Board b = (Board)request.getAttribute("board"); // 서블릿(서버)이 보낸 " board" 받아오기
	ArrayList<BoardComment> clist = (ArrayList<BoardComment>) request.getAttribute("clist");
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
		<div id="replyArea">
			<div id="replyWriteArea">
				<form action="<%= request.getContextPath() %>/insert.co" method="post">
					<input type="hidden" name="writer" value="<%= m.getUserId() %>">
					<input type="hidden" name="bno" value="<%= b.getBno() %>" />
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
			<% if (clist.size() == 0) { %>
				<span>여러분이 새 댓글의 주인공이 되어 보세요!</span>
			<% } else {
				for(BoardComment bco : clist) { %>
				
			<table id="replySelectTable"
		      	 style="margin-left : <%= (bco.getClevel()-1) * 15 %>px;
		      	 		width : <%= 800 - ((bco.getClevel()-1) * 15)%>px;"
		      	 class="replyList<%=bco.getClevel()%>">
		  		<tr>
		  			<td rowspan="2"> </td>
					<td><b><%= bco.getCwriter() %></b></td>
					<td><%= bco.getCdate() %></td>
					<td align="center">
 					<%if(m.getUserId().equals(bco.getUserId())) { %>
						<input type="hidden" name="cno" value="<%=bco.getCno()%>"/>
							  
						<button type="button" class="updateBtn" 
							onclick="updateReply(this);">수정하기</button>
							
						<button type="button" class="updateConfirm"
							onclick="updateConfirm(this);"
							style="display:none;" >수정완료</button> &nbsp;&nbsp;
							
						<button type="button" class="deleteBtn"
							onclick="deleteReply(this);">삭제하기</button>
							
					<% } else if( bco.getClevel() < 3) { %>
						<input type="hidden" name="writer" value="<%=m.getUserId()%>"/>
						<input type="hidden" name="refcno" value="<%= bco.getCno() %>" />
						<input type="hidden" name="clevel" value="<%=bco.getClevel() %>" />
						<button type="button" class="insertBtn" 
							 onclick="reComment(this);">댓글 달기</button>&nbsp;&nbsp;
							 
						<button type="button" class="insertConfirm"
							onclick="reConfirm(this);"
							style="display:none;" >댓글 추가 완료</button> 
							
					<% } else {%>
						<span> 마지막 레벨입니다.</span>
					<% } %>
					</td>
				</tr>
				<tr class="comment replyList<%=bco.getClevel()%>">
					<td colspan="3" style="background : transparent;">
					<textarea class="reply-content" cols="105" rows="3"
					 readonly="readonly"><%= bco.getCcontent() %></textarea>
					</td>
				</tr>
			</table>
				
					
			<%
				}
			}
			%>
			</div>
		
		
		</div>
		<script>

			// 게시글 번호 가져오기
			var bno = '<%= b.getBno() %>';
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
						+ '?writer=<%= m.getUserId()%>'
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
		
	</section>
	<%@ include file = "../common/footer.jsp" %>
</body>
</html>













