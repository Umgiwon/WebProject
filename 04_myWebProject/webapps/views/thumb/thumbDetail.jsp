<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판 상세보기</title>
<c:import url="/views/common/head-config.jsp"/>
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
	<c:import url="/views/common/header.jsp"/>
	<c:if test="${ !empty member }">
	<section>
		<table class="detail" align="center">
			<tr>
				<td width="50px">제목</td>
				<td colspan="5">${ thumbnail.btitle }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${ thumbnail.bwriter }</td>
				<td>조회수</td>
				<td>${ thumbnail.bcount }</td>
				<td>작성일</td>
				<td>${ thumbnail.bdate }</td>
			</tr>
			<tr>
				<td>대표사진</td>
				<td colspan="4">
					<div id="titleImgArea" align="center">
						<img src="/myWeb/resources/thumb/${ attList.get(0).filename }"
							id="titleImg" />
					</div>
				</td>
				<td><a
					href="/myWeb/resources/thumb/${ attList.get(0).filename }"
					download>
						<button>다운로드</button>
				</a></td>
			</tr>
		</table>
		<table class="detail">
			<tr>
				<c:forEach var="i" begin="1" end="4">
				<td>
					<div class="detailImgArea">
						<c:if test="${ (attList.size -1) >= i }"> 
							<img src="/myWeb/resources/thumb/${ attList.get(i).filename }"
								class="detailImg" id="detailImg${ i }" /> 
								<a href="/myWeb/resources/thumb/${ attList.get(i).filename }" download>
								<button>다운로드</button>
							</a>
							
							<c:if test="${ thumbnail.userId.equals(member.userId) }">
							<a href="/myWeb/deletoOne.tn?fno=${ attList.get(i).fno }&bno=${ thumbnail.bno }">
								<button>사진 삭제</button> 
							</a>
							</c:if>					
						</c:if><c:if test="${ (attList.size -1) < i }">
							<img src="/myWeb/assets/images/no-image.png" class="detailImg" />
						</c:if>
					</div>
				</td>
				</c:forEach>
			</tr>
			<tr>
				<td colspan="3">
					<button onclick="location.href='/myWeb/selectList.tn'">목록으로 돌아가기</button>
					<c:if test="${ member.userId.equals(thumbnail.userId) }">
					<button onclick="updateBoard();">수정하기</button>
					<button onclick="deleteBoard();">삭제하기</button>
					<script>
						function updateBoard(){
							
							location.href='/myWeb/updateView.tn?bno=${ thumbnail.bno }';
							
						}
						
						function deleteBoard() {
							
							location.href='/myWeb/delete.tn?bno=${ thumbnail.bno}';
							
						}
					</script>
					</c:if>
				</td>
			</tr>
		</table>
		<div id="replyArea">
			<div id="replyWriteArea">
				<form action="myWeb/insert.co" method="post">
					<input type="hidden" name="writer" value="${ member.userId }">
					<input type="hidden" name="bno" value="${ thumbnail.bno }>" />
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
			<c:if test="${ clist.size() ==0 }">
				<span>여러분이 새 댓글의 주인공이 되어 보세요!</span>
			</c:if><c:if test="${ clist.size() !=0 }">
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
					
					</c:if><c:if test="${ bco.clevel > 3 }">		
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
		
		
		</div>
		<script>

			// 게시글 번호 가져오기
			var bno = '${ thumbnail.bno }';
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
						+ '?writer=${ member.userId }'
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
	</c:if><c:if test="${ empty member }">  <!-- // 로그인 하지 않았다면 ( 비회원 상태라면 )   --> 
		
		<c:set var="error-msg" value="회원 전용 기능입니다.<br>로그인해주세요!"/>
		
		request.setAttribute("error-msg", "회원 전용 기능입니다. <br> 로그인 해주세요!");
		
		request.getRequestDispatcher("../common/errorPage.jsp").forward(request, response);
	
	</c:if>
	<c:import url="/views/common/footer.jsp"/>
</body>
</html>


















