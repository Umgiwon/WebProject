package com.kh.jsp.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.jsp.board.model.service.BoardService;
import com.kh.jsp.board.model.vo.Board;

/**
 * Servlet implementation class BoardSelectOne
 */
@WebServlet("/selectOne.bo")
public class BoardSelectOne extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardSelectOne() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 조회를 위한 게시글 번호 추출
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		// 게시글 서비스 객체 생성
		BoardService service = new BoardService();
		
		// 게시글 조회 서비스 시작 --> 서비스 Go!
		Board b= service.selectOne(bno);
		// b <-- 조회한 결과
		
		String page = "";
		
		if ( b!= null ) { // 게시글이 있었다면 . . .  
			
			request.setAttribute("board", b); // 'board'라는 이름으로 b 등록
			
			page = "views/board/boardDetail.jsp";	// 화면 경로 준비
			
		} else {
			
			request.setAttribute("error-msg", "게시글 조회 실패!");
			
			page = "views/common/errorPage.jsp";
			
		}
	
		request.getRequestDispatcher(page)
			   .forward(request, response);			// 화면으로 출발! 
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
