package com.kh.jsp.thumb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.jsp.common.MyRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ThumbnailInsert
 */
@WebServlet("/insert.tn")
public class ThumbnailInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String savePath = request.getServletContext().getRealPath("/resources/thumb");
		
		int maxSize = 1024 * 1024 * 10;
		
		if( ! ServletFileUpload.isMultipartContent(request)) {
			
			request.setAttribute("error-msg", "멀티파트 전송이 아닙니다.");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		MultipartRequest mr = new MultipartRequest( request, savePath, maxSize, 
													"UTF-8", new MyRenamePolicy());
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
