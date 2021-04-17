package com.kh.jsp.thumb.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.jsp.thumb.model.service.ThumbnailService;

/**
 * Servlet implementation class ThumbnailUpdateView
 */
@WebServlet("/updateView.tn")
public class ThumbnailUpdateView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailUpdateView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		HashMap<String, Object> map = null; 
		
		ThumbnailService service = new ThumbnailService();
		
		map = service.getUpdateView(bno);	// 서비스로 go~!
		
		// 서비스에서 돌아와서 map 객체 처리
		
		request.setAttribute("thumbnail", map.get("thumbnail"));
		request.setAttribute("attList", map.get("list"));
		
		request.getRequestDispatcher("views/thumb/thumbUpdate.jsp").forward(request, response);
		
		
		
		
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
