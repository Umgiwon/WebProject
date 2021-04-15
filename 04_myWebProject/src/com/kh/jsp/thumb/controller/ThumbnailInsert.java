package com.kh.jsp.thumb.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.jsp.common.MyRenamePolicy;
import com.kh.jsp.thumb.model.service.ThumbnailService;
import com.kh.jsp.thumb.model.vo.Attachment;
import com.kh.jsp.thumb.model.vo.Thumbnail;
import com.oreilly.servlet.MultipartRequest;

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
		
		// 파일 명 리스트 객체
		ArrayList<String> changeNames = new ArrayList<>();
		
		// 화면의 파일태그 이름(name) 속성 가져오기 Enumeration --> Iterator
		Enumeration<String> tagNames = mr.getFileNames();
		
		while( tagNames.hasMoreElements() ) {
			// 파일 name 속성을 하나씩 추출하여 해당 파일의 이름을 가져온다
			
			String tagName = tagNames.nextElement();
			
			changeNames.add(mr.getFilesystemName(tagName));
			
			System.out.println(tagName + " : " + changeNames);
			
		}
		
		Thumbnail t = new Thumbnail();
		
		t.setBtitle(mr.getParameter("btitle"));
		t.setBcontent(mr.getParameter("bcontent"));
		t.setUserId(mr.getParameter("userId"));
		
		// 첨부 파일 목록 생성
		ArrayList<Attachment> list = new ArrayList<>();
		
		// 리스트에 파일 이름 저장하기
		for(int i = changeNames.size() - 1 ; i >= 0 ; i-- ) { 
			
			Attachment a = new Attachment();
			
			a.setFilename(changeNames.get(i));
			
			if( i == changeNames.size() -1 ) { // i 가 처음 반복 되는 수라면, 대표사진이라면 
				a.setFlevel(1);
			} else {
				a.setFlevel(2);
			}
			
			list.add(a);
		}
		
		t.setAttList(list);
		
		ThumbnailService service = new ThumbnailService();
		
		int result = service.insertThumbnail(t);
		
		if ( result > 0) {
			
			response.sendRedirect("selectList.tn");
			
		} else {
			
			for(int i = 0; i < changeNames.size(); i++) {
				
				new File(savePath + "/" + changeNames.get(i)).delete();
				
			}
			
			request.setAttribute("error-msg", "사진 게시글 등록 실패");
			
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
