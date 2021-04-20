package com.kh.jsp.boardComment.model.service;


import static com.kh.jsp.common.JDBCTemplate.close;
import static com.kh.jsp.common.JDBCTemplate.commit;
import static com.kh.jsp.common.JDBCTemplate.getConnection;
import static com.kh.jsp.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.jsp.boardComment.model.dao.BoardCommentDAO;
import com.kh.jsp.boardComment.model.vo.BoardComment;

public class BoardCommentService {

	private Connection con;
	
	private BoardCommentDAO dao = new BoardCommentDAO();
	
	public int insertComment(BoardComment comment) {
		con = getConnection();
		
		int result = dao.insertComment(con, comment);
		
		if(result > 0) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}

	public ArrayList<BoardComment> selectList(int bno) {
		con = getConnection();
		
		ArrayList<BoardComment> clist = dao.selectList(con, bno);
		
		close(con);
		
		return clist;
	}

	public int updateComment(BoardComment bco) {
		con = getConnection();
		
		int result = dao.updateComment(con, bco);
		
		if(result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public int deleteComment(int cno) {
		con = getConnection();
		
		int result = dao.deleteComment(con, cno);
		
		if( result > 0 ) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
		
	
	}
	
	
	
	
	
	
	
}


