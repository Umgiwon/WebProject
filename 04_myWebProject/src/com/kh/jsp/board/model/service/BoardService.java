package com.kh.jsp.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.jsp.board.model.dao.BoardDAO;
import com.kh.jsp.board.model.vo.Board;
import static com.kh.jsp.common.JDBCTemplate.*;


public class BoardService {

	private Connection con;
	private BoardDAO dao = new BoardDAO();
	
	public ArrayList<Board> selectList() {
		con = getConnection();
		
		ArrayList<Board> list = dao.selectList(con);
		
		close(con);
		return list;
	}

	public int insertBoard(Board b) {
		con = getConnection();
		
		int result = dao.insertBoard(con, b);
		
		if(result >0) commit(con);
		else rollback(con);
			
		close(con);
		
		return result;
	}

	public Board selectOne(int bno) {
		con = getConnection();
		
		int result = dao.updateReadCount(con, bno);
		
		Board b = dao.selectOne(con, bno);
		
		if( result > 0 ) commit(con);
		else rollback(con);
		
		close(con);
		
		return b;
	}

	public Board updateView(int bno) {
		// 게시글 한 개의 정보를 조회하되
		// 조회수 증가 X 
		con = getConnection();
		
		Board b = dao.selectOne(con, bno);
		
		close(con);
		
		return b;
	}

}
