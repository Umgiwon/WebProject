package com.kh.jsp.board.controller;

import java.io.File;
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
 * Servlet implementation class BoardUpdate
 */
@WebServlet("/update.bo")
public class BoardUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String savePath = request.getServletContext().getRealPath("/resources/boardUploadFiles");
		
		
		int maxSize = 1024 * 1024 * 10;
		
		
		if (! ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("error-msg", "멀티파트 전송이 아닙니다.");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	
		MultipartRequest mr = new MultipartRequest(request, savePath, maxSize,
													"UTF-8", new DefaultFileRenamePolicy());
	
		// 수정할 정보들을 추출
		int bno = Integer.parseInt(mr.getParameter("bno"));
		String btitle = mr.getParameter("btitle");
		String bcontent = mr.getParameter("bcontent");
		
		// 전송된 파일이름 추출
		String filename = mr.getFilesystemName("file");
		
		// 수정 전의 원본 데이터 가져오기
		BoardService service = new BoardService();
		
		Board b = service.selectOne(bno);
		
		b.setBtitle(btitle);
		b.setBcontent(bcontent);
		
		if( filename != null && filename.length()> 0) {
			//파일 이름이 null이 아니면서 글자 길이가 0보다 크다면 ? => 새 파일이 있다면 
			if(b.getBoardfile() != null ) {
				// 이전 파일이 있다면
				File prevFile = new File(savePath + "/" + b.getBoardfile()); 
				
				prevFile.delete();  // 원본 파일 삭제
			}
			
			// 새 파일 등록
			b.setBoardfile(filename);
			
		}
	
		int result = service.updateBoard(b);
	
		if ( result > 0) {
			response.sendRedirect("selectList.bo");
		} else {
			request.setAttribute("error-msg", "게시글 수정 실패!");
			
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
