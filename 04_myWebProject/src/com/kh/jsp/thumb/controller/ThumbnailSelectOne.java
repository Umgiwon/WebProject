package com.kh.jsp.thumb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.jsp.boardComment.model.service.BoardCommentService;
import com.kh.jsp.boardComment.model.vo.BoardComment;
import com.kh.jsp.thumb.model.service.ThumbnailService;

/**
 * Servlet implementation class ThumbnailSelectOne
 */
@WebServlet("/selectOne.tn")
public class ThumbnailSelectOne extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailSelectOne() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*
		 * 만약 DB로부터 가져올 정보가 여러 개라면? 
		 * ( 예시 : 게시글과 첨부파일 여러 개 )
		 * 
		 * 1. 두 객체를 모두 저장할 수 있는 통합형 VO를 만드는 방법
		 *  - Thumbnail 과 Attachment의 모든 변필드변수를 가지는 class
		 *  - VO 제작에 손은 많이 가지만 한 번 만들어 두면
		 *    편리하게 사용할 수 있음 (getter / setter)
		 *  - 객체의 크기가 커지면 메모리의 사용량이 늘어난다.
		 *  - 서비스가 느려질 수 있다.
		 *  
		 *  
		 * 2. Map 객체를 활용하여 key를 클래스 이름으로, value를 조회한 결과로
		 *     하여 원하는 값들만 따로 하나씩 담아 가져오는 방법
		 *     (예시 : map.put("usertId", rs.getString());
		 *  - 별도의 setter, getter 등과 같은 메소드 없이도(VO 없이도)
		 *    데이터를 원하는 모양으로 저장할 수 있다.
		 *  - key를 통해 데이터를 간접 접근하기 때문에 실제 내용이 무엇이 들어 있는지, 
		 *    어떤 key가 있는지 확인하기 어렵다.
		 */
		
		HashMap<String, Object> thumb = null;
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		ThumbnailService service = new ThumbnailService();
		
		thumb = service.selectOne(bno);
		
		
		
		BoardCommentService commentService = new BoardCommentService(); // 댓글 관련 
		
		ArrayList<BoardComment> clist = commentService.selectList(bno);
		
		String page = "";
		
		if(thumb != null && thumb.get("thumbnail") != null) {
			
			request.setAttribute("thumbnail", thumb.get("thumbnail"));
			request.setAttribute("attList", thumb.get("list"));
			request.setAttribute("clist", clist);
			
			page = "views/thumb/thumbDetail.jsp";
		} else {
			
			request.setAttribute("error-msg", "사진 게시글 상세보기 실패!");
			
			page = "views/common/errorPage.jsp";
		}
		
		request.getRequestDispatcher(page).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
