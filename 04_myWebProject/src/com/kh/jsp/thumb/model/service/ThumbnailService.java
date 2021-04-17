package com.kh.jsp.thumb.model.service;

import static com.kh.jsp.common.JDBCTemplate.close;
import static com.kh.jsp.common.JDBCTemplate.commit;
import static com.kh.jsp.common.JDBCTemplate.getConnection;
import static com.kh.jsp.common.JDBCTemplate.rollback;

import java.io.File;
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

	public HashMap<String, Object> getUpdateView(int bno) {
		con = getConnection();
		
		HashMap<String, Object> map = dao.selectOne(con, bno);
		
		close(con);
		
		return map;
	}

	public int updateThumbnail(Thumbnail t, ArrayList<Attachment> list, ArrayList<Attachment> newList) {
		int result = 0;
		
		con = getConnection();
		
		int result1 = dao.updateThumbnail(con, t);	// 게시글 내용 수정
		
		if ( result1 > 0) {

			int result2 = 0;
			
			// 수정용 반복
			for(Attachment a : list ) {
				result2 = dao.updateAttachment(con, a);
				
				if( result2 == 0) {
					break;
				}
			}
			
			// 새 파일 추가용 반복
			for(Attachment a : newList) {
				result2 = dao.insertAttachment(con, a);
				
				if(result2 == 0) {
					break;
				}
			}
			
			if( result2 > 0) {
				commit(con);
				result = 1; // 정상처리
			} else {
				rollback(con);
			}
			
		}
		
		close(con);
		
		return result;
	}

	public int deleteThumbnail(int bno) {
		
		con = getConnection();
		
		// 게시글 삭제 (Status 변경 'Y' --> 'N')
		int result = dao.deleteThumbnail(con, bno);
		
		if(result > 0) {
			// 첨부 파일 삭제
			result = dao.deleteAttachment(con, bno); 
					
			if( result > 0) commit(con);
			
			else rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public int deleteOne(int fno, String savePath) {
		con = getConnection();
		
		String filename = dao.selectFilename(con, fno);
		
		int result = dao.deleteOne(con, fno);
		
		if ( result > 0 ) {
			commit(con);
			
			File file = new File(savePath + "/" + filename);
			
			file.delete();
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}
	
	
}


