package com.kh.jsp.thumb.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

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
 * Servlet implementation class ThumbnailUpdate
 */
@WebServlet("/update.tn")
public class ThumbnailUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String savePath = request.getServletContext().getRealPath("/resources/thumb");
		
		int maxSize = 1024 * 1024 * 10; // 10MB
		
		if ( ! ServletFileUpload.isMultipartContent(request) ) {
			
			request.setAttribute("error-msg", "멀티파트 전송이 아닙니다!");
			
			request.getRequestDispatcher("views/common/errorPage.jsp")
			       .forward(request, response);
			
		}
		
		MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8",
												   new MyRenamePolicy());
		
		int bno = Integer.parseInt(mr.getParameter("bno"));
		
		ThumbnailService service = new ThumbnailService();
		
		// 게시글의 원본 가져오기
		HashMap<String, Object> map = service.getUpdateView(bno);
		
		ArrayList<String> changeNames = new ArrayList<>();
		
		// 전송한 파일 처리
		Enumeration<String> files = mr.getFileNames();  // 파일 태그 네임 속성들
		
		while( files.hasMoreElements() ) {
			
			String tagName = files.nextElement();
			
			// mr.getOriginalFileName(tagName); 찐 파일 명 (바꾸기 전)
			changeNames.add(mr.getFilesystemName(tagName));
		
		}
		
		// 내용 변경 시작!
		
		Thumbnail t = (Thumbnail)map.get("thumbnail");
		
		t.setBtitle(mr.getParameter("btitle"));
		t.setBcontent(mr.getParameter("bcontent"));
		
		// 원본 사진들
		ArrayList<Attachment> list = (ArrayList<Attachment>)map.get("list");
		
		// 새롭게 추가될 사진들		
		ArrayList<Attachment> newList = new ArrayList<>();
		
		
		// 수정된 첨부파일 반복
		for(int i = changeNames.size() - 1 ; i >= 0 ; i--) {
			// 자바는 0부터 시작 / 저장된 순서가 역순이기 때문
			int j = changeNames.size() - 1 - i; // 0 , 1, 2 (정방향 순서)
			
			if( changeNames.get(i) != null && j <= list.size() - 1 ) {
				// 해당 순번의 파일 수정이 발생했다! and 원본이 가진 사진 개수 만큼 수정이 발생할 경우 
				
				// 이전 파일 삭제
				File oldFile = new File(savePath + "/" + list.get(j).getFilename());
				oldFile.delete();
				
				// 새 파일 등록
				list.get(j).setFilename(changeNames.get(i));
			} else if ( changeNames.get(i) != null && j > list.size() - 1 ) {
				// 새롭게 추가된 파일이라면!
				Attachment a = new Attachment();
				
				a.setBno(bno);
				a.setFlevel(2);
				a.setFilename(changeNames.get(i));
				
				newList.add(a);
				
				
			}
			
		}
		
		int result = service.updateThumbnail(t, list, newList);
		
		if( result > 0) {
			
			response.sendRedirect("selectList.tn");
		} else {
			
			request.setAttribute("error-msg", "게시글 수정 실패!");
			
			request.getRequestDispatcher("views/common/errorPage.jsp")
			       .forward(request, response);
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
