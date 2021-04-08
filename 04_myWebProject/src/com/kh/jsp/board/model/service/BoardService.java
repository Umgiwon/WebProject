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

}
