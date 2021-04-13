package com.kh.jsp.thumb.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.jsp.thumb.model.service.ThumbnailService;
import com.kh.jsp.thumb.model.vo.Thumbnail;

/**
 * Servlet implementation class ThumbnailSelectList
 */
@WebServlet("/selectList.tn")
public class ThumbnailSelectList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailSelectList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Thumbnail> list = new ArrayList<>();
		ThumbnailService service = new ThumbnailService();
		
		list = service.selectList();
	
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/thumb/thumbList.jsp").forward(request, response);
		
	
	
	
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
