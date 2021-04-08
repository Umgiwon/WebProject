package com.kh.jsp.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.jsp.board.model.service.BoardService;
import com.kh.jsp.board.model.vo.Board;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class BoardInsert
 */
@WebServlet("/insert.bo")
public class BoardInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파일 업로드용 Request
		/**
		 * @param request / 속성 변경을 위한 원본 객체
		 * @param savePath / 파일 저장 경로
		 * @param maxSize / 저장 가능한 파일 최대크기
		 * @param encoding / ex) "UTF-8"
		 * @param FileRenamePolicy / 원본파일 이름을 서버에서 
		 *                           관리하기 편한 이름으로 
		 *                           바꾸는 정책
		 */
		// MultipartRequest
		// 1. 파일 저장 경로 
		String savePath = request.getServletContext().getRealPath("/resources/boardUploadFiles");
						
		
		// 2. 파일 허용 용량
		// 1024Byte -> 1KB --> 1024KB --> 1MB
		int maxSize = 1024 * 1024 * 10;	// 10MB
	
		// 3. multipart 로 전송된 것인지 확인하기
		if(! ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("error-mag", "multipart 전송이 아닙니다.");
			
			request.getRequestDispatcher("views/commom/errorPage.jsp").forward(request, response);
			
		}
		
		// 4. MultipartRequest 작성
		
		MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, 
												"UTF-8", new DefaultFileRenamePolicy());
		
		// ** DefaultFileRenamePolicy 는
		// 만약 폴더에 이미 있는 파일의 이름이 또 들어 올 경우
		// 해당 이름을 바꿔주는 정책
		// ex) 새 폴더 --> 새 폴더1 --> 새 폴더2 . . . 
		
		//-------------------------------------------------------
		
		// 5. 전송값 처리 
		String title = mr.getParameter("btitle");
		String content = mr.getParameter("bcontent");
		String userId = mr.getParameter("userId");
		
		System.out.println("확인 : " + title + ", " + content + ", " + userId);
		
		// 6. 함께 저장된 파일의 이름 추출하기
		String filename = mr.getFilesystemName("file");
		
		// 7. VO 작성하기
		Board b = new Board(title, content, userId, filename);
		
		// 8. 서비스 시작!
		BoardService service = new BoardService();
		
		int result = service.insertBoard(b);
		
		if ( result > 0 ) {
			response.sendRedirect("selectList.bo");
		} else {
			request.setAttribute("error-msg", "게시글 작성 실패!");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		}
		
		
		
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
