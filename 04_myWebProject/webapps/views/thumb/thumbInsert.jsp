<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시글 작성</title>
<%@ include file="../common/head-config.jsp"%>
<style>
	section {
		width : 800px;
		height : 700px;
		background : black;
		color : white;
		margin-left : auto;
		margin-right : auto;
		margin-top : 50px;
		padding : 30px;
	}
	
	table {
		border: 1px solid white;
	}
	
	#insertArea {
		width : 500px;
		height : 450px;
		margin-left : auto;
		margin-right : auto;
	}
	
	#titleImgArea {
		width : 350px;
		height : 200px;
		border : 2px dashed gray;
		text-align : center;
		display : table-cell;
		vertical-align : middle;
	}
	
	[id*=ImgArea]:hover {
		cursor : pointer;
	}
	
	[id*=contentImgArea] {
		width : 150px;
		height : 100px;
		border : 2px dashed grey;
		text-align : center;
		display : table-cell;
		vertical-align : middle;
	}
	
	#btnArea {
		margin-top : 15px;
		margin-left : auto;
		margin-right : auto;
		text-align : center;
	}
	
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<section>
	
		<h2 align="center">사진 게시글 작성</h2>
		<form action="/myWeb/insert.tn" method="post" enctype="multipart/form-data">
			<div id="insertArea">	<!-- 게시글 추가 영역 -->
				<input type="hidden" name="userId" value="<%=m.getUserId() %>" />
				<table align="center">
				
					<tr>
						<td width="100px"> 제목 </td>
						<td colspan="3">
							<input type="text" name="btitle" size="53"/>
						</td>
					</tr>
					<tr>
						<td> 대표 이미지</td>
						<td colspan="3">
							<div id="titleImgArea">
								<img src="/myWeb/assets/images/no-image.png"  
									 id="titleImg" width="400px" height="200px"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>내용 사진</td>			
						<td>
							<div id="contentImgArea1">
								<img src="/myWeb/assets/images/no-image.png" 
									 id="contentImg1" width="120" height="100" />
							</div>
						</td>
						<td>
							<div id="contentImgArea2">
								<img src="/myWeb/assets/images/no-image.png" 
									 id="contentImg2" width="120" height="100" />
							</div>
						</td>
						<td>
							<div id="contentImgArea3">
								<img src="/myWeb/assets/images/no-image.png" 
									 id="contentImg3" width="120" height="100" />
							</div>
						</td>
					</tr>
					<tr>
						<td>사진 메모</td>
						<td colspan="3">
							<textarea name="bcontent" cols="53" rows="5" style="resize : none;"></textarea>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="fileArea" id="fileArea">
				<!--  첨부 사진 추가 영역 -->
				<!-- (input:file#thumbImg$[name=thumbImg$ onchange=loadImg(this,$)])*4  -->
				<input type="file" accept="image/*" name="thumbImg1" id="thumbImg1" onchange="loadImg(this, 1);" />
				<input type="file" accept="image/*" name="thumbImg2" id="thumbImg2" onchange="loadImg(this, 2);" />
				<input type="file" accept="image/*" name="thumbImg3" id="thumbImg3" onchange="loadImg(this, 3);" />
				<input type="file" accept="image/*" name="thumbImg4" id="thumbImg4" onchange="loadImg(this, 4);" />
			</div>
			
			<div id="btnArea">
				<button type="submit">작성 완료</button> &nbsp;
				<button type="reset">작성 취소</button>	
			</div>
			
		</form>
	<script>
		$('#titleImgArea').on('click', function() { 
			$('#thumbImg1').click();
		});
		
		$('#contentImgArea1').on('click', function() {
			$('#thumbImg2').click();
		});
		
		$('#contentImgArea2').on('click', function() {
			$('#thumbImg3').click();
		});
		
		$('#contentImgArea3').on('click', function() {
			$('#thumbImg4').click();
		});
		
		$('#fileArea').hide();
		
		// 사진 미리보기 구현
		function loadImg(img, num) {
			if (img.files && img.files[0]) {

				var reader = new FileReader();

				reader.onload = function(e) {

					switch (num) {
					case 1: 
						$('#titleImg').attr('src', e.target.result); 
						break;
					case 2:
						$('#contentImg1').attr('src', e.target.result);
						break;
					case 3:
						$('#contentImg2').attr('src', e.target.result);
						break;
					case 4:
						$('#contentImg3').attr('src', e.target.result);
						break;
					}
				}

				reader.readAsDataURL(img.files[0]);
			}
			

		}
	</script>
	</section>

	<%@ include file="../common/footer.jsp"%>
</body>
</html>









