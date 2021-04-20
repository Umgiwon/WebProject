<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kh.jsp.thumb.model.vo.*, com.kh.jsp.boardComment.model.vo.*"%>
<%
Thumbnail t = (Thumbnail) request.getAttribute("thumbnail");
ArrayList<Attachment> list = (ArrayList<Attachment>) request.getAttribute("attList");
ArrayList<BoardComment> clist = (ArrayList<BoardComment>) request.getAttribute("clist");
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
		<div id="replyArea">
			<div id="replyWriteArea">
				<form action="<%= request.getContextPath() %>/insert.co" method="post">
					<input type="hidden" name="writer" value="<%= m.getUserId() %>">
					<input type="hidden" name="bno" value="<%= t.getBno() %>" />
					<input type="hidden" name="refcno" value="0" />
					<input type="hidden" name="clevel"  value="1"/>
					<input type="hidden" name="btype"  value="2"/>
					
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
			var bno = '<%= t.getBno() %>';
			var btype= 2;
			
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
							  + "&btype=" +btype;
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
	<% } else {  // 로그인 하지 않았다면 ( 비회원 상태라면 )   
		
		request.setAttribute("error-msg", "회원 전용 기능입니다. <br> 로그인 해주세요!");
		
		request.getRequestDispatcher("../common/errorPage.jsp").forward(request, response);
	
	   } %>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>


















