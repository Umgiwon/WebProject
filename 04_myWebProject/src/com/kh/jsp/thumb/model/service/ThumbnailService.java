package com.kh.jsp.thumb.model.service;

import static com.kh.jsp.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.kh.jsp.thumb.model.dao.ThumbnailDAO;
import com.kh.jsp.thumb.model.vo.Attachment;
import com.kh.jsp.thumb.model.vo.Thumbnail;

public class ThumbnailService {

	private Connection con;
	private ThumbnailDAO dao = new ThumbnailDAO();
	
	public ArrayList<Thumbnail> selectList() {
		con = getConnection();
		
		ArrayList<Thumbnail> list = dao.selectList(con);
		
		close(con);
		
		return list;
	}

	public int insertThumbnail(Thumbnail t) {
		con = getConnection();
		ArrayList<Attachment> list = t.getAttList();
		int result = 0;
		
		// 1. 사진 게시글 저장
		int result1 = dao.insertThumbnail(con,t);
		
		if ( result1 > 0 ) {
			int bno = dao.getCurrentBno(con);
			
			for(int i = 0; i < list.size(); i++ ) {
				list.get(i).setBno(bno);
			}
		}
		// 2. 첨부파일 저장
		int result2 = 0;
		
		for(int i = 0; i < list.size(); i++ ) {
			if(list.get(i) != null && list.get(i).getFilename() != null) {
				// 해당 파일 자체가 null 이 아니거나, 파일 이름이 null이 아닐 때
				// 즉, 파일을 알맞게 추가했다면
				
				result2 = dao.insertAttachment(con, list.get(i));
				
				if(result2 == 0 ) break; // 중간에 잘못 처리된 첨부파일이 있다면 반복 중지
			} else {
				result2 = 1; // 정상으로 변경
			}
		}
		
		if( result1 > 0 && result2 > 0) {
			commit(con);
			result = 1;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public HashMap<String, Object> selectOne(int bno) {
		con = getConnection();
		
		HashMap<String, Object> map = dao.selectOne(con, bno);
		
		// 조회수 증가 DAO - 부재중 - 
		
		close(con);
		
		return map;
	}
	
	
	
	
	
	
	
}
